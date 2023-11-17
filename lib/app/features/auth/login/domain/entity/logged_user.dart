class LoggedUser {
  final String name;
  final String email;
  final String phoneNumber;
  String? photo;

  LoggedUser(
      {required this.name,
      required this.email,
      required this.phoneNumber,
      this.photo});
}
