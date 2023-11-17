import 'package:flutter_modular/flutter_modular.dart';

import 'package:mensageiro/app/core/core_module.dart';
import 'package:mensageiro/app/features/auth/register/domain/repository/register_repository.dart';
import 'package:mensageiro/app/features/auth/register/domain/usecases/auth_register.dart';
import 'package:mensageiro/app/features/auth/register/external/datasource/firebase_repository_datarsource_impl.dart';
import 'package:mensageiro/app/features/auth/register/infra/datasource/i_auth_register_datasource.dart';
import 'package:mensageiro/app/features/auth/register/infra/repository/auth_register.dart';
import 'package:mensageiro/app/features/auth/register/presenter/pages/register_controller.dart';
import 'package:mensageiro/app/features/auth/register/presenter/pages/register_page.dart';

class RegisterModule extends Module {
  @override
  void binds(i) {
    i.add<IRegisterUser>(RegisterUser.new);
    i.add<IRegisterRepository>(AuthRegisterRepository.new);
    i.add<IAuthRegisterDatasource>(FireBaseRepositoryDataSource.new);
    i.add(RegisterController.new);
  }

  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void routes(r) {
    r.child('/',
        child: (context) => RegisterPage(
              controller: Modular.get<RegisterController>(),
            ));
  }
}
