import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/supabase_client.dart';

class AuthService {
  static User? get currentUser => SB.client.auth.currentUser;

  static Future<void> signUp({
    required String email,
    required String password,
  }) async {
    final res = await SB.client.auth.signUp(email: email, password: password);
    if (res.user == null) {
      throw Exception('signUp failed');
    }
  }

  static Future<void> signIn({
    required String email,
    required String password,
  }) async {
    final res = await SB.client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    if (res.user == null) {
      throw Exception('signIn failed');
    }
  }

  static Future<void> signOut() async {
    await SB.client.auth.signOut();
  }
}
