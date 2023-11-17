class Contact {
  final String id;
  final String name;
  final String phone;
  final String? photo;

  Contact({
    required this.id,
    required this.name,
    required this.phone,
    this.photo,
  });

  Map<String, dynamic> toMap() =>
      {"id": id, "name": name, "phone": phone, "photo": photo};
}
