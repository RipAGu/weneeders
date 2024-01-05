import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

  Future<Response> getArea1() {
    try {
      return dio.get('$baseUrl/area/depth-1/all');
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> getArea2(int idx) {
    try {
      return dio.get('$baseUrl/area/depth-1/$idx/depth-2/all');
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

  Future<Response> getProjectField() {
    try {
      return dio.get('$baseUrl/field/project/all');
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

  Future<Response> getPartnerList(int page, int? filter, String? filterby) {
    //query에 페이지 전달
    try {
      if (filter != null) {
        return dio.get('$baseUrl/partner/all', queryParameters: {
          "page": page,
          "filter": filter,
          "filterby": filterby
        });
      } else {
        return dio.get('$baseUrl/partner/all', queryParameters: {"page": page});
      }
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> getProjectList(int page) {
    try {
      return dio.get('$baseUrl/project/all', queryParameters: {"page": page});
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> getUserInfo() {
    try {
      return dio.get('$baseUrl/user/my');
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> getProjectDetail(int idx) {
    try {
      return dio.get('$baseUrl/project/$idx');
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> getProjectComment(int idx) {
    try {
      //path에 idx 전달
      return dio.get(
        '$baseUrl/project/$idx/comment/all',
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> postProjectComment(int idx, String comment) {
    final Map<String, dynamic> body = {"contents": comment};
    try {
      return dio.post('$baseUrl/project/$idx/comment', data: body);
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> postProjectRepleComment(int idx, String comment) {
    final Map<String, dynamic> body = {"contents": comment};
    try {
      return dio.post('$baseUrl/project/comment/$idx/reply-comment',
          data: body);
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> getPartnerDetail(int idx) {
    try {
      return dio.get('$baseUrl/partner/$idx');
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> getPartnerComment(int idx) {
    try {
      return dio.get('$baseUrl/partner/$idx/comment/all');
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> postPartnerComment(int idx, String comment) {
    final Map<String, dynamic> body = {"contents": comment};
    try {
      return dio.post('$baseUrl/partner/$idx/comment', data: body);
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> postPartnerRepleComment(int idx, String comment) {
    final Map<String, dynamic> body = {"contents": comment};
    try {
      return dio.post('$baseUrl/partner/comment/$idx/reply-comment',
          data: body);
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> editProject(int idx, Map<String, dynamic> body) {
    try {
      return dio.put('$baseUrl/project/$idx', data: body);
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> editPartner(int idx, Map<String, dynamic> body) {
    try {
      return dio.put('$baseUrl/partner/$idx', data: body);
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> deletePartner(int idx) {
    try {
      return dio.delete('$baseUrl/partner/$idx');
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteProject(int idx) {
    try {
      return dio.delete('$baseUrl/project/$idx');
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> findEmail(String phoneToken) {
    final Map<String, dynamic> body = {"phoneToken": phoneToken};
    try {
      return dio.post('$baseUrl/user/email/find', data: body);
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> changePassword(String email, String phoneToken, String pw) {
    final Map<String, dynamic> body = {
      "email": email,
      "phoneToken": phoneToken,
      "pw": pw
    };
    try {
      return dio.post('$baseUrl/user/pw/find', data: body);
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> postChatMessage(int toUserIdx, String message) {
    final Map<String, dynamic> body = {
      "toUserIdx": toUserIdx,
      "message": message
    };
    try {
      return dio.post('$baseUrl/chatting', data: body);
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> getChatMessage(int roomIdx, int lastChattingIdx) {
    try {
      return dio.get('$baseUrl/chatting/room/$roomIdx/all',
          queryParameters: {"last-chatting-idx": lastChattingIdx});
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> getChattingRoomList() {
    try {
      return dio.get('$baseUrl/chatting/room/all');
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> getSkillDataList(int page) {
    try {
      return dio.get('$baseUrl/techpost/all', queryParameters: {"page": page});
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> getSkillDataDetail(int idx) {
    try {
      return dio.get('$baseUrl/techpost/$idx');
    } on DioException catch (e) {
      rethrow;
    }
  }
}
