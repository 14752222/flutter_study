// request
import 'package:dio/dio.dart';

// 创建一个Dio实例对象
BaseOptions options = BaseOptions(
  // baseUrl: "http://localhost:8080",
  baseUrl: "https://v1.hitokoto.cn",
);
Dio dio = Dio(options);

//customInterceptors 请求拦截器
class CustomInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
   return super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    return super.onError(err, handler);
  }
}

// 添加拦截器
void addInterceptors() {
  dio.interceptors.add(CustomInterceptors());
}

//post请求

Future postRequest(String url, Map<String, dynamic> params) async {
  try {
    Response response = await dio.post(url, data: params);
    return response.data;
  } catch (e) {
    print(e);
  }
}

//get请求
Future getRequest(String url, Map<String, dynamic> params) async {
  try {
    Response response = await dio.get(url, queryParameters: params);
    return response.data;
  } catch (e) {
    print(e);
  }
}
