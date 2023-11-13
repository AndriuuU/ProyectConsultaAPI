
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:consulta_dermatologica/models/models.dart';




class ServicioService extends ChangeNotifier{
  final String _baseUrl="192.168.1.142:8080";
  //final String _firebaseToken='';
  ServicioService() {
    this.getListService();
  }

  List<ServicioModel> listaServicios=[];

  getListService() async {

    final url=Uri.http(_baseUrl,'/api/all/servicios/',{});
    print(url);

    final resp = await http.get(url, 
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Some token"
        } );

    print(resp.body);

   if (resp.statusCode == 200) {
    final responseBody = json.decode(resp.body);


    for (var ServiceMap in responseBody) {
      listaServicios.add(ServicioModel.fromJson(ServiceMap));
    }

    // Aquí tienes la lista final de citas
    print(listaServicios);
  } else {
    print('Error en la solicitud: ${resp.statusCode}');
  }
    notifyListeners();

  }
  
    
}
