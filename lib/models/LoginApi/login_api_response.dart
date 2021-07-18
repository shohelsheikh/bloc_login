class Login_api_response {
  String? _status;
  String? _msg;
  String? _userId;
  String? _userStatus;

  String? get status => _status;
  String? get msg => _msg;
  String? get userId => _userId;
  String? get userStatus => _userStatus;

  Login_api_response({
      String? status, 
      String? msg, 
      String? userId, 
      String? userStatus}){
    _status = status;
    _msg = msg;
    _userId = userId;
    _userStatus = userStatus;
}

  Login_api_response.fromJson(dynamic json) {
    _status = json["status"];
    _msg = json["msg"];
    _userId = json["user_id"];
    _userStatus = json["user_status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["msg"] = _msg;
    map["user_id"] = _userId;
    map["user_status"] = _userStatus;
    return map;
  }

}