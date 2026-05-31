import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

import 'controller/auth_controller.dart';
import 'controller/volatile_controller.dart';

import 'view/login_view.dart';
import 'view/cadastro_view.dart';
import 'view/recuperar_senha_view.dart';
import 'view/sobre_view.dart';
import 'view/home_view.dart';
import 'view/cadastro_planta_view.dart';
import 'view/editar_planta_view.dart';
import 'view/detalhes_view.dart';
import 'view/referencias_view.dart';
import 'view/pesquisa_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final getIt = GetIt.instance;

  // Registro dos Singletons
  if (!getIt.isRegistered<AuthController>()) {
    getIt.registerSingleton<AuthController>(AuthController());
  }

  if (!getIt.isRegistered<VolatileController>()) {
    getIt.registerSingleton<VolatileController>(VolatileController());
  }

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,

      title: 'VolatileConnect',

      theme: ThemeData(
        primaryColor: const Color(0xFF1B3D2F),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1B3D2F),
        ),
        useMaterial3: true,
      ),

      initialRoute: 'login',

      routes: {
        'login': (context) => const LoginView(),
        'cadastro': (context) => const CadastroView(),
        'recuperar_senha': (context) => const RecuperarSenhaView(),
        'sobre': (context) => const SobreView(),
        'home': (context) => const HomeView(),
        'detalhes': (context) => const DetalhesView(),
        'cadastro_planta': (context) => const CadastroPlantaView(),
        'editar_planta': (context) => const EditarPlantaView(),
        'referencias': (context) => const ReferenciasView(),
        'pesquisa': (context) => const PesquisaView(),
      },
    );
  }
}