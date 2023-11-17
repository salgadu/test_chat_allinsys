import 'package:flutter_modular/flutter_modular.dart';
import 'package:mensageiro/app/core/core_module.dart';
import 'package:mensageiro/app/features/home/chat/domain/repository/chat_repository.dart';
import 'package:mensageiro/app/features/home/chat/domain/usecases/get_message.dart';
import 'package:mensageiro/app/features/home/chat/domain/usecases/send_audio.dart';
import 'package:mensageiro/app/features/home/chat/domain/usecases/send_chat.dart';
import 'package:mensageiro/app/features/home/chat/domain/usecases/send_document.dart';
import 'package:mensageiro/app/features/home/chat/domain/usecases/send_image.dart';
import 'package:mensageiro/app/features/home/chat/domain/usecases/send_video.dart';
import 'package:mensageiro/app/features/home/chat/external/datasource/firebase_datsource_chats.dart';
import 'package:mensageiro/app/features/home/chat/infra/datasource/i_chat_datasource.dart';
import 'package:mensageiro/app/features/home/chat/infra/repository/chat_repository_impl.dart';
import 'package:mensageiro/app/features/home/chat/presenter/pages/chat_controller.dart';
import 'package:mensageiro/app/features/home/chat/presenter/pages/chat_screen.dart';

class ChatModule extends Module {
  @override
  void binds(i) {
    i.add<IGetMessage>(GetMessageImpl.new);
    i.add<ISendChat>(SendChatImpl.new);
    i.add<IChatRepository>(ChatRepositoryImpl.new);
    i.add<IChatDatasource>(FirebaseDatasourceChats.new);
    i.add(ChatController.new);
    i.add<ISendAudio>(SendAudioImpl.new);
    i.add<ISendDocument>(SendDocumentImpl.new);
    i.add<ISendImage>(SendImageImpl.new);
    // i.add<ISendVideo>(SendVideoImpl.new);
  }

  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void routes(r) {
    r.child('/',
        child: (context) => ChatPage(
              controller: Modular.get(),
              contact: r.args.data,
            ));
  }
}
