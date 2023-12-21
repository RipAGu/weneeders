import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:winit/network/model/TestModel.dart';

class ApiService {
  Dio dio = Dio(BaseOptions(
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  //baseUrl 설정
  final String baseUrl = 'http://13.125.70.49:80';

  ApiService() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Do something before request is sent
          return handler.next(options); //continue
        },
      ),
    );
  }
  Future<List<TestModel>> getTest() async {
    try {
      Response response = await dio.get('$baseUrl/tos/all');
      List<TestModel> testModels =
          (response.data as List).map((i) => TestModel.fromJson(i)).toList();
      return testModels;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<Response> emailDuplicateCheck(String email) async {
    try {
      return await dio
          .post('$baseUrl/user/email/duplicate', data: {"email": email});
    } on DioException catch (e) {
      print(e);
      throw e;
    }
  }

  Future<Response> nickNameDuplicateCheck(String nickName) async {
    try {
      return await dio.post('$baseUrl/user/nickname/duplicate',
          data: {"nickname": nickName});
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Future<Response> phoneVerify(String phoneNumber, int type) async {
    final Map<String, dynamic> body = {
      "phoneNumber": phoneNumber,
      "type": type
    };
    try {
      return await dio.post('$baseUrl/auth/phone/verification/send',
          data: body);
    } on DioException catch (e) {
      rethrow;
    }
  }
}
