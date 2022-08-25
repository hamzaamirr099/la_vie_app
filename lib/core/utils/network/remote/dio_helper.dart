import 'package:dio/dio.dart';
import 'package:la_vie/core/shared/constants.dart';

class DioHelper{
  static Dio? dio;

  static init()
  {
    dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          receiveDataWhenStatusError: true,
        )
    );
  }

  static Future<Response> getData(
      {
        required String url,
         Map<String, dynamic>? query,
        String? token

      })
  async
  {
    dio!.options.headers =
    {
      "Content-Type" : "application/json",
      "Accept" : "*/*",
      'Authorization' : 'Bearer ${token ?? ''}',
    };
    return await dio!.get(
      url,
      queryParameters: query,

    );
  }

  static Future<Response> postData(
      {
        required String url,
        required Map<String, dynamic> data,
        Map<String, dynamic>? query,
        String? token

      })
  async
  {
    dio!.options.headers =
    {
      "Content-Type" : "application/json",
      "Accept" : "*/*",
      'Authorization' : 'Bearer ${token ?? ''}',

    };
    return await dio!.post(
      url,
      queryParameters: query,
      data: data,

    );
  }


  static Future<Response> patchData(
      {
        required String url,
        required Map<String, dynamic>? data,
        String? token

      })
  async
  {
    dio!.options.headers =
    {
      "Content-Type" : "application/json",
      "Accept" : "*/*",
      'Authorization' : 'Bearer ${token ?? ''}',
    };
    return await dio!.patch(
      url,
      data: data,
    );
  }

  // static Future<Response> fetchData(
  //     {
  //       required String url,
  //       required Map<String, dynamic> data,
  //       Map<String, dynamic>? query,
  //       String? token
  //
  //     })
  // async
  // {
  //   dio!.options.headers =
  //   {
  //     "Content-Type" : "application/json",
  //     "Accept" : "*/*",
  //     'Authorization' : 'Bearer ${token ?? ''}',
  //   };
  //   return await dio!.fetch()
  // }
}