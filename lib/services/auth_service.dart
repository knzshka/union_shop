class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  String? _email;

  String? get currentUserEmail => _email;
  bool get isSignedIn => _email != null;

  bool signInWithEmail(String email, String password) {
    final lower = email.toLowerCase();
    if (!lower.endsWith('@gmail.com')) {
      return false;
    }
    if (password.length < 6) {
      return false;
    }
    _email = email;
    return true;
  }

  void signOut() {
    _email = null;
  }
}