import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';
import 'package:sportapp_movil/calendar_activities.dart';

import 'package:sportapp_movil/main.dart';
import 'package:sportapp_movil/plan_selector_view.dart';

void main() {
  Future<void> goToSignIn(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1290 * 3, 2796 * 3);

    disableOverflowError();
    await tester.pumpWidget(const MyApp());
    expect(
        find.textContaining('Por favor selecciona tu idioma'), findsOneWidget);
    expect(find.textContaining('Español'), findsOneWidget);
    expect(find.textContaining('English'), findsOneWidget);

    await tester.tap(find.bySemanticsLabel("Español"));
    await tester.pumpAndSettle();
    expect(find.textContaining('Usuario'), findsOneWidget);
    expect(find.textContaining('Contraseña'), findsOneWidget);
    await tester.tap(find.bySemanticsLabel("Sign In"));
    await tester.pumpAndSettle();
  }

  // testWidgets('Test language selector', (WidgetTester tester) async {
  //   await goToSignIn(tester);
  // });

  testWidgets('Test calendar', (WidgetTester tester) async {
    await goToSignIn(tester);
    await tester.tap(find.byKey(Key("calendar_navbar_button")));
    await tester.pumpAndSettle();
    expect(find.textContaining('Rumba'), findsOneWidget);
    await tester.tap(find.textContaining("12"));
  });

  testWidgets('Test sesion deportologo', (WidgetTester tester) async {
    await goToSignIn(tester);
    await tester.tap(find.textContaining("Agendar Sesion"));
    await tester.pumpAndSettle();
    expect(find.textContaining('Cita'), findsOneWidget);
    await tester.tap(find.textContaining("Selecciona la opción"));
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining("Santiago no sabe que poner acá 1"));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.calendar_month));
    await tester.pumpAndSettle();
    await tester.tap(find.text("ACEPTAR"));
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining("Guardar"));
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining("OK"));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key("icon_back")));
    await tester.pumpAndSettle();
    expect(find.textContaining('Plan Premium'), findsOneWidget);
  });

  testWidgets('Test plan', (WidgetTester tester) async {
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
  });
}
