import 'dart:convert';

AddressModelResponse welcomeFromJson(String str) => AddressModelResponse.fromJson(json.decode(str));

String welcomeToJson(AddressModelResponse data) => json.encode(data.toJson());

class AddressModelResponse {
  AddressModelResponse({
    this.status,
    this.data,
    this.message,
  });

  bool? status;
  List<Country>? data;
  String? message;

  factory AddressModelResponse.fromJson(Map<String, dynamic> json) => AddressModelResponse(
    status: json["status"],
    data: List<Country>.from(json["data"].map((x) => Country.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class Country {
  Country({
    this.id,
    this.name,
    this.states,
  });

  int? id;
  String? name;
  List<State>? states;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    name: json["name"],
    states: List<State>.from(json["states"].map((x) => State.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "states": List<dynamic>.from(states!.map((x) => x.toJson())),
  };
}

class State {
  State({
    this.id,
    this.name,
    this.cities,
  });

  int? id;
  String? name;
  List<City>? cities;

  factory State.fromJson(Map<String, dynamic> json) => State(
    id: json["id"],
    name: json["name"],
    cities: List<City>.from(json["cities"].map((x) => City.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "cities": List<dynamic>.from(cities!.map((x) => x.toJson())),
  };
}

class City {
  City({
    this.name,
    this.id,
  });

  String? name;
  int? id;

  factory City.fromJson(Map<String, dynamic> json) => City(
    name: json["name"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
  };
}
