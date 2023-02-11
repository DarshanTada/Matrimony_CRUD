import 'package:flutter/material.dart';
import 'package:matrimonycrud/models/model.dart';

class PersonModel extends Model {
  static String table = "persons";

  late int? id;
  late String personName;
  late int age;
  late int? IsFavorite;
  late String date;
  late String? contactNum;
  late String? email;
  late int gender;
  late String city;
  late String state;
  late String country;

  PersonModel({
    this.id,
    required this.personName,
    required this.age,
    required this.date,
    this.contactNum,
    this.email,
    required this.gender,
    required this.city,
    required this.state,
    required this.country,
    this.IsFavorite,
  });

  static PersonModel fromMap(Map<String, dynamic> json) {
    return PersonModel(
      id: json['id'],
      personName: json['personName'].toString(),
      age: json['age'],
      date: json['date'].toString(),
      contactNum: json['contactNum'].toString(),
      email: json['email'].toString(),
      gender: json['gender'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      IsFavorite: json['IsFavorite'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': id,
      'personName': personName,
      'age': age,
      'contactNum': contactNum,
      'date': date,
      'email': email,
      'gender': gender,
      'city': city,
      'state': state,
      'country': country,
      'IsFavorite': IsFavorite,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
