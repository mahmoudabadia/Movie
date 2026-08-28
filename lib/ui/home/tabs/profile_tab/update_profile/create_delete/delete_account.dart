// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';

class DeleteAccount {
  static Future<void> deleteAccount() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw FirebaseAuthException(
        code: "no-user",
        message: "No user is currently signed in.",
      );
    }
    await user.delete();
  }

  static Future<void> reauthenticate(String password) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw FirebaseAuthException(
        code: "no-user",
        message: "No user is currently signed in.",
      );
    }

    await user.delete();
  }
}
