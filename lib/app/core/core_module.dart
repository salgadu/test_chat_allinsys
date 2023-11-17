import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mensageiro/app/core/infra/file_acess/file_access.dart';
import 'package:mensageiro/app/core/infra/file_acess/i_file_access.dart';
import 'package:mensageiro/app/core/infra/notification/firebase_message_service.dart';
import 'package:mensageiro/app/core/infra/notification/notification_service.dart';
import 'package:mensageiro/app/core/store/auth/auth_store.dart';

class CoreModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<AuthStore>(AuthStore.new);
    i.addInstance<FirebaseAuth>(FirebaseAuth.instance);
    i.addInstance<FirebaseFirestore>(FirebaseFirestore.instance);
    i.addInstance<FirebaseMessaging>(FirebaseMessaging.instance);
    i.addInstance<FirebaseStorage>(FirebaseStorage.instance);
    i.addInstance(NotificationService());
    i.addInstance<ImagePicker>(ImagePicker());
    i.addInstance<FilePicker>(FilePicker.platform);
    i.add(FirebaseMessageService.new);
    i.add<IFileAccess>(FileAccess.new);
  }
}
