import 'package:firebase_auth/firebase_auth.dart';

class ResetPassword {
  static Future<void> sendResetEmail({String? email}) async {
    final String? targetEmail = email ?? FirebaseAuth.instance.currentUser?.email;

    if (targetEmail == null || targetEmail.trim().isEmpty) {
      throw FirebaseAuthException(
        code: 'no-email',
      );
    }

    await FirebaseAuth.instance.sendPasswordResetEmail(email: targetEmail.trim());
  }
}
