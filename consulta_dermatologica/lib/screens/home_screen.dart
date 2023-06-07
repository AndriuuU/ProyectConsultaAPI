import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Color.fromARGB(255, 93, 109, 236)
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'obtenercita');
              },
              child: Text('Obtener Cita'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'vercita');
              },
              child: Text('Ver Cita'),
            ),
           
          ],
        ),
      ),
    );
  }
}