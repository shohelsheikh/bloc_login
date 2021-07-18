import 'dart:async';

import 'package:block_refresh/models/LoginApi/login_api_request.dart';
import 'package:block_refresh/models/LoginApi/login_api_response.dart';
 import 'package:block_refresh/networking/ApiProvider.dart';

class Repository {
  ApiProvider _provider = ApiProvider();

  Future<Login_api_response> loginAPI(String email,String password) async {

    final Login_api_request loginRequest = Login_api_request();
    loginRequest.emailId=email;
    loginRequest.password=password;
    loginRequest.accessToken="";

    final response = await _provider.post("login_api/",loginRequest);
    return Login_api_response.fromJson(response);
  }
}
