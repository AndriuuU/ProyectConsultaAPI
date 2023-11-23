
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:consulta_dermatologica/models/models.dart';
import 'package:intl/intl.dart';

import 'auth_service.dart';

class UserService extends ChangeNotifier {
  final String _baseUrl = "192.168.1.142:8080";
  final storage = FlutterSecureStorage();


  
  Future<ClienteModel2?> getUser() async {
     String token = await AuthService().readToken();
     final url=Uri.http(_baseUrl,'/api/get/cliente',{});

     final resp = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": token,
      });
      
      print(resp.body);

       final Map<String, dynamic> decodeResp = json.decode(resp.body);

        if (resp.statusCode == 200) {
          var a = ClienteModel2.fromJson(resp.body);
         
          notifyListeners();
          return a;
        }else{ 
          return null;
        }
  }
  Future<bool> updateCliente(String name,String address,String phone,String email) async {
    String token = await AuthService().readToken();
    final url = Uri.http(_baseUrl, '/api/update/cliente');

    final Map<String, dynamic> citaData = {
          'nombre': name,
          "email": email,
          "direccion": address,
          "telefono": phone
          
        };
    final resp = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": token,
      },
      body: json.encode(citaData),
    );

    if (resp.statusCode == 201) {
      print('Cliente actualizado con éxito');
      return true;
    } else {
      print('Error al actualizar el cliente');
      return false;
    }
  }

}
