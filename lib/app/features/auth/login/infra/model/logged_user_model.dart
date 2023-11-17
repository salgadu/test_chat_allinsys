import 'package:mensageiro/app/features/auth/login/domain/entity/logged_user.dart';

class LoggedUserModel extends LoggedUser {
  LoggedUserModel({
    required super.name,
    required super.email,
    required super.phoneNumber,
  });

  factory LoggedUserModel.fromMap(Map<String, dynamic> map) => LoggedUserModel(
      name: map['name'], email: map['email'], phoneNumber: map['phone']);
}
