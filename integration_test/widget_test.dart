import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nock/nock.dart';
import 'package:sportapp_movil/calendar_activities.dart';
import 'package:sportapp_movil/constants.dart';
import 'package:sportapp_movil/datamanager.dart';
import 'package:sportapp_movil/main.dart';
import 'package:sportapp_movil/plan_selector_view.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    nock.defaultBase =
        "http://a1b7563a0858f4f71b48c713a5de8c20-991979942.us-east-1.elb.amazonaws.com";
    nock.init;
  });

  void mockServices() {
    nock.get('/ejercicios/all').reply(
        200,
        json.encode(
            '[{"estado":true,"id_ejercicio":"3d05ea31-aa8a-4e1d-84a1-ce5277a6ddcb","nombre":"cara","url_imagen":"https://picsum.photos/200/300?r=214"},{"estado":true,"id_ejercicio":"65ac15c9-0072-4f6c-92de-f5bee26f90bf","nombre":"Pantorrilla","url_imagen":"https://picsum.photos/200/300?r=2"},{"estado":true,"id_ejercicio":"1f8b4936-0a63-42dc-ae59-2eb347780038","nombre":"antebrazo","url_imagen":"https://picsum.photos/200/300?r=22"},{"estado":true,"id_ejercicio":"3cd95de3-2568-4061-b117-16cebffd59c9","nombre":"Pierna","url_imagen":"https://picsum.photos/200/300?r=24"},{"estado":true,"id_ejercicio":"538f226a-6a24-4c0a-a2ef-4a7e2d32db82","nombre":"espalda","url_imagen":"https://picsum.photos/200/300?r=232"}]'));
    nock.get('/entrenamientos/user/07adc016-82eb-4c92-b722-0e80ebfdcfe5').reply(
        200,
        json.encode(
            '[{"ejercicios":[{"estado":true,"id_ejercicio":"3d05ea31-aa8a-4e1d-84a1-ce5277a6ddcb","nombre":"cara","numero_repeticiones":3,"url_imagen":"https://picsum.photos/200/300?r=214"},{"estado":true,"id_ejercicio":"1f8b4936-0a63-42dc-ae59-2eb347780038","nombre":"antebrazo","numero_repeticiones":2,"url_imagen":"https://picsum.photos/200/300?r=22"},{"estado":true,"id_ejercicio":"3cd95de3-2568-4061-b117-16cebffd59c9","nombre":"Pierna","numero_repeticiones":1,"url_imagen":"https://picsum.photos/200/300?r=24"}],"estado":true,"fecha_entrenamiento":"2024-04-17","id_entrenamiento":"c3fbe103-881a-4dc5-8bb2-93cf31f72106","id_usuario":"07adc016-82eb-4c92-b722-0e80ebfdcfe5","nombre":"mov2"}]'));
  }

  setUp(() {
    mockServices();
    nock.cleanAll();
  });

  Future<void> goToSignIn(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1290 * 3, 2796 * 3);

    disableOverflowError();
    await tester.pumpWidget(const MyApp());
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
    await tester.tap(find.textContaining("Aceptar"));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key("icon_back")));
    await tester.pumpAndSettle();
    expect(find.textContaining('Plan Premium'), findsOneWidget);
  });

  testWidgets('Test plan', (WidgetTester tester) async {
    FlutterError.onError = (details) {};
    await goToSignIn(tester);
    await tester.tap(find.textContaining("Plan Entrenamiento"));
    await tester.pumpAndSettle();
    expect(find.textContaining('Plan de Entrenamiento'), findsOneWidget);
    await tester.tap(find.textContaining("Ciclismo"));
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining("Iniciar sesión"));
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining("Finalizar sesión"));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Key("icon_back")));
    await tester.pumpAndSettle();
    expect(find.textContaining('Plan de Entrenamiento'), findsOneWidget);
  });

  testWidgets('Test profile', (WidgetTester tester) async {
    FlutterError.onError = (details) {};
    await goToSignIn(tester);
    await tester.tap(find.byKey(Key("profile_navbar_button")));
    await tester.pumpAndSettle();
    expect(find.textContaining('Tablero'), findsOneWidget);
  });

  testWidgets('Test add plan', (WidgetTester tester) async {
    FlutterError.onError = (details) {};
    await goToSignIn(tester);
    await tester.tap(find.textContaining("Plan Entrenamiento"));
    await tester.pumpAndSettle();
    expect(find.textContaining('Plan de Entrenamiento'), findsOneWidget);
    await tester.tap(find.byKey(Key("icon_add")));
    await tester.pumpAndSettle();
    expect(find.textContaining('Agregar entrenamiento'), findsOneWidget);
  });
}
