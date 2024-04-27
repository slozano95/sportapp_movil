import 'dart:async';
import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportapp_movil/profile_view.dart';
import 'package:sportapp_movil/services/deportista_service.dart';
import 'package:sportapp_movil/services/entrenamiento_service.dart';
import 'package:sportapp_movil/services/eventos_service.dart';
import 'package:sportapp_movil/services/exercises_service.dart';
import 'package:sportapp_movil/services/models/entrenamiento_api_model.dart';
import 'package:sportapp_movil/services/models/eventos_api_model.dart';
import 'package:sportapp_movil/services/models/exercises_api_model.dart';
import 'package:sportapp_movil/services/models/simulator_api_model.dart';
import 'package:sportapp_movil/services/models/strava_new_activity_api_model.dart';
import 'package:sportapp_movil/services/simulator_service.dart';
import 'package:sportapp_movil/services/strava_service.dart';

class DataManager {
  static final DataManager _singleton = DataManager._internal();
  List<ExercisesApiModel> allExercises = [];
  List<EntrenamientosModel> allEntrenamientos = [];
  List<EventosApiModel> allEventos = [];
  List<StravaNewActivityApiModel> allPendingActivities = [];
  List<StravaNewActivityApiModel> stravaActivities = [];
  ProfileData? profileData = ProfileData();
  Timer? stravaTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
    sendPendingActivities();
  });
  Timer? stravaSyncTimer;

  String stravaCode = "";
  String stravaToken = "";
  String stravaRefreshToken = "";
  int expiresAt = 0;

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

  void initData() async {
    getEntrenamientos();
    getExercises();
    getEventos();
    getProfileData();
    await readData();
    checkStravaToken();
    syncStravaActivites();
    stravaSyncTimer = Timer.periodic(const Duration(minutes: 3), (timer) {
      syncStravaActivites();
    });
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
    if (stravaRefreshToken.isNotEmpty) {
      await StravaService().getActivities();
    }
  }

  Future<SimulatorApiModel?> getHeartRate() async {
    var service = SimulatorService();
    return await service.getAll();
  }

  void addPendingActivity(StravaNewActivityApiModel activity) {
    print("ADDING PENDING ACTIVITY ${activity.id}");
    if (stravaCode.isNotEmpty) {
      allPendingActivities.add(activity);
    }
  }

  void syncStravaActivites() {
    print("SYNCING STRAVA ACTIVITIES");
    if (stravaRefreshToken.isNotEmpty) {
      StravaService().getActivities();
    }
  }

  static void sendPendingActivities() async {
    var shouldSync = DataManager().allPendingActivities.isNotEmpty;
    List<StravaNewActivityApiModel> toRemove = [];
    for (var element in DataManager().allPendingActivities) {
      var result = await StravaService().addActivity(element);
      if (result) {
        toRemove.add(element);
      }
    }
    DataManager()
        .allPendingActivities
        .removeWhere((element) => toRemove.contains(element));
    if (shouldSync) {
      StravaService().getActivities();
    }
  }

  void checkStravaToken() {
    DateTime now = DateTime.now();
    int epochTime = now.millisecondsSinceEpoch ~/ 1000;
    if (epochTime > expiresAt && stravaRefreshToken.isNotEmpty) {
      print("WILL REFRESH TOKEN");
      StravaService().getToken(true);
    }
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('stravaCode', stravaCode);
    await prefs.setString('stravaToken', stravaToken);
    await prefs.setString('stravaRefreshToken', stravaRefreshToken);
    await prefs.setInt('expiresAt', expiresAt);
  }

  Future<void> readData() async {
    print("READING DATA1");
    await SharedPreferences.getInstance().then((prefs) {
      print("READING DATA");
      stravaCode = prefs.getString('stravaCode') ?? "";
      stravaToken = prefs.getString('stravaToken') ?? "";
      stravaRefreshToken = prefs.getString('stravaRefreshToken') ?? "";
      expiresAt = prefs.getInt('expiresAt') ?? 0;
    });
  }

  Future<void> getProfileData() async {
    var localProfiledata = ProfileData();
    await DeportistaService().getData().then((value) {
      localProfiledata.weight = value?.pesoInicial ?? 0.0;
      localProfiledata.newWeight = value?.pesoActual ?? 0.0;
      localProfiledata.imc =
          calculateImc(localProfiledata.weight, value?.altura ?? 1.0);
      localProfiledata.newImc =
          calculateImc(localProfiledata.newWeight, value?.altura ?? 1.0);
    });
    await EntrenamientoService().getCompletados().then((value) {
      localProfiledata.lastMonthTrainings = value;
    });
    await EventosService().getAsistidos().then((value) {
      localProfiledata.lastMonthEvents = value;
    });

    localProfiledata.sessions =
        localProfiledata.lastMonthTrainings + localProfiledata.lastMonthEvents;
    localProfiledata.progress = double.parse(
        ((localProfiledata.sessions / 30) * 100).toStringAsFixed(2));
    profileData = localProfiledata;
  }

  double calculateImc(double weight, double height) {
    return double.parse((weight / (height * height)).toStringAsFixed(2));
  }
}
