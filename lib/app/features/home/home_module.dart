import 'package:flutter_modular/flutter_modular.dart';
import 'package:mensageiro/app/features/home/chat/chat_module.dart';
import 'package:mensageiro/app/features/home/contact/contatcts_module.dart';
import 'package:mensageiro/app/home_page.dart';

class HomeModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.module('/contacts', module: ContatctsModule());
    r.module('/chat', module: ChatModule());
    r.child('/', child: (context) => const HomePage());
  }
}
