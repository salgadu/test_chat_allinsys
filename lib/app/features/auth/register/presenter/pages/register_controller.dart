import 'package:flutter_modular/flutter_modular.dart';
import 'package:mensageiro/app/core/store/auth/auth_status.dart';
import 'package:mensageiro/app/core/store/auth/auth_store.dart';
import 'package:mensageiro/app/features/auth/register/domain/entity/register_auth.dart';
import 'package:mensageiro/app/features/auth/register/domain/usecases/auth_register.dart';
import 'package:mobx/mobx.dart';

part 'register_controller.g.dart';

class RegisterController = RegisterControllerBase with _$RegisterController;

abstract class RegisterControllerBase with Store {
  AuthStore authStore = Modular.get<AuthStore>();
  final IRegisterUser register;

  RegisterControllerBase(this.register);

  @observable
  bool isLoading = false;

  @observable
  bool isError = false;

  @action
  setLoadind(bool value) => isLoading = value;

  @action
  setError(bool value) => isError = value;

  Future<void> registerUser({required RegisterAuth data}) async {
    setLoadind(true);
    setError(false);
    final result = await register.call(data);
    result.fold((error) {
      setLoadind(false);
      setError(true);
    }, (user) {
      setLoadind(false);
      authStore.setUser(user);
      authStore.setAuthStatus(AuthStatus.Authenticated);
    });
  }
}
