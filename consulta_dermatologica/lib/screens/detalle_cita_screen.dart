import 'package:flutter/material.dart';

class DetalleCitasScreen extends StatelessWidget {
  // Supongamos que tienes una lista de citas con la siguiente estructura
  // Puedes cambiar esta estructura según tus necesidades
  final List<CitaModel3> citas = [
    CitaModel3(dia: "2023-11-20", hora: "10:00 AM", servicio: "Dermatología"),
    CitaModel3(dia: "2023-11-21", hora: "02:30 PM", servicio: "Consulta General"),
    // Agrega más citas según sea necesario
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ver Citas'),
      ),
      body: ListView.builder(
        itemCount: citas.length,
        itemBuilder: (context, index) {
          final cita = citas[index];
          return ListTile(
            title: Text('Día: ${cita.dia}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hora: ${cita.hora}'),
                Text('Servicio: ${cita.servicio}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
class CitaModel3 {
  final String dia;
  final String hora;
  final String servicio;

  CitaModel3({
    required this.dia,
    required this.hora,
    required this.servicio,
  });
}
