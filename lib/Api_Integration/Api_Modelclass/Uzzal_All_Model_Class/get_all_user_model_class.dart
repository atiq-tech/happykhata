class GetUserByuserModelClass {
  bool? _success;
  List<Dataa>? _data;

  GetUserByuserModelClass({bool? success, List<Dataa>? data}) {
    if (success != null) {
      this._success = success;
    }
    if (data != null) {
      this._data = data;
    }
  }

  bool? get success => _success;
  set success(bool? success) => _success = success;
  List<Dataa>? get data => _data;
  set data(List<Dataa>? data) => _data = data;

  GetUserByuserModelClass.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = <Dataa>[];
      json['data'].forEach((v) {
        _data!.add(new Dataa.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    if (this._data != null) {
      data['data'] = this._data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dataa {
  String? _userSlNo;
  String? _userID;
  String? _fullName;
  String? _userName;
  String? _userEmail;
  String? _userBrunchId;
  String? _userPassword;
  String? _userType;
  String? _status;
  String? _verifycode;
  String? _imageName;
  String? _addBy;
  String? _addTime;
  String? _updateBy;
  String? _updateTime;
  String? _brunchID;

  Dataa(
      {String? userSlNo,
        String? userID,
        String? fullName,
        String? userName,
        String? userEmail,
        String? userBrunchId,
        String? userPassword,
        String? userType,
        String? status,
        String? verifycode,
        String? imageName,
        String? addBy,
        String? addTime,
        String? updateBy,
        String? updateTime,
        String? brunchID}) {
    if (userSlNo != null) {
      this._userSlNo = userSlNo;
    }
    if (userID != null) {
      this._userID = userID;
    }
    if (fullName != null) {
      this._fullName = fullName;
    }
    if (userName != null) {
      this._userName = userName;
    }
    if (userEmail != null) {
      this._userEmail = userEmail;
    }
    if (userBrunchId != null) {
      this._userBrunchId = userBrunchId;
    }
    if (userPassword != null) {
      this._userPassword = userPassword;
    }
    if (userType != null) {
      this._userType = userType;
    }
    if (status != null) {
      this._status = status;
    }
    if (verifycode != null) {
      this._verifycode = verifycode;
    }
    if (imageName != null) {
      this._imageName = imageName;
    }
    if (addBy != null) {
      this._addBy = addBy;
    }
    if (addTime != null) {
      this._addTime = addTime;
    }
    if (updateBy != null) {
      this._updateBy = updateBy;
    }
    if (updateTime != null) {
      this._updateTime = updateTime;
    }
    if (brunchID != null) {
      this._brunchID = brunchID;
    }
  }

  String? get userSlNo => _userSlNo;
  set userSlNo(String? userSlNo) => _userSlNo = userSlNo;
  String? get userID => _userID;
  set userID(String? userID) => _userID = userID;
  String? get fullName => _fullName;
  set fullName(String? fullName) => _fullName = fullName;
  String? get userName => _userName;
  set userName(String? userName) => _userName = userName;
  String? get userEmail => _userEmail;
  set userEmail(String? userEmail) => _userEmail = userEmail;
  String? get userBrunchId => _userBrunchId;
  set userBrunchId(String? userBrunchId) => _userBrunchId = userBrunchId;
  String? get userPassword => _userPassword;
  set userPassword(String? userPassword) => _userPassword = userPassword;
  String? get userType => _userType;
  set userType(String? userType) => _userType = userType;
  String? get status => _status;
  set status(String? status) => _status = status;
  String? get verifycode => _verifycode;
  set verifycode(String? verifycode) => _verifycode = verifycode;
  String? get imageName => _imageName;
  set imageName(String? imageName) => _imageName = imageName;
  String? get addBy => _addBy;
  set addBy(String? addBy) => _addBy = addBy;
  String? get addTime => _addTime;
  set addTime(String? addTime) => _addTime = addTime;
  String? get updateBy => _updateBy;
  set updateBy(String? updateBy) => _updateBy = updateBy;
  String? get updateTime => _updateTime;
  set updateTime(String? updateTime) => _updateTime = updateTime;
  String? get brunchID => _brunchID;
  set brunchID(String? brunchID) => _brunchID = brunchID;

  Dataa.fromJson(Map<String, dynamic> json) {
    _userSlNo = json['User_SlNo'];
    _userID = json['User_ID'];
    _fullName = json['FullName'];
    _userName = json['User_Name'];
    _userEmail = json['UserEmail'];
    _userBrunchId = json['userBrunch_id'];
    _userPassword = json['User_Password'];
    _userType = json['UserType'];
    _status = json['status'];
    _verifycode = json['verifycode'];
    _imageName = json['image_name'];
    _addBy = json['AddBy'];
    _addTime = json['AddTime'];
    _updateBy = json['UpdateBy'];
    _updateTime = json['UpdateTime'];
    _brunchID = json['Brunch_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['User_SlNo'] = this._userSlNo;
    data['User_ID'] = this._userID;
    data['FullName'] = this._fullName;
    data['User_Name'] = this._userName;
    data['UserEmail'] = this._userEmail;
    data['userBrunch_id'] = this._userBrunchId;
    data['User_Password'] = this._userPassword;
    data['UserType'] = this._userType;
    data['status'] = this._status;
    data['verifycode'] = this._verifycode;
    data['image_name'] = this._imageName;
    data['AddBy'] = this._addBy;
    data['AddTime'] = this._addTime;
    data['UpdateBy'] = this._updateBy;
    data['UpdateTime'] = this._updateTime;
    data['Brunch_ID'] = this._brunchID;
    return data;
  }
}
