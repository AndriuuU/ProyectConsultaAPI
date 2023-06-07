import 'package:consulta_dermatologica/models/models.dart';
import 'package:consulta_dermatologica/services/Citas_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                    // if(listCitas[index].deleted==0)
                      contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 20),
                      title: Text('Fecha: '+listCitas[index].fechaCita),
                      subtitle: Text(listCitas[index].cliente.nombre),
                      
                      leading: Icon(Icons.send_sharp),
                      iconColor: Color.fromARGB(255, 0, 167, 200),
                    
                    // iconColor: (listPedidos[index].delivery_notes==0) ? Color.fromRGBO(200, 0, 0, 1) : Color.fromARGB(255, 59, 193, 73),

                   
                    
                    // leading: (listPedidos[index].delivery_notes==0) ? 'Eligible for license' : 'Not eligible'
                    
                    // if(listPedidos[index].delivery_notes==0) {

                    // }
                  ),
                  
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      // (listPedidos[index].delivery_notes==0) ? Icon(Icons.short_text, color: Color.fromRGBO(200, 0, 0, 1)) : Icon(Icons.short_text, color: Color.fromARGB(255, 59, 193, 73)),
                      // (listPedidos[index].invoices==0) ? Icon(Icons.speaker_notes_rounded, color: Color.fromRGBO(200, 0, 0, 1)) : Icon(Icons.speaker_notes_rounded, color: Color.fromARGB(255, 59, 193, 73)),
                      // // Icon(icon): (listPedidos[index].delivery_notes==0) ? Color.fromRGBO(200, 0, 0, 1) : Color.fromARGB(255, 59, 193, 73),

                      // FlatButton(onPressed: () => {}, child: Text('Aceptar')),
                      // FlatButton(onPressed: () => {}, child: Text('Cancelar'))
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
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pushReplacementNamed(context, 'home')
          ),
            title: Text("Catalogo"),
            backgroundColor: Color.fromARGB(255, 93, 109, 236)
          ),
      body: _listViewBody(context),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add article',
            // onPressed: addArticulo(),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
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
              showModal(context);
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

  void showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('Example Dialog'),
        actions: <TextButton>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          )
        ],
      ),
    );
  }

  // void addArticulo() {
  //   setState(() {
  //     articles.add(articles[0]);
  //   });
  // }
}