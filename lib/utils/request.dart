// request
import 'package:dio/dio.dart';

// 创建一个Dio实例对象
BaseOptions options = BaseOptions(
  baseUrl: "http://localhost:8080",
);
Dio dio = Dio(options);


//customInterceptors 请求拦截器
class CustomInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("请求拦截器：${options}");
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}

// 添加拦截器
void addInterceptors() {
  dio.interceptors.add(CustomInterceptors());
}
