import 'package:sportapp_movil/services/entrenamiento_service.dart';
import 'package:sportapp_movil/services/exercises_service.dart';
import 'package:sportapp_movil/services/models/entrenamiento_api_model.dart';
import 'package:sportapp_movil/services/models/exercises_api_model.dart';

class DataManager {
  static final DataManager _singleton = DataManager._internal();
  List<ExercisesApiModel> allExercises = [];
  List<EntrenamientosModel> allEntrenamientos = [];

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
  }

  void getExercises() {
    var service = ExercisesService();
    service.getAll().then((value) {
      allExercises = value;
    });
  }

  Future<void> getEntrenamientos() async {
    var service = EntrenamientoService();
    await service.getAll().then((value) {
      allEntrenamientos = value;
    });
  }

  Future<void> getCalendarData() async {
    await getEntrenamientos();
  }
}
