import 'dart:async';
import 'package:block_refresh/models/LoginApi/login_api_response.dart';
import 'package:block_refresh/networking/Repsonse.dart';
import 'package:block_refresh/repository/repository.dart';

class LoginBloc {
  late Repository _loginRepository;
  var _loginDataController = StreamController<Response<Login_api_response>>();
  late bool _isStreaming;
  StreamSink<Response<Login_api_response>> get loginDataSink =>_loginDataController.sink;
  Stream<Response<Login_api_response>> get loginDataStream =>_loginDataController.stream;


  LoginBloc() {

  }


  loginApi(String email,String password) async {
    _loginRepository = Repository();
    _isStreaming = true;

    loginDataSink.add(Response.loading('Loading please wait..'));
    try {
      Login_api_response loginJoke = await _loginRepository.loginAPI(email,password);
      if (_isStreaming) loginDataSink.add(Response.completed(loginJoke));
    } catch (e) {
      if (_isStreaming) loginDataSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _isStreaming = false;
    _loginDataController.close();
  }
}
