class Login_api_request {
  String? _emailId;
  String? _password;
  String? _accessToken;


  set emailId(String value) {
    _emailId = value;
  }

  Login_api_request({
      String? emailId, 
      String? password, 
      String? accessToken}){
    _emailId = emailId;
    _password = password;
    _accessToken = accessToken;
}

  Login_api_request.fromJson(dynamic json) {
    _emailId = json["email_id"];
    _password = json["password"];
    _accessToken = json["access_token"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["email_id"] = _emailId;
    map["password"] = _password;
    map["access_token"] = _accessToken;
    return map;
  }

  set password(String value) {
    _password = value;
  }

  set accessToken(String value) {
    _accessToken = value;
  }
}