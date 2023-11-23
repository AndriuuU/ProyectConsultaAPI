import 'package:consulta_dermatologica/screens/screens.dart';
import 'package:flutter/material.dart';

import 'detalle_cita_screen.dart';

class Routes {
  static const String login = "login";
  static const String register = "register";
  static const String home = "home";
  static const String calendarioCitas = "calendarioCitas";
  static const String obtenerCita = "obtenerCita";
  static const String verCita = "verCita";
  static const String calendarioAdmin = "calendarioAdmin";
  static const String user="UserProfile";
  static const String detalle="detalle";
  // static const String PaginaPrincipal="paginaPrincipal";

  static Map<String, WidgetBuilder> getRoutes(BuildContext context) {
    return {
      login: (context) => LoginScreen(),
      register: (context) => RegisterScreen(),
      home: (context) => HomeScreen(),
      // PaginaPrincipal: (context) => PaginaPrincipal(),
      calendarioCitas: (context) => CalendarioCitasScreen(),
      obtenerCita: (context) => ObtenerCita(),
      verCita: (context) => VercitaScreen(),
      calendarioAdmin: (context) => CalendarioCitasAdminScreen(),
      user: (context) => UserProfileScreen(),
      detalle:(context) => DetalleCitasScreen(),
    };
  }
}
