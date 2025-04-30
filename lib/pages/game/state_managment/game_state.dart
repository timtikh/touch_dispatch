import '../components/plane/plane.dart';

class GameState {
  final bool isPaused;
  final List<PlaneEntity> planes;
  final bool isGameOver;

  const GameState({
    required this.isPaused,
    required this.planes,
    required this.isGameOver,
  });
  GameState copyWith({bool? isPaused, bool? isGameOver, List<PlaneEntity>? planes}) {
    return GameState(
      isPaused: isPaused ?? this.isPaused,
      isGameOver: isGameOver ?? this.isGameOver,
      planes: planes ?? this.planes,
    );
  }
}