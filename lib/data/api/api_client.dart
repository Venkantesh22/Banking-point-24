import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/constants.dart';
import '../models/response/error_response.dart';

class ApiClient extends GetConnect implements GetxService {
  final String appBaseUrl;

  final SharedPreferences sharedPreferences;

  String? token;

  Map<String, String>? _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    try {
      print("Base URL = $appBaseUrl");

      baseUrl = appBaseUrl;
      timeout = const Duration(seconds: 30);
      token = sharedPreferences.getString(AppConstants.token) ?? '';
      if (kDebugMode) {
        print('Token: $token');
      }
      _mainHeaders = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
    } catch (e) {
      log('******** ${e.toString()} ********+', name: "ERROR AT ApiClient()");
    }
  }

  void updateHeader(String? token) {
    this.token = token;

    _mainHeaders = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token ?? ''}',
    };
  }

  Future<Response> getData(
    String uri,
    String name, {
    Map<String, dynamic>? query,
    String? contentType,
    Map<String, String>? headers,
    Function(dynamic)? decoder,
  }) async {
    try {
      if (kDebugMode) {
        log('====> GetX Call: $uri\nToken: $token');
      }
      Response response = await get(
        uri,
        contentType: contentType,
        query: query,
        headers: headers ?? _mainHeaders,
        decoder: decoder,
      );
      log("====> API Header: ${headers ?? _mainHeaders}", name: "apiHeaders");
      // log('aasdas'+response.bodyString!+'aasdas',name: '$uri');

      log('====> GetX Response: [${response.statusCode}] $uri', name: name);
      log('${response.bodyString}', name: name);
      response = handleResponse(response);
      if (kDebugMode) {
        // log('====> GetX Response: [${response.statusCode}] $u ri\n${uri.contains('astros') || uri.contains('shop') || uri.contains('shop') ? response.body[0] : response.body}');
      }
      return response;
    } catch (e) {
      // log("$e",name: 'ERROR $uri');
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(
    String uri,
    String name,
    dynamic body, {
    Map<String, dynamic>? query,
    String? contentType,
    Map<String, String>? headers,
    Function(dynamic)? decoder,
    Function(double)? uploadProgress,
  }) async {
    try {
      final currentToken =
          sharedPreferences.getString(AppConstants.token) ?? '';

      updateHeader(currentToken);

      // ------------------------------------------------------------
      // BUILD FULL URL
      // ------------------------------------------------------------

      final String base = baseUrl ?? '';

      String fullUrl = '$base$uri';

      if (query != null && query.isNotEmpty) {
        final queryString = query.entries
            .map(
              (entry) => '${Uri.encodeQueryComponent(entry.key)}='
                  '${Uri.encodeQueryComponent(entry.value.toString())}',
            )
            .join('&');

        fullUrl = '$fullUrl?$queryString';
      }

      // ------------------------------------------------------------
      // LOG REQUEST
      // ------------------------------------------------------------

      if (kDebugMode) {
        log('========================================');
        log('API REQUEST');
        log('Method      : POST');
        log('Base URL    : $base');
        log('URI         : $uri');
        log('Full URL    : $fullUrl');
        log('Token       : $currentToken');

        if (body is FormData) {
          log(
            'Body Fields : ${body.fields.map(
                  (e) => '${e.key}=${e.value}',
                ).join(', ')}',
          );

          log(
            'Body Files  : ${body.files.map(
                  (e) => '${e.key}=${e.value.filename}',
                ).join(', ')}',
          );
        } else {
          log('Body        : $body');
        }

        log('Headers     : ${headers ?? _mainHeaders}');
        log('Query       : $query');
        log('========================================');
      }

      // ------------------------------------------------------------
      // API CALL
      // ------------------------------------------------------------

      Response response = await post(
        uri,
        body,
        query: query,
        contentType: contentType,
        headers: headers ?? _mainHeaders,
        decoder: decoder,
        uploadProgress: uploadProgress,
      );

      // ------------------------------------------------------------
      // LOG RESPONSE
      // ------------------------------------------------------------

      log(
        '====> GetX Response: [${response.statusCode}] $fullUrl\n'
        '${response.bodyString}',
        name: name,
      );

      response = handleResponse(response);

      return response;
    } catch (e, stackTrace) {
      log(
        '$e\n$stackTrace',
        name: 'ERROR AT POST',
      );

      return Response(
        statusCode: 1,
        statusText: e.toString(),
      );
    }
  }

  Future<Response> putData(
    String uri,
    String name,
    dynamic body, {
    Map<String, dynamic>? query,
    String? contentType,
    Map<String, String>? headers,
    Function(dynamic)? decoder,
    Function(double)? uploadProgress,
  }) async {
    try {
      if (kDebugMode) {
        print('====> GetX Call: $uri\nToken: $token');
        print('====> GetX Body: $body');
      }
      Response response = await put(
        uri,
        body,
        query: query,
        contentType: contentType,
        headers: headers ?? _mainHeaders,
        decoder: decoder,
        uploadProgress: uploadProgress,
      );
      response = handleResponse(response);
      log('====> GetX Response: [${response.statusCode}] $uri\n${response.bodyString}');
      if (kDebugMode) {
        // print('====> GetX Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> patchData(
    String uri,
    String name,
    dynamic body, {
    Map<String, dynamic>? query,
    String? contentType,
    Map<String, String>? headers,
    Function(dynamic)? decoder,
    Function(double)? uploadProgress,
  }) async {
    try {
      if (kDebugMode) {
        print('====> GetX Call: $uri\nToken: $token');
        print('====> GetX Body: $body');
      }
      Response response = await patch(
        uri,
        body,
        query: query,
        contentType: contentType,
        headers: headers ?? _mainHeaders,
        decoder: decoder,
        uploadProgress: uploadProgress,
      );
      response = handleResponse(response);
      log('====> GetX Response: [${response.statusCode}] $uri\n${response.bodyString}');
      if (kDebugMode) {
        // print('====> GetX Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> deleteData(
    String uri,
    String name, {
    Map<String, dynamic>? query,
    String? contentType,
    Map<String, String>? headers,
    Function(dynamic)? decoder,
  }) async {
    try {
      if (kDebugMode) {
        print('====> GetX Call: $uri\nToken: $token');
      }
      Response response = await delete(
        uri,
        headers: headers ?? _mainHeaders,
        contentType: contentType,
        query: query,
        decoder: decoder,
      );
      response = handleResponse(response);
      log('====> GetX Response: [${response.statusCode}] $uri\n${response.bodyString}');
      if (kDebugMode) {
        // print('====> GetX Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Response handleResponse(Response response) {
    Response _response = response;
    if (_response.hasError &&
        _response.body != null &&
        _response.body is! String) {
      if (_response.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse errorResponse = ErrorResponse.fromJson(_response.body);
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: errorResponse.errors[0].message);
      } else if (_response.body.toString().startsWith('{message')) {
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _response.body['message']);
      }
    } else if (_response.hasError && _response.body == null) {
      log(_response.statusCode.toString(), name: "STATUS CODE");
      _response = const Response(
          statusCode: 0,
          statusText:
              'Connection to API server failed due to internet connection');
    }
    return _response;
  }

  Future<dynamic> commonApiCall(String urlR, Map<String, dynamic> body) async {
    var postUri = Uri.parse(/*AppConstants().getBaseUrl +*/ urlR);
    log(urlR);
    log(body.toString());
    late http.Response response;
    try {
      response = await http.post(
        postUri,
        body: body,
        headers: _mainHeaders,
      );
      log('response.bodyresponse.body');
      log(response.body);
      // log(response.body.length.toString());
      // log(response.body.substring(0,response.body.length));
      log("/${response.request!.url.path.split('/').last} ============ ${response.statusCode}\n",
          name: "API SUCCESS PATH CAC");

      return response;
    } catch (e) {
      log("/${postUri.path.split('/').last} ============ " /*+ getResponseStatus(response)*/,
          name: "API FAILURE PATH CAC");
      log('+++++++ ${e.toString().replaceAll('\n', ' ')} +++++++\n',
          name:
              "API ERROR CAC(/${"${postUri.path.split('/').last} ============ " /*+ getResponseStatus(response)*/})",
          level: 1);
      return null;
    }
  }

  Future<dynamic> commonApiCallGet(String url) async {
    var postUri = Uri.parse(/*AppConstants().getBaseUrl +*/ url);
    // log(urlR);
    // log(body.toString());
    late http.Response response;
    try {
      response = await http.get(
        postUri,
        headers: _mainHeaders,
      );
      log('response.bodyresponse.body');
      log(response.body);
      // log(response.body.length.toString());
      // log(response.body.substring(0,response.body.length));
      log("/${response.request!.url.path.split('/').last} ============ ${response.statusCode}\n",
          name: "API SUCCESS PATH CAC");

      return response;
    } catch (e) {
      log("/${postUri.path.split('/').last} ============ " /*+ getResponseStatus(response)*/,
          name: "API FAILURE PATH CAC");
      log('+++++++ ${e.toString().replaceAll('\n', ' ')} +++++++\n',
          name:
              "API ERROR CAC(/${"${postUri.path.split('/').last} ============ " /*+ getResponseStatus(response)*/})",
          level: 1);
      return null;
    }
  }
}
