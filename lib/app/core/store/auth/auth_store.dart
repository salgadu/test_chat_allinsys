import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mensageiro/app/core/infra/notification/firebase_message_service.dart';
import 'package:mensageiro/app/core/store/auth/auth_status.dart';
import 'package:mensageiro/app/features/auth/login/domain/entity/logged_user.dart';
import 'package:mensageiro/app/features/auth/login/infra/model/logged_user_model.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final FirebaseAuth firebase;
  final FirebaseFirestore firestore;
  final FirebaseMessageService firebaseMessageService;

  AuthStoreBase(this.firebase, this.firestore, this.firebaseMessageService) {
    // when((_) => authStatus == null, () async => await authLogin());
    reaction((_) => authStatus, (_) {
      switch (authStatus) {
        case AuthStatus.Authenticated:
          Modular.to.pushReplacementNamed('/home/contacts/');
          break;
        case AuthStatus.Unauteticated:
          Modular.to.pushReplacementNamed('/home/');
          break;
        default:
      }
    });
  }

  @observable
  AuthStatus? authStatus;

  @observable
  LoggedUser? user;

  @action
  setUser(LoggedUser? value) => user = value;

  @action
  setAuthStatus(AuthStatus value) => authStatus = value;

  Future<void> authLogin() async {
    try {
      firebase.authStateChanges().listen((User? user) async {
        if (user != null) {
          final phone = user.email!.split('@')[0];
          final data = await firestore.collection('users').doc(phone).get();

          if (data.data() != null) {
            final token = await firebaseMessageService.getDeviceFirebaseToken();
            setUser(LoggedUserModel.fromMap(data.data()!));
            await firestore
                .collection('users')
                .doc(this.user!.phoneNumber)
                .update({'token': token});
            setAuthStatus(AuthStatus.Authenticated);
            return;
          }
        }
        setAuthStatus(AuthStatus.Unauteticated);
        return;
      });
    } catch (e) {
      await firebase.signOut();
      setAuthStatus(AuthStatus.Unauteticated);
      setUser(null);
      return;
    }
  }

  Future<void> signOut() async {
    await firebase.signOut();
    setAuthStatus(AuthStatus.Unauteticated);
    setUser(null);
  }
}
