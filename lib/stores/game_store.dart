import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Game {
  final int id;
  final String title;
  final String slug;

  Game({
    required this.id,
    required this.title,
    required this.slug,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
    );
  }
}

class GameStore with ChangeNotifier {
  List<Game> _games = [];
  List<Game> get games => _games;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadGames() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final response = await Supabase.instance.client.from('games').select();
      final List data = response as List;
      _games = data.map((e) => Game.fromJson(e)).toList();
    } catch (e) {
      print('🔥 [GameStore] 게임 로딩 실패: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
