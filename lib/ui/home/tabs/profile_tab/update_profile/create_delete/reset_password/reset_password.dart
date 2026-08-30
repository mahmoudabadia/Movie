import 'package:firebase_auth/firebase_auth.dart';

class ResetPassword {
  static Future<void> sendResetEmail() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw FirebaseAuthException(
        code: "no-user",
        message: "No user is currently signed in.",
      );
    }

    final email = user.email;

    if (email == null || email.isEmpty) {
      throw FirebaseAuthException(
        code: "no-email",
        message: "The current user does not have an email.",
      );
    }

    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
