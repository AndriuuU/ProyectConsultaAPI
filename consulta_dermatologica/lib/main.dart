import 'package:consulta_dermatologica/screens/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';
import 'services/auth_service.dart';
import 'services/services.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => CitasService()),
        ChangeNotifierProvider(create: (_) => ServicioService()),
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
      bottomNavigationBar: BottomNavigationBar(
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
    );
  }
}
