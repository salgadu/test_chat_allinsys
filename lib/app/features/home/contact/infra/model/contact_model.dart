import 'package:mensageiro/app/features/home/contact/domain/entity/contact.dart';

class ContactModel extends Contact {
  ContactModel({
    required super.id,
    super.photo,
    required super.name,
    required super.phone,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      name: json['name'],
      photo: json['photo'],
      phone: json['phone'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'photo': photo,
      'phone': phone,
      'id': id,
    };
  }
}
