import 'package:sportapp_movil/services/entrenamiento_service.dart';
import 'package:sportapp_movil/services/eventos_service.dart';
import 'package:sportapp_movil/services/exercises_service.dart';
import 'package:sportapp_movil/services/models/entrenamiento_api_model.dart';
import 'package:sportapp_movil/services/models/eventos_api_model.dart';
import 'package:sportapp_movil/services/models/exercises_api_model.dart';
import 'package:sportapp_movil/services/models/simulator_api_model.dart';
import 'package:sportapp_movil/services/simulator_service.dart';

class DataManager {
  static final DataManager _singleton = DataManager._internal();
  List<ExercisesApiModel> allExercises = [];
  List<EntrenamientosModel> allEntrenamientos = [];
  List<EventosApiModel> allEventos = [];

  factory DataManager() {
    return _singleton;
  }

  DataManager._internal();

  String _data = '';

  void setData(String data) {
    _data = data;
  }

  String getData() {
    return _data;
  }

  void initData() {
    getEntrenamientos();
    getExercises();
    getEventos();
  }

  Future<void> getExercises() async {
    var service = ExercisesService();
    await service.getAll().then((value) {
      allExercises = value;
    });
  }

  Future<void> getEntrenamientos() async {
    var service = EntrenamientoService();
    await service.getAll().then((value) {
      allEntrenamientos = value;
    });
  }

  Future<void> getEventos() async {
    var service = EventosService();
    await service.getAll().then((value) {
      allEventos = value;
    });
  }

  Future<void> getCalendarData() async {
    await getEntrenamientos();
    await getEventos();
  }

  Future<SimulatorApiModel?> getHeartRate() async {
    var service = SimulatorService();
    return await service.getAll();
  }
}
