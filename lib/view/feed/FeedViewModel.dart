import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:winit/network/ApiService.dart';
import 'package:winit/network/model/FeedCommentModel.dart';
import 'package:winit/network/model/FeedDetailModel.dart';

import '../../network/model/FeedListModel.dart';

class FeedViewModel with ChangeNotifier {
  final ApiService apiService = ApiService();
  List<FeedListModel> feedList = [];
  List<FeedCommentModel> feedCommentList = [];
  late FeedDetailModel feedDetailData;
  List<String?> imgList = [null];
  List<String> imgPathList = [];
  int page = 1;
  bool _isLoadEnd = false;
  bool get isLoadEnd => _isLoadEnd;
  bool isRepleOn = false;
  int repleIndex = 0;
  bool _isImgLoading = false;
  bool get isImgLoading => _isImgLoading;
  bool _isImageUploadSuccess = true;
  bool get isImageUploadSuccess => _isImageUploadSuccess;
  bool _isAddSuccess = false;
  bool get isAddSuccess => _isAddSuccess;
  bool _isDeleteSuccess = false;
  bool get isDeleteSuccess => _isDeleteSuccess;

  Future<void> init() async {
    page = 1;
    feedList = [];
    _isLoadEnd = false;
    await getFeedList();
  }

  Future<void> addInit() async {
    imgList = [null];
    imgPathList = [];
  }

  Future<void> getFeedList() async {
    try {
      final response = await apiService.getFeedList(page);
      if ((response.data as List).isEmpty) {
        _isLoadEnd = true;
      } else {
        for (var item in response.data) {
          DateTime date = DateTime.parse(item['createdAt']);
          String formattedDate = "${date.year}-${date.month}-${date.day}";
          item['createdAt'] = formattedDate;
          if (item['thumbnail'] != null) {
            item['thumbnail'] = "http://13.125.70.49" + item['thumbnail'];
          }
          feedList.add(FeedListModel.fromJson(item));
        }
      }
      page++;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getFeedDetail(int idx) async {
    try {
      final response = await apiService.getFeedDetail(idx);
      feedDetailData = FeedDetailModel.fromJson(response.data);
      print(feedDetailData);
      feedDetailData.createdAt = feedDetailData.createdAt
          .split("T")[0]; //2023-12-31T15:00:00.000Z 형식을 2023-12-31 형식으로 바꿔줌
      for (int i = 0; i < feedDetailData.imgList.length; i++) {
        feedDetailData.imgList[i] =
            "http://13.125.70.49${feedDetailData.imgList[i]}";
        print(response.data);
      }
      notifyListeners();
    } on DioException catch (e) {
      print(e.response!.data);
    }
  }

  Future<void> getFeedComment(int idx) async {
    feedCommentList = [];
    try {
      final response = await apiService.getFeedComment(idx);
      log(response.data.toString());
      feedCommentList = (response.data as List)
          .map((e) => FeedCommentModel.fromJson(e))
          .toList();
      for (int i = 0; i < feedCommentList.length; i++) {
//월 일 추출
        String month = feedCommentList[i].createdAt.split("-")[1];
        String day = feedCommentList[i].createdAt.split("-")[2].split("T")[0];
        feedCommentList[i].createdAt = "$month월$day일";

        for (int j = 0; j < feedCommentList[i].replyCommentList.length; j++) {
          String month =
              feedCommentList[i].replyCommentList[j].createdAt.split("-")[1];
          String day = feedCommentList[i]
              .replyCommentList[j]
              .createdAt
              .split("-")[2]
              .split("T")[0];
          feedCommentList[i].replyCommentList[j].createdAt = "$month월$day일";
        }
      }
      notifyListeners();
    } on DioException catch (e) {
      print(e);
    }
  }

  Future<void> postFeedComment(int idx, String contents) async {
    try {
      final response = await apiService.postFeedComment(idx, contents);
      getFeedComment(idx);
      log(response.data.toString());
      notifyListeners();
    } on DioException catch (e) {
      print(e);
    }
  }

  Future<void> postFeedRepleComment(int projectIdx, String contents) async {
    try {
      final response =
          await apiService.postFeedRepleComment(repleIndex, contents);
      getFeedComment(projectIdx);
      log(response.data.toString());
      notifyListeners();
    } on DioException catch (e) {
      print(e);
    }
  }

  Future<void> pickImg() async {
    _isImgLoading = true;
    notifyListeners();
    final pickedFile = ImagePicker();
    final List<XFile> images = await pickedFile.pickMultiImage();
    for (var image in images) {
      await uploadImg(image);
    }
    _isImgLoading = false;
    notifyListeners();
  }

  Future<void> uploadImg(XFile image) async {
    var multipartFile = await MultipartFile.fromFile(image.path,
        contentType: MediaType('image', 'jpg'));
    try {
      final response = await apiService.uploadImg(multipartFile);
      imgPathList.add(response.data['path']);
      imgList.add(image.path);
    } on DioException catch (e) {
      print(e.response!.data);
      _isImageUploadSuccess = false;
    }
  }

  Future<void> addFeed(String title, String contents) async {
    final Map<String, dynamic> body = {
      "title": title,
      "contents": contents,
      "imgList": imgPathList.isEmpty ? null : imgPathList,
    };
    try {
      final response = await apiService.postFeed(body);
      if (response.statusCode == 200) {
        _isAddSuccess = true;
      } else {
        _isAddSuccess = false;
      }
      log(response.data.toString());

      notifyListeners();
    } on DioException catch (e) {
      print(e.response!.data);
      _isAddSuccess = false;
      notifyListeners();
    }
  }

  Future<void> editFeed(int idx, String title, String contents) async {
    final Map<String, dynamic> body = {
      "title": title,
      "contents": contents,
      "imgList": imgPathList.isEmpty ? null : imgPathList,
    };
    try {
      final response = await apiService.editFeed(idx, body);
      if (response.statusCode == 201) {
        _isAddSuccess = true;
      } else {
        _isAddSuccess = false;
        print(response.data);
      }
      notifyListeners();
    } on DioException catch (e) {
      print(e.response!.data);
      _isAddSuccess = false;
      notifyListeners();
    }
  }

  Future<void> deleteFeed(int idx) async {
    try {
      final response = await apiService.deleteFeed(idx);
      if (response.statusCode == 201) {
        _isDeleteSuccess = true;
      } else {
        _isDeleteSuccess = false;
      }
    } on DioException catch (e) {
      _isDeleteSuccess = false;
    }
    notifyListeners();
  }

  void setIsImageUploadSuccess(bool value) {
    _isImageUploadSuccess = value;
    notifyListeners();
  }

  void removeImg(int index) {
    imgList.removeAt(index);
    imgPathList.removeAt(index - 1);
    notifyListeners();
  }

  void setRepleOn(int idx) {
    print("on");
    isRepleOn = true;
    repleIndex = idx;
  }

  void setRepleOff() {
    print("off");
    isRepleOn = false;
  }
}
