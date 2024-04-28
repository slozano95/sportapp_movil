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

import '../test/tes.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
  final client = MockClient();

  setUpMocks() {
    when(client.get(Uri.parse('$baseUrl/simulator/1'), headers: {
      "Content-Type": "application/json"
    })).thenAnswer((_) async => http.Response(
        '{ "heart_rate": 261, "id": "1", "last_heart_rate": 276, "max_cambio": "20", "max_heartrate": "300", "min_cambio": "10", "min_heartrate": "150" }',
        200));
    when(client.get(Uri.parse('$baseUrl/simulator/1'), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer "
    })).thenAnswer((_) async => http.Response(
        '{ "heart_rate": 261, "id": "1", "last_heart_rate": 276, "max_cambio": "20", "max_heartrate": "300", "min_cambio": "10", "min_heartrate": "150" }',
        200));
  }

  setUpAll(() {
    setUpMocks();
  });

  setUp(() {});

  Future<void> goToSignIn(WidgetTester tester) async {
    // tester.view.physicalSize = const Size(1290 * 3, 2796 * 3);

    // disableOverflowError();
    await tester.pumpWidget(MyApp(client));
    expect(find.textContaining('Selecciona tu Idioma'), findsOneWidget);
    expect(find.textContaining('Español'), findsOneWidget);
    expect(find.textContaining('English'), findsOneWidget);

    await tester.tap(find.bySemanticsLabel("Español"));
    await tester.pumpAndSettle();
    expect(find.textContaining('Usuario'), findsOneWidget);
    expect(find.textContaining('Contraseña'), findsOneWidget);
    await tester.enterText(find.byKey(const Key("user")), '1');
    await tester.tap(find.bySemanticsLabel("Ingresar"));
    await tester.pumpAndSettle();
  }

  testWidgets('Test calendar', (WidgetTester tester) async {
    await goToSignIn(tester);
    await tester.tap(find.byKey(const Key("calendar_navbar_button")));
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining("12"));
  });

  testWidgets('Test heartrate', (WidgetTester tester) async {
    FlutterError.onError = (details) {};
    await goToSignIn(tester);
    await tester.tap(find.textContaining("Monitorea"));
    await tester.pumpAndSettle();
    expect(find.textContaining('Iniciar'), findsOneWidget);
    await tester.tap(find.textContaining("Iniciar"));
    await Future.delayed(Duration(seconds: 2));
    expect(find.textContaining('Finalizar'), findsOneWidget);
  });

  testWidgets('Test sesion deportologo', (WidgetTester tester) async {
    await goToSignIn(tester);
    await tester.tap(find.textContaining("Agendar Sesion"));
    await tester.pumpAndSettle();
    expect(find.textContaining('Cita'), findsOneWidget);
    await tester.tap(find.textContaining("Selecciona la opción"));
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining("Presencial"));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.calendar_month));
    await tester.pumpAndSettle();
    await tester.tap(find.text("ACEPTAR"));
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining("Guardar"));
    await tester.pumpAndSettle();
    // await tester.tap(find.textContaining("Aceptar"));
    // await tester.pumpAndSettle();
    // await tester.tap(find.byKey(const Key("icon_back")));
    // await tester.pumpAndSettle();
    // expect(find.textContaining('Plan Premium'), findsOneWidget);
  });

  testWidgets('Test plan', (WidgetTester tester) async {
    // FlutterError.onError = (details) {};
    await goToSignIn(tester);
    DataManager().stravaCode = "123";
    DataManager().stravaToken = "bla";
    DataManager().stravaRefreshToken = "bla";
    DataManager().expiresAt =
        DateTime.now().add(Duration(days: 1)).millisecondsSinceEpoch;
    await tester.tap(find.textContaining("Plan Entrenamiento"));
    await tester.pumpAndSettle();
    expect(find.textContaining('Plan de Entrenamiento'), findsOneWidget);
    await tester.tap(find.textContaining("Ciclismo"));
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining("Iniciar sesión"));
    await tester.pump(Durations.extralong4);
    await tester.tap(find.textContaining("Finalizar"));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Key("icon_back")));
    await tester.pumpAndSettle();
    expect(find.textContaining('Plan de Entrenamiento'), findsOneWidget);
  });

  testWidgets('Test profile', (WidgetTester tester) async {
    await goToSignIn(tester);
    await tester.tap(find.byKey(Key("profile_navbar_button")));
    await tester.pumpAndSettle();
    expect(find.textContaining('Tablero'), findsOneWidget);
  });

  testWidgets('Test add plan', (WidgetTester tester) async {
    await goToSignIn(tester);
    await tester.tap(find.textContaining("Plan Entrenamiento"));
    await tester.pumpAndSettle();
    expect(find.textContaining('Plan de Entrenamiento'), findsOneWidget);
    await tester.tap(find.byKey(Key("icon_add")));
    await tester.pumpAndSettle();
    expect(find.textContaining('Agregar entrenamiento'), findsOneWidget);
    await tester.tap(find.textContaining("Guardar"));
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining("OK"));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key("nombre")), 'tester');
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Key("calendar")));
    await tester.pumpAndSettle();
    await tester.tap(find.text("ACEPTAR"));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Key("+_prensa")));
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining("Guardar"));
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining("OK"));
  });

  testWidgets('Test Strava', (WidgetTester tester) async {
    await goToSignIn(tester);
    await tester.tap(find.byKey(const Key("book_navbar_button")));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key("strava_logo")));
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining("Aceptar"));
  });

  testWidgets('Test Strava2', (WidgetTester tester) async {
    await goToSignIn(tester);
    DataManager().stravaCode = "123";
    DataManager().stravaToken = "bla";
    DataManager().stravaRefreshToken = "bla";
    DataManager().expiresAt =
        DateTime.now().add(Duration(days: 1)).millisecondsSinceEpoch;
    await tester.tap(find.byKey(const Key("book_navbar_button")));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key("strava_logo")));
    await tester.pumpAndSettle();
    await tester.tap(find.text("Desconectar"));
    await tester.pumpAndSettle();
  });
}
