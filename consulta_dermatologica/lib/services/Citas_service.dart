
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:consulta_dermatologica/models/models.dart';



class CitasService extends ChangeNotifier{
  final String _baseUrl="192.168.1.137:8080";
  final storage = FlutterSecureStorage();
  //final String _firebaseToken='';
  CitasService() {
    this.getListCitas();
  }

  List<CitasModel> listaCitas=[];

  getListCitas() async {

    String? id= await storage.read(key: 'usurname');
    final url=Uri.http(_baseUrl,'/api/get/citas/cliente/'+id!,{});
    print(url);
    final resp = await http.get(url, 
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Some token"
        } );

    print(resp.body);
    dynamic jsonResponse = jsonDecode(resp.body);

    if (jsonResponse is List) {
      listaCitas = jsonResponse
          .map((json) => CitasModel.fromJson(json))
          .toList();
    } else {
      // Manejar el caso en el que el JSON no sea una lista
      listaCitas = [];
    }

    notifyListeners();

  }
  
    
}
