import '../components/plane/plane.dart';

class GameState {
  final bool isPaused;
  final List<PlaneEntity> planes;

  const GameState({required this.isPaused, required this.planes});

  GameState copyWith({bool? isPaused, List<PlaneEntity>? planes}) {
    return GameState(
      isPaused: isPaused ?? this.isPaused,
      planes: planes ?? this.planes,
    );
  }
}