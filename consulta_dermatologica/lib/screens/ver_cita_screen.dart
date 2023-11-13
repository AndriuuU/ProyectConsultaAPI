import 'package:consulta_dermatologica/models/models.dart';
import 'package:consulta_dermatologica/services/Citas_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'screens.dart';

class VercitaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            Provider.of<CitasService>(context, listen: false).getListCitas(); // Actualizar citas al hacer clic en el icono del calendario
          },
        ),
        title: Text("Mis citas"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Consumer<CitasService>(
      builder: (context, citasService, child) {
          if (citasService.isLoading) {
            return Center(
              child: CircularProgressIndicator(), // Indicador de carga mientras se cargan las citas
            );
          } else if (citasService.hasError) {
            return Center(
              child: Text('Error al cargar las citas'), // Mostrar un mensaje de error si hay algún problema al cargar las citas
            );
          } else if (citasService.listaCitas.isEmpty) {
            return Center(
              child: Text('No hay citas disponibles'), // Mostrar un mensaje si no hay citas disponibles
            );
          } else {
            return _ListViewBody(citasService.listaCitas); // Mostrar la lista de citas si se han cargado correctamente
          }
        },
      ),
      // Resto del código como lo tienes...
    );
  }

 Widget _ListViewBody(List<CitasModel> listCitas) {
  final ScrollController _homeController = ScrollController();

  return ListView.builder(
    controller: _homeController,
    itemCount: listCitas.length,
    itemBuilder: (context, index) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(15),
        elevation: 10,
        child: Column(
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 20),
              title: Text(formatDateTime(listCitas[index].fechaCompleta)),
              subtitle: Text(listCitas[index].cliente.email + " "),
              leading: Icon(Icons.send_sharp),
              iconColor: Color.fromARGB(255, 0, 167, 200),
              trailing: IconButton(

                icon: Icon(Icons.delete),
                color: Colors.red,
                 onPressed: () {
                  // Mostrar cuadro de diálogo de confirmación
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirmar eliminación'),
                        content: Text('¿Desea cancelar la cita?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
                            },
                            child: Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Lógica para eliminar la cita
                              Provider.of<CitasService>(context, listen: false).eliminarCita(listCitas[index].id);
                              
                              Navigator.of(context).pop();
                              Provider.of<CitasService>(context, listen: false).getListCitas();
                               // Cerrar el cuadro de diálogo
                            },
                            child: Text('Aceptar'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[],
            )
          ],
        ),
      );
    },
  );
}
  String formatDateTime(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString);
      String formattedDate = DateFormat("dd/MM/yyyy").format(dateTime);
      String formattedTime = DateFormat("HH:mm").format(dateTime);
      return 'Cita: $formattedDate a las $formattedTime.';
    } catch (e) {
      // Manejar el error de formato aquí
      print('Error al parsear la fecha: $e');
      return 'Formato de fecha inválido.';
    }
  }
}
