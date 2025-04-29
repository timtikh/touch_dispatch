
import '../components/plane/plane.dart';

abstract class GameEvent {}

class PauseGameEvent extends GameEvent {}

class ResumeGameEvent extends GameEvent {}

class AddPlaneEvent extends GameEvent {
  final PlaneEntity plane;
  AddPlaneEvent(this.plane);
}

class RemovePlaneEvent extends GameEvent {
  final PlaneEntity plane;
  RemovePlaneEvent(this.plane);
}

class UpdatePlanesEvent extends GameEvent {
  final List<PlaneEntity> updated;
  UpdatePlanesEvent(this.updated);
}

