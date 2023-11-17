import 'package:flutter_modular/flutter_modular.dart';
import 'package:mensageiro/app/core/core_module.dart';
import 'package:mensageiro/app/features/auth/login/domain/repository/login_repository.dart';
import 'package:mensageiro/app/features/auth/login/domain/usecase/login_with_email_and_password.dart';
import 'package:mensageiro/app/features/auth/login/external/datasource/firebase_repository_datasource_impl.dart';
import 'package:mensageiro/app/features/auth/login/infra/datasource/login_datasource.dart';
import 'package:mensageiro/app/features/auth/login/infra/repository/login_repository_impl.dart';
import 'package:mensageiro/app/features/auth/login/presenter/pages/login_controller.dart';
import 'package:mensageiro/app/features/auth/login/presenter/pages/login_page.dart';

class LoginModule extends Module {
  @override
  void binds(i) {
    i.add<LoginRepository>(LoginRepositoryImpl.new);
    i.add<ILoginDatasource>(FireBaseRepositoryDataSourceImpl.new);
    i.add<ILoginWithEmailAndPassword>(LoginWithEmailAndPassword.new);
    i.add(LoginController.new);
  }

  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void routes(r) {
    r.child('/',
        child: (context) => LoginPage(
              controller: Modular.get(),
            ));
  }
}
