import 'package:flutter_modular/flutter_modular.dart';
import 'package:mensageiro/app/features/auth/login/login_module.dart';
import 'package:mensageiro/app/features/auth/register/register_module.dart';

class AuthModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.module('/login/', module: LoginModule());
    r.module('/register/', module: RegisterModule());
  }
}
