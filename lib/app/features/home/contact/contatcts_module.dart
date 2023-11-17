import 'package:flutter_modular/flutter_modular.dart';
import 'package:mensageiro/app/core/core_module.dart';
import 'package:mensageiro/app/features/home/contact/domain/repository/contact_repository.dart';
import 'package:mensageiro/app/features/home/contact/domain/usecases/add_contactcs.dart';
import 'package:mensageiro/app/features/home/contact/domain/usecases/get_contacts.dart';
import 'package:mensageiro/app/features/home/contact/external/datasource/firebase_contact_datasource.dart';
import 'package:mensageiro/app/features/home/contact/infra/datasource/i_contact_datasource.dart';
import 'package:mensageiro/app/features/home/contact/infra/repository/contact_repository_impl.dart';
import 'package:mensageiro/app/features/home/contact/presenter/pages/contacts_controller.dart';
import 'package:mensageiro/app/features/home/contact/presenter/pages/home_concact_page.dart';

class ContatctsModule extends Module {
  @override
  void binds(i) {
    i.add<IGetContacts>(GetContactImpl.new);
    i.add<IContactRepository>(ContactRepositoryImpl.new);
    i.add<IContactDatasource>(FirebaseContactDatasource.new);
    i.add<IAddContact>(AddContactImpl.new);
    i.add(ContactsController.new);
  }

  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void routes(r) {
    r.child('/:id',
        child: (context) => HomeContactPage(
            controller: Modular.get(), id: r.args.params['id'] ?? ''));
  }
}
