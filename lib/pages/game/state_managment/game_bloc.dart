import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flame/components.dart';
import '../components/plane/plane.dart';
import 'game_event.dart';
import 'game_state.dart';
class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(const GameState(isPaused: false, planes: [], isGameOver: false, score: 0)) {
    on<PauseGameEvent>((event, emit) {
      emit(state.copyWith(isPaused: true));
    });
    on<ResumeGameEvent>((event, emit) {
      emit(state.copyWith(isPaused: false));
    });
    on<GameOverEvent>((event, emit) {
      emit(state.copyWith(isPaused: true, isGameOver: true));
    });
    on<RestartGameEvent>((event, emit) {
      emit(state.copyWith(
        planes: [],
        isPaused: false,
        isGameOver: false,
        score: 0, // Reset score on restart
      ));
    });
    on<PlaneLandedEvent>((event, emit) {
      final updatedPlanes = List<PlaneEntity>.from(state.planes)..remove(event.plane);
      emit(state.copyWith(
        planes: updatedPlanes,
        score: state.score + 10,
      ));
    });
    on<AddPlaneEvent>((event, emit) {
      final updatedPlanes = List<PlaneEntity>.from(state.planes)..add(event.plane);
      emit(state.copyWith(planes: updatedPlanes));
    });
    on<RemovePlaneEvent>((event, emit) {
      final updatedPlanes = List<PlaneEntity>.from(state.planes)..remove(event.plane);
      emit(state.copyWith(planes: updatedPlanes));
    });
    on<UpdatePlanesEvent>((event, emit) {
      emit(state.copyWith(planes: event.updated));
    });
  }
}

