import 'package:flutter_modular/flutter_modular.dart';
import 'package:mensageiro/app/core/store/auth/auth_status.dart';
import 'package:mensageiro/app/core/store/auth/auth_store.dart';
import 'package:mensageiro/app/features/auth/login/domain/usecase/login_with_email_and_password.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  final ILoginWithEmailAndPassword login;
  AuthStore authStore = Modular.get<AuthStore>();
  LoginControllerBase(this.login);

  @observable
  bool isLoading = false;

  @observable
  bool isError = false;

  @observable
  String messageError = '';

  @action
  setLoadind(bool value) => isLoading = value;

  @action
  setError(bool value) => isError = value;

  @action
  setMessageError(String value) => messageError = value;

  singIn({required String phone, required String password}) async {
    setLoadind(true);
    setError(false);
    final result = await login(phone: phone, password: password);
    result.fold((error) {
      setMessageError(error.message);
      setError(true);
    }, (user) {
      if (user != null) {
        setLoadind(false);
        authStore.setUser(user);
        authStore.setAuthStatus(AuthStatus.Authenticated);
      }
    });
  }
}
