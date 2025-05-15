import '../components/plane/plane.dart';

class GameState {
  final bool isPaused;
  final List<PlaneEntity> planes;
  final bool isGameOver;
  final int score; // Add the score field

  const GameState({
    required this.isPaused,
    required this.planes,
    required this.isGameOver,
    required this.score, // Initialize score
  });

  GameState copyWith({
    bool? isPaused,
    bool? isGameOver,
    List<PlaneEntity>? planes,
    int? score, // Add score parameter to copyWith
  }) {
    return GameState(
      isPaused: isPaused ?? this.isPaused,
      isGameOver: isGameOver ?? this.isGameOver,
      planes: planes ?? this.planes,
      score: score ?? this.score, // Ensure score is updated
    );
  }
}
