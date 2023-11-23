import 'package:consulta_dermatologica/screens/routes.dart';
import 'package:consulta_dermatologica/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';
import 'services/auth_service.dart';
import 'services/services.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  // Inicializar la información de localización para el formato de fecha en español
  initializeDateFormatting('es');

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => CitasService()),
        ChangeNotifierProvider(create: (_) => ServicioService()),
        ChangeNotifierProvider(create: (_) => CogerCitasService()),
        ChangeNotifierProvider(create: (_) => UserService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme: ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.grey[300]),
        initialRoute: Routes.login,
        routes: Routes.getRoutes(context),
        
      ),
    );
  }
}
class PaginaPrincipal extends StatefulWidget {
  @override
  _PaginaPrincipalState createState() => _PaginaPrincipalState();
}
class _PaginaPrincipalState extends State<PaginaPrincipal> {
  int _paginaActual = 0;
  final PageController _pageController = PageController();

  // Agrega la definición de _paginas aquí
  final List<Widget> _paginas = [
    VercitaScreen(),
    ObtenerCita(),
    CalendarioCitasScreen(),
    // Agrega más instancias de clases de pantalla según sea necesario.
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _paginas,
        onPageChanged: (index) {
          setState(() {
            _paginaActual = index;
          });
        },
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          // Establece el color de los iconos aquí
          iconTheme: IconThemeData(color: const Color.fromARGB(255, 226, 33, 243)),
        ),
      child: BottomNavigationBar(
        currentIndex: _paginaActual,
        onTap: (index) {
          setState(() {
            _paginaActual = index;
            _pageController.jumpToPage(index);
          });
        },
        items: [
          BottomNavigationBarItem(
            
            icon: Icon(Icons.home),
            
            label: 'Mis citas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Nueva cita',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Calendario',
          ),
          // Agrega más elementos según sea necesario.
        ],
      ),
      )
    );
  }
  
}
class PaginaAdmin extends StatefulWidget {
  @override
  _PaginaAdminState createState() => _PaginaAdminState();
}

class _PaginaAdminState extends State<PaginaAdmin> {
  int _paginaActual = 0;
  final PageController _pageController = PageController();

  // Agrega la definición de _paginasAdmin aquí
  final List<Widget> _paginasAdmin = [
    //VerUsuariosScreen(),
    CalendarioCitasAdminScreen(),
    // Agrega más instancias de clases de pantalla según sea necesario.
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _paginasAdmin,
        onPageChanged: (index) {
          setState(() {
            _paginaActual = index;
          });
        },
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          // Establece el color de los iconos aquí
          iconTheme: IconThemeData(color: const Color.fromARGB(255, 226, 33, 243)),
        ),
        child: BottomNavigationBar(
          currentIndex: _paginaActual,
          onTap: (index) {
            setState(() {
              _paginaActual = index;
              _pageController.jumpToPage(index);
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle),
              label: 'Ver Usuarios',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Calendario Admin',
            ),
            // Agrega más elementos según sea necesario.
          ],
        ),
      ),
    );
  }
}

