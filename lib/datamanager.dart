import 'package:sportapp_movil/services/exercises_service.dart';
import 'package:sportapp_movil/services/models/exercises_api_model.dart';

class DataManager {
  static final DataManager _singleton = DataManager._internal();
  List<ExercisesApiModel> allExercises = [];

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
    var service = ExercisesService();
    service.getAll().then((value) {
      allExercises = value;
    });
  }
}
