
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:consulta_dermatologica/models/models.dart';

import 'auth_service.dart';



class CitasService extends ChangeNotifier{
  final String _baseUrl="192.168.1.137:8080";
  final storage = FlutterSecureStorage();
  //final String _firebaseToken='';
  CitasService() {
    this.getListCitas();
  }

  List<CitasModel> listaCitas=[];

  getListCitas() async {

    String token= await AuthService().readToken();
    final url=Uri.http(_baseUrl,'/api/get/citas',{});
    print(url);

    final resp = await http.get(url, 
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": token
        } );

    print(resp.body);

   if (resp.statusCode == 200) {
    final responseBody = json.decode(resp.body);


    for (var citaMap in responseBody) {
      listaCitas.add(CitasModel.fromJson(citaMap));
    }

    // Aquí tienes la lista final de citas
    print(listaCitas);
  } else {
    print('Error en la solicitud: ${resp.statusCode}');
  }
    notifyListeners();

  }
  
    
}
