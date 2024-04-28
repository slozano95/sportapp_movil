import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nock/nock.dart';
import 'package:http/http.dart' as http;
import 'package:sportapp_movil/calendar_activities.dart';
import 'package:sportapp_movil/constants.dart';
import 'package:sportapp_movil/datamanager.dart';
import 'package:sportapp_movil/heart_monitoring.dart';
import 'package:sportapp_movil/main.dart';
import 'package:sportapp_movil/plan_selector_view.dart';
import 'package:sportapp_movil/services/models/deportista_api_model.dart';
import 'package:sportapp_movil/services/models/entrenamiento_api_model.dart';
import 'package:sportapp_movil/services/models/entrenamiento_completado_api_model.dart';
import 'package:sportapp_movil/services/models/eventos_api_model.dart';
import 'package:sportapp_movil/services/models/exercises_api_model.dart';
import 'package:sportapp_movil/services/models/simulator_api_model.dart';
import 'package:sportapp_movil/services/models/strava_activity_api_model.dart';
import 'package:sportapp_movil/services/models/strava_new_activity_api_model.dart';
import 'package:sportapp_movil/services/models/strava_token_api_model.dart';
import 'package:sportapp_movil/services/strava_service.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  setUpAll(() {});

  setUp(() {});

  testWidgets('Test models', (WidgetTester tester) async {
    DeportistaApiModel().toJson();
    EntrenamientoCompletadoApiModel().toJson();
    EntrenamientosModel().toJson();
    Ejercicio().toJson();
    Evento().toJson();
    EntrenamientoCompletadoApiModel().toJson();
    EventosApiModel().toJson();
    ExercisesApiModel().toJson();
    SimulatorApiModel(
            heartRate: 0,
            id: "",
            lastHeartRate: 120,
            maxCambio: "10",
            maxHeartrate: "",
            minCambio: "",
            minHeartrate: "")
        .toJson();
    StravaActivityApiModel.fromJson({}).toJson();
    AAthlete.fromJson({}).toJson();
    MapClass().toJson();
    MapClass.fromJson({});
    StravaNewActivityApiModel.fromJson({});
    StravaTokenApiModel.fromJson({}).toJson();
    Athlete.fromJson({}).toJson();
    StravaService().getToken(false);
  });
}
