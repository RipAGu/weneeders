import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:winit/network/ApiService.dart';
import 'package:winit/network/model/AreaModel.dart';
import 'package:winit/network/model/PartnerDetailModel.dart';
import 'package:winit/network/model/ProjectDetailModel.dart';
import '../../../network/model/FieldModel.dart';
import '../../widget/CustomCheckboxTile.dart';

class AddViewModel extends ChangeNotifier {
  List<AreaModel> area1List = [];
  List<AreaModel> area2List = [];
  List<FieldModel> partnerFieldList = [];
  List<FieldModel> projectFieldList = [];
  List<FieldModel> partnerSkillList = [];
  List<String?> imgList = [null];
  List<String> imgPathList = [];
  bool _isRegisterSuccess = false;
  bool get isRegisterSuccess => _isRegisterSuccess;
  bool _isImageUploadSuccess = true;
  bool get isImageUploadSuccess => _isImageUploadSuccess;

  void initData() {
    area1List = [];
    area2List = [];
    partnerFieldList = [];
    projectFieldList = [];
    partnerSkillList = [];
    imgList = [null];
    imgPathList = [];
    _isRegisterSuccess = true;
    methodList = [
      FieldModel(idx: 1, name: '기간제', isChecked: false),
      FieldModel(idx: 2, name: '도급제', isChecked: false),
    ];
    notifyListeners();
  }

  List<FieldModel> methodList = [
    FieldModel(idx: 1, name: '기간제'),
    FieldModel(idx: 2, name: '도급제'),
  ];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final ApiService apiService = ApiService();

  void toggleFieldCheckbox(int index) {
    partnerFieldList[index].isChecked = !partnerFieldList[index].isChecked;
    print(partnerFieldList[index].isChecked);
    notifyListeners();
  }

  void toggleProjectFieldCheckbox(int index) {
    projectFieldList[index].isChecked = !projectFieldList[index].isChecked;
    print(projectFieldList[index].isChecked);
    notifyListeners();
  }

  void toggleTechCheckbox(int index) {
    partnerSkillList[index].isChecked = !partnerSkillList[index].isChecked;
    print(partnerSkillList[index].isChecked);
    notifyListeners();
  }

  void toggleLocalBtn(int index) {
    //다른값들은 모두 false로 변경
    for (int i = 0; i < area1List.length; i++) {
      if (i != index) {
        area1List[i].isChecked = false;
      } else {
        area1List[i].isChecked = true;
        getArea2(area1List[i].idx);
      }
    }
    notifyListeners();
  }

  void toggleRegionBtn(int index) {
    //다른값들은 모두 false로 변경
    for (int i = 0; i < area2List.length; i++) {
      if (i != index) {
        area2List[i].isChecked = false;
      } else {
        area2List[i].isChecked = true;
      }
    }
    notifyListeners();
  }

  void toggleMethodBtn(int index) {
    //다른값들은 모두 false로 변경
    for (int i = 0; i < methodList.length; i++) {
      if (i != index) {
        methodList[i].isChecked = false;
      } else {
        methodList[i].isChecked = true;
      }
    }
    notifyListeners();
  }

  void addImg() {
    pickImg();
  }

  Future<void> pickImg() async {
    //이미지 선택 함수
    _isLoading = true;
    notifyListeners();
    final pickedFile = ImagePicker();
    final List<XFile> images = await pickedFile.pickMultiImage();

    for (var image in images) {
      await uploadImg(image);
    }
    notifyListeners();
    //1초 기다림
    _isLoading = false;
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

  void setIsImageUploadSuccess(bool value) {
    _isImageUploadSuccess = value;
    notifyListeners();
  }

  Future<void> getPartnerField() async {
    imgList = [null];
    imgPathList = [];
    partnerFieldList = [];
    try {
      final response = await apiService.getPartnerField();
      partnerFieldList = (response.data as List)
          .map((item) => FieldModel.fromJson(item))
          .toList();
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> getProjectField() async {
    projectFieldList = [];
    try {
      final response = await apiService.getProjectField();
      projectFieldList = (response.data as List)
          .map((item) => FieldModel.fromJson(item))
          .toList();
      notifyListeners();
    } on DioException catch (e) {
      print(e.response!.data);
    }
  }

  Future<void> getPartnerSkill() async {
    partnerSkillList = [];
    try {
      final response = await apiService.getPartnerSkill();
      partnerSkillList = (response.data as List)
          .map((item) => FieldModel.fromJson(item))
          .toList();
      notifyListeners();
      print(response.data);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> getArea1() async {
    area1List = [];
    try {
      final response = await apiService.getArea1();
      area1List = (response.data as List)
          .map((item) => AreaModel.fromJson(item))
          .toList();
      //idx 순으로 리스트정렬
      area1List.sort((a, b) => a.idx.compareTo(b.idx));
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> getArea2(int area1Idx) async {
    area2List = [];
    try {
      final response = await apiService.getArea2(area1Idx);
      area2List = (response.data as List)
          .map((item) => AreaModel.fromJson(item))
          .toList();
      print(area2List);
      notifyListeners();
    } on DioException catch (e) {
      print(e.response!.data);
    }
  }

  Future<void> registerPartner(String career, String method) async {
    final Map<String, dynamic> body = {
      "career": career,
      "fieldIdxList": getSelectedField(),
      "skillIdxList": getSelectedSkill(),
      "method": method,
      "depth2Idx": getSelectedArea(),
      //imglist의 0번째 인덱스 제외하고 전송
      "imgPathList": imgPathList.isEmpty ? null : imgPathList,
    };
    try {
      final response = await apiService.postPartner(body);
      if (response.statusCode == 200) {
        _isRegisterSuccess = true;
        notifyListeners();
      } else {
        _isRegisterSuccess = false;
        print(response.statusCode);
        notifyListeners();
      }
    } on DioException catch (e) {
      print(e.response!.data);
    }
  }

  Future<void> registerProject(String startDate, String endDate, String method,
      String demandSkill, String amount) async {
    final Map<String, dynamic> body = {
      "startDate": startDate,
      "endDate": endDate,
      "methodType": getSelectedMethod(),
      "fieldIdxList": getSelectedProjectField(),
      "depth2Idx": getSelectedArea(),
      "method": method,
      "demandSkill": demandSkill,
      "amount": amount,
      "imgPathList": imgPathList.isEmpty ? null : imgPathList,
    };
    print("바디 $body");
    try {
      final response = await apiService.postProject(body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        _isRegisterSuccess = true;
        notifyListeners();
      } else {
        _isRegisterSuccess = false;
        print(response.statusCode);
        notifyListeners();
      }
    } on DioException catch (e) {
      print(e.response!.data);
    }
  }

  Future<void> editProject(int projectIdx, String startDate, String endDate,
      String method, String demandSkill, String amount) async {
    final Map<String, dynamic> body = {
      "startDate": startDate,
      "endDate": endDate,
      "methodType": getSelectedMethod(),
      "fieldIdxList": getSelectedProjectField(),
      "depth2Idx": getSelectedArea(),
      "method": method,
      "demandSkill": demandSkill,
      "amount": amount,
      "imgPathList": imgPathList.isEmpty ? null : imgPathList,
    };
    try {
      final response = await apiService.editProject(projectIdx, body);
      if (response.statusCode == 201) {
        print("success");
        _isRegisterSuccess = true;
        notifyListeners();
      } else {
        _isRegisterSuccess = false;
        print(response.statusCode);
        notifyListeners();
      }
    } on DioException catch (e) {
      print(e.response!.data);
    }
  }

  Future<void> editPartner(int partnerIdx, String career, String method) async {
    final Map<String, dynamic> body = {
      "career": career,
      "fieldIdxList": getSelectedField(),
      "skillIdxList": getSelectedSkill(),
      "method": method,
      "depth2Idx": getSelectedArea(),
      //imglist의 0번째 인덱스 제외하고 전송
      "imgPathList": imgPathList.isEmpty ? null : imgPathList,
    };
    try {
      final response = await apiService.editPartner(partnerIdx, body);
      if (response.statusCode == 201) {
        _isRegisterSuccess = true;
        notifyListeners();
      } else {
        _isRegisterSuccess = false;
        print(response.statusCode);
        notifyListeners();
      }
    } on DioException catch (e) {
      print(e.response!.data);
    }
  }

  List<int> getSelectedField() {
    List<int> selectedField = [];
    for (int i = 0; i < partnerFieldList.length; i++) {
      if (partnerFieldList[i].isChecked) {
        selectedField.add((partnerFieldList[i].idx));
      }
    }
    return selectedField;
  }

  List<int> getSelectedProjectField() {
    List<int> selectedField = [];
    for (int i = 0; i < projectFieldList.length; i++) {
      if (projectFieldList[i].isChecked) {
        selectedField.add((projectFieldList[i].idx));
      }
    }
    return selectedField;
  }

  List<int> getSelectedSkill() {
    List<int> selectedSkill = [];
    for (int i = 0; i < partnerSkillList.length; i++) {
      if (partnerSkillList[i].isChecked) {
        selectedSkill.add((partnerSkillList[i].idx));
      }
    }
    return selectedSkill;
  }

  int? getSelectedArea() {
    int? selectedArea;
    for (int i = 0; i < area2List.length; i++) {
      if (area2List[i].isChecked) {
        selectedArea = area2List[i].idx;
      }
    }
    return selectedArea;
  }

  int? getSelectedMethod() {
    int? selectedMethod;
    for (int i = 0; i < methodList.length; i++) {
      if (methodList[i].isChecked) {
        selectedMethod = methodList[i].idx;
      }
    }
    return selectedMethod;
  }

  void removeImg(int index) {
    imgList.removeAt(index);
    imgPathList.removeAt(index - 1);
    notifyListeners();
  }

  void setPreviousProjectData(ProjectDetailModel previousData) {
    if (previousData.methodType == 1) {
      methodList[0].isChecked = true;
    } else {
      methodList[1].isChecked = true;
    }
    for (int i = 0; i < previousData.ProjectFieldMapping.length; i++) {
      for (int j = 0; j < projectFieldList.length; j++) {
        if (previousData.ProjectFieldMapping[i].name ==
            projectFieldList[j].name) {
          projectFieldList[j].isChecked = true;
        }
      }
    }
  }

  void setPreviousPartnerData(PartnerDetailModel previousData) {
    for (int i = 0; i < previousData.PartnerFieldMapping.length; i++) {
      for (int j = 0; j < partnerFieldList.length; j++) {
        if (previousData.PartnerFieldMapping[i].name ==
            partnerFieldList[j].name) {
          partnerFieldList[j].isChecked = true;
        }
      }
    }
    for (int i = 0; i < previousData.PartnerSkillMapping.length; i++) {
      for (int j = 0; j < partnerSkillList.length; j++) {
        if (previousData.PartnerSkillMapping[i].name ==
            partnerSkillList[j].name) {
          partnerSkillList[j].isChecked = true;
        }
      }
    }
  }
}
