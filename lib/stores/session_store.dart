import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // ✅ 꼭 들어가 있어야 함

class SessionStore with ChangeNotifier {
  Session? _session;

  Session? get session => _session;
  bool get isLoggedIn => _session != null;

  String _anonymousFid = '';
  String _anonymousNickname = '';

  String get fid => isLoggedIn ? (_session?.user.id ?? '') : _anonymousFid;
  String get nickname => isLoggedIn
      ? (_session?.user.userMetadata?['nickname'] ?? '회원')
      : _anonymousNickname;

  SessionStore() {
    loadSession();
    initAnonymousUser();
  }

  void loadSession() {
    _session = Supabase.instance.client.auth.currentSession;
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    final response = await Supabase.instance.client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    _session = response.session;
    notifyListeners();
  }

  Future<void> signOut() async {
    await Supabase.instance.client.auth.signOut();
    _session = null;
    notifyListeners();
  }

  Future<void> initAnonymousUser() async {
    final prefs = await SharedPreferences.getInstance();
    _anonymousFid = prefs.getString('anonymous_fid') ?? const Uuid().v4();
    _anonymousNickname = prefs.getString('anonymous_nick') ?? _generateNickname();

    prefs.setString('anonymous_fid', _anonymousFid);
    prefs.setString('anonymous_nick', _anonymousNickname);

    notifyListeners();
  }

  String _generateNickname() {
    final random = 1000 + DateTime.now().millisecondsSinceEpoch % 9000;
    return '익명#$random';
  }

  // ✅ 수정된 Kakao 로그인 함수
  Future<void> signInWithKakao(String redirectUrl) async {
    try {
await Supabase.instance.client.auth.signInWithOAuth(
  OAuthProvider.kakao,
  redirectTo: redirectUrl,
);
    } catch (e) {
      throw Exception('카카오 로그인 실패: $e');
    }
  }
}
