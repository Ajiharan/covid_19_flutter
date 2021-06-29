import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  FirebaseAuth? auth;
  FirebaseAuthService() {
    auth = FirebaseAuth.instance;
  }

  dynamic checkAuth() {
    return auth!.currentUser;
  }
}
