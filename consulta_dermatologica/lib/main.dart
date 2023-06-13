import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/screens.dart';
import 'services/auth_service.dart';
import 'services/services.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => CitasService()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'login',
      routes: {
        'login': ( _ ) => LoginScreen(),
        'register': (_) => RegisterScreen(),
        'home': (_) => HomeScreen(),
        'calendariocitas': (_) => CalendarioCitasScreen(),
        'obtenercita': (_) => ObtenerCita(),
        'vercita': (_) => VercitaScreen(),
        'calendarioadmin': (_) => CalendarioCitasAdminScreen(),
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300]
      ),
    );
  }
}