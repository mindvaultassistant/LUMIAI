import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  static GoTrueClient get _auth => Supabase.instance.client.auth;

  static User? get currentUser => _auth.currentUser;

  static Stream<AuthState> get onAuthStateChange =>
      _auth.onAuthStateChange.map((e) => e);

  static Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) {
    return _auth.signInWithPassword(email: email, password: password);
  }

  static Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) {
    return _auth.signUp(email: email, password: password);
  }

  static Future<void> signOut() => _auth.signOut();
}
