import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:volatile_connect/main.dart';
import 'package:volatile_connect/controller/volatile_controller.dart';
import 'package:volatile_connect/controller/auth_controller.dart';

void main() {
  setUpAll(() {
    final getIt = GetIt.instance;
    getIt.reset();
    getIt.registerSingleton<AuthController>(AuthController());
    getIt.registerSingleton<VolatileController>(VolatileController());
  });

  testWidgets('Verifica se a tela de Login carrega corretamente', (WidgetTester tester) async {

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    
    expect(find.byType(TextField), findsAtLeastNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('VolatileConnect'), findsOneWidget);

    debugPrint('Teste técnico realizado: Interface de login carregada e validada');
  });
}