
import '../components/plane/plane.dart';

abstract class GameEvent {}

class PauseGameEvent extends GameEvent {}

class ResumeGameEvent extends GameEvent {}

class RestartGameEvent extends GameEvent {}

class GameOverEvent extends GameEvent {
  final String reason;
  GameOverEvent({required this.reason});
}

class AddPlaneEvent extends GameEvent {
  final PlaneEntity plane;
  AddPlaneEvent(this.plane);
}

class PlaneLandedEvent extends GameEvent {
  final PlaneEntity plane;
  PlaneLandedEvent(this.plane);
}

class RemovePlaneEvent extends GameEvent {
  final PlaneEntity plane;
  RemovePlaneEvent(this.plane);
}

class UpdatePlanesEvent extends GameEvent {
  final List<PlaneEntity> updated;
  UpdatePlanesEvent(this.updated);
}

