import 'dart:convert';

Users usersFromMap(String str) =>
    Users.fromMap(json.decode(str) as Map<String, dynamic>);

String usersToMap(Users data) => json.encode(data.toMap());

class Users {
  final int? usrId;
  final String? name;
  final String? email;
  final String? usrName;
  final String? usrPassword;

  Users({
    required this.usrName,
    required this.usrPassword,
    this.usrId,
    this.name,
    this.email,
  });

  factory Users.fromMap(Map<String, dynamic> json) => Users(
        usrId: json['usrId'] as int?,
        name: json['Name'] as String?,
        email: json['email'] as String?,
        usrName: json['usrName'] as String,
        usrPassword: json['usrPassword'] as String,
      );

  Map<String, dynamic> toMap() => {
        'usrId': usrId,
        'Name': name,
        'email': email,
        'usrName': usrName,
        'usrPassword': usrPassword,
      };
}
