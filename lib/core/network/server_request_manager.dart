import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/network/urls.dart';

enum RequestTypes{
  post,get,del,put,patch
}

class ServerRequestManager{
  final Dio dio;
  ServerRequestManager(this.dio);

  Future<Map<String,dynamic>> sendRequest(RequestTypes type,String url, dynamic body, {bool checkResponse = true, bool showLog = false,Function? onSendProgress,bool fullUrl = false}) async {
    String baseUrl = fullUrl ? "" : AppUrls.baseUrl;
    try {
      Response response;
      switch (type){
        case RequestTypes.post:
          response = await dio.post(
              baseUrl+url,
              data: body,
              onSendProgress: onSendProgress==null ?  null : (int sent, int total){
                onSendProgress(sent,total);
              }
          );
          break;
        case RequestTypes.get:
          response = await dio.get(
            baseUrl+url,
            queryParameters: body,
          );
          break;
        case RequestTypes.del:
          response = await dio.delete(
              baseUrl+url,
              data: body
          );
          break;
        case RequestTypes.put:
          response = await dio.put(
            baseUrl+url,
            data: body,
          );
          break;
        case RequestTypes.patch:
          response = await dio.patch(
            baseUrl+url,
            data: body,
          );
          break;
      }
      if(showLog){
        debugPrint(response.requestOptions.uri.toString());
        debugPrint(response.requestOptions.headers.toString());
        debugPrint(response.statusCode.toString());
      }
      if(response.statusCode == AppUrls.wrongTokenCode && url != AppUrls.refreshUrl){
        throw ServerException(message: "wrong token");
      }else{
        if(showLog){
          if(response.requestOptions.data is FormData){
            debugPrint((response.requestOptions.data as FormData).fields.toString());
          }else{
            debugPrint(response.requestOptions.data.toString());
          }
          debugPrint(type.toString());
          log(response.toString());
        }
        if(checkResponse){
          if(response.data["success"]){
            return response.data;
          }else{
            throw ServerException(message: response.data["message"]);
          }
        }else{
          return response.data;
        }
      }
    } on ServerException catch (error) {
      debugPrint(error.message);
      throw ServerException(message: error.message);
    } catch (error){
      String message = error.toString();
      throw ServerException(message: message);
    }
  }



  Future<Either<ServerException,String>> _refreshToken() async {
    return Left(ServerException(message: 'wrong token'));
    /*final result = await sendRequest(RequestTypes.POST, AppUrls.refreshUrl, null);
    result.fold((l) {
      //TODO: handle logout
    }, (r) {
      //TODO: refreshToken
    });*/
  }
}