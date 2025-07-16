// lib/utils/anonymous_id.dart
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _fidKey = 'anonymous_fid';
const _nickKey = 'anonymous_nick';

Future<String> getOrCreateAnonymousFID() async {
  final prefs = await SharedPreferences.getInstance();
  final existing = prefs.getString(_fidKey);

  if (existing != null) return existing;

  final newFid = const Uuid().v4(); // 예: 48b2-4562...
  await prefs.setString(_fidKey, newFid);
  return newFid;
}

Future<String> getOrCreateAnonymousNickname() async {
  final prefs = await SharedPreferences.getInstance();
  final existing = prefs.getString(_nickKey);

  if (existing != null) return existing;

  final randomSuffix = 1000 + DateTime.now().millisecond % 9000;
  final nickname = '익명#$randomSuffix';
  await prefs.setString(_nickKey, nickname);
  return nickname;
}
