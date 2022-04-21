import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> getCurrentUid() async {
    return (await _firebaseAuth.currentUser!).uid;
  }

  Future getCurrentUser() async {
    return await _firebaseAuth.currentUser!;
  }
}
