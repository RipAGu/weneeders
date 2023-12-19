import 'package:dio/dio.dart';
import 'package:winit/network/model/TestModel.dart';

class ApiService {
  Dio dio = Dio();

  ApiService() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Do something before request is sent
          print('REQUEST[${options.method}] => PATH: ${options.path}');
          return handler.next(options); //continue
        },
      ),
    );
  }
  Future<TestModel> getTest() async {
    try {
      Response response =
          await dio.get('https://jsonplaceholder.typicode.com/posts/1');
      return await TestModel.fromJson(response.data);
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
