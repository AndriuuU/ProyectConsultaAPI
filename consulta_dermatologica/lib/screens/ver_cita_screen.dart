import 'package:consulta_dermatologica/models/models.dart';
import 'package:consulta_dermatologica/services/Citas_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'screens.dart';

class VercitaScreen extends StatefulWidget {
   VercitaScreen({Key? key}) : super(key: key);

  @override
  State<VercitaScreen> createState() => _VercitaScreen();
}

class _VercitaScreen extends State<VercitaScreen> {
  int _selectedIndex = 0;
  final ScrollController _homeController = ScrollController();
 
  // List<Articles> listCitas =[];

  Widget _listViewBody(BuildContext context) {
    final getCitas = Provider.of<CitasService>(context);
    List<CitasModel> listCitas = getCitas.listaCitas;

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
                      title: Text(formatDateTime(listCitas[index].fechaCita),),
                      subtitle: Text(listCitas[index].cliente.nombre),
                      
                      leading: Icon(Icons.send_sharp),
                      iconColor: Color.fromARGB(255, 0, 167, 200),
                    
                  ),
                  
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[

                    ],
                  )
                ],
              ),
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            leading: IconButton(
            icon: Icon(Icons.calendar_month_outlined),
            onPressed: () => Navigator.pushReplacementNamed(context, 'vercita')
          ),
            title: Text("Mis citas"),
            backgroundColor: Color.fromARGB(255, 93, 109, 236)
          ),
      body: _listViewBody(context),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.edit_calendar),
            label: 'Mis citas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Mostrar calendario',
            //onPressed: () => Navigator.pushReplacementNamed(context, 'vercita')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Nueva cita',
            //onPressed: () => Navigator.pushReplacementNamed(context, 'vercita')
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 111, 0, 255),
        onTap: (int index) {
          switch (index) {
            case 0:
              // only scroll to top when current index is selected.
              if (_selectedIndex == index) {
                _homeController.animateTo(
                  0.0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                );
              }
              break;
            case 1:
              Navigator.pushReplacementNamed(context, 'calendariocitas');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, 'obtenercita');
              break;
          }
          setState(
            () {
              _selectedIndex = index;
            },
          );
        },
      ),
    );
  }
   String formatDateTime(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat("dd/MM/yyyy").format(dateTime);
    String formattedTime = DateFormat("HH:mm").format(dateTime);

    return 'Cita: $formattedDate a las $formattedTime.';
  }
}