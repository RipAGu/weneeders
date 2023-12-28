import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:winit/network/model/TestModel.dart';

class ApiService {
  Dio dio = Dio(BaseOptions(
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  //baseUrl 설정
  final String baseUrl = 'http://13.125.70.49:80';

  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  ApiService() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? token = await secureStorage.read(key: "token");

          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }
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

  Future<Response> phoneVerifyCheck(
      String phoneNumber, String code, int type) async {
    final Map<String, dynamic> body = {
      "phoneNumber": phoneNumber,
      "code": code,
      "type": type
    };
    print(body);
    try {
      return await dio.post('$baseUrl/auth/phone/verification/check',
          data: body);
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> register(String email, String phoneToken, String password,
      String nickName, String name, int userType) {
    print(userType);
    final Map<String, dynamic> body = {
      "email": email,
      "phoneToken": phoneToken,
      "pw": password,
      "name": name,
      "nickname": nickName,
      "userType": userType
    };
    try {
      return dio.post('$baseUrl/user', data: body);
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> login(String email, String pw) {
    final Map<String, dynamic> body = {"email": email, "pw": pw};
    try {
      return dio.post('$baseUrl/auth', data: body);
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> getProjectField() {
    try {
      return dio.get('$baseUrl/field/project/all');
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> getArea1() {
    try {
      return dio.get('$baseUrl/area/depth-1/all');
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> getArea2(int idx) {
    print(idx);
    try {
      return dio.get('$baseUrl/area/depth-1/$idx/depth-2/all');
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> getProjectList() {
    try {
      return dio.get('$baseUrl/project/all');
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> postProject(Map<String, dynamic> body) {
    try {
      return dio.post('$baseUrl/project', data: body);
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> postPartner(Map<String, dynamic> body) {
    try {
      print(body);
      return dio.post('$baseUrl/partner', data: body);
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> getPartnerField() {
    try {
      return dio.get('$baseUrl/field/partner/all');
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> getPartnerSkill() {
    try {
      return dio.get('$baseUrl/partner/skill/all');
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> uploadImg(MultipartFile img) {
    FormData formData = FormData.fromMap({
      "img": img,
    });
    try {
      return dio.post('$baseUrl/upload/img',
          data: formData,
          options: Options(
            headers: {
              'Content-Type': 'multipart/form-data',
            },
          ));
    } on DioException catch (e) {
      rethrow;
    }
  }
}
