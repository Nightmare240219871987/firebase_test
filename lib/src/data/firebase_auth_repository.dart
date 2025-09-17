import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/src/data/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  @override
  Stream<User?> authStateChange() {
    return FirebaseAuth.instance.authStateChanges();
  }

  @override
  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() async {
    if (FirebaseAuth.instance.currentUser!.isAnonymous) {
      await FirebaseAuth.instance.currentUser!.delete();
    }
    await FirebaseAuth.instance.signOut();
  }
}
