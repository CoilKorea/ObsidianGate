import 'package:flutter/material.dart';
import '../models/game.dart';
import '../services/game_service.dart';

class GameStore with ChangeNotifier {
  final GameService _service = GameService();
  List<Game> _games = [];
  bool _isLoading = true;

  List<Game> get games => _games;
  bool get isLoading => _isLoading;

  Future<void> loadGames() async {
    _isLoading = true;
    notifyListeners();

    _games = await _service.fetchGames();

    _isLoading = false;
    notifyListeners();
  }
}
