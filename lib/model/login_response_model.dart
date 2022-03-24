import 'dart:convert';

LoginResponseModel welcomeFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String welcomeToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    this.status,
    this.accessToken,
    this.tokenType,
    this.data,
  });

  bool? status;
  String? accessToken;
  String? tokenType;
  User? data;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    status: json["status"],
    accessToken: json["access_token"],
    tokenType: json["token_type"],
    data: User.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "access_token": accessToken,
    "token_type": tokenType,
    "data": data?.toJson(),
  };
}

class User {
  User({
    this.id,
    this.gymId,
    this.employeeId,
    this.name,
    this.email,
    this.countryId,
    this.email_status,
    this.cityId,
    this.stateId,
    this.gymPackageId,
    this.assignTo,
    this.createdBy,
    this.updatedBy,
    this.gymtime,
    this.packageStartDate,
  });

  int? id;
  num? gymId;
  num? employeeId;
  String? name;
  String? email;
  int? countryId;
  int? email_status;
  int? cityId;
  int? stateId;
  dynamic gymPackageId;
  dynamic assignTo;
  dynamic createdBy;
  dynamic updatedBy;
  String? gymtime;
  String? packageStartDate;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    gymId: json["gym_id"],
    employeeId: json["employee_id"],
    name: json["name"],
    email: json["email"],
    countryId: json["country_id"],
    cityId: json["city_id"],
    email_status: json["email_status"],
    stateId: json["state_id"],
    gymPackageId: json["gym_package_id"],
    assignTo: json["assign_to"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    gymtime: json["gymtime"],
    packageStartDate: json["package_start_date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "gym_id": gymId,
    "employee_id": employeeId,
    "name": name,
    "email": email,
    "country_id": countryId,
    "city_id": cityId,
    "email_status": email_status,
    "state_id": stateId,
    "gym_package_id": gymPackageId,
    "assign_to": assignTo,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "gymtime": gymtime,
    "package_start_date": packageStartDate,
  };
}
