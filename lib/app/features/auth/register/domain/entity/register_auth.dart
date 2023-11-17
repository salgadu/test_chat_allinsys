class RegisterAuth {
  String email;
  final String password;
  final String name;
  final String phone;

  RegisterAuth({
    this.email = '',
    required this.password,
    required this.name,
    required this.phone,
  });

  bool validate() {
    if (password.isEmpty) {
      return false;
    }
    if (name.isEmpty) {
      return false;
    }
    if (phone.isEmpty) {
      return false;
    }
    return true;
  }
}
