import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:consulta_dermatologica/models/models.dart';



class AuthService extends ChangeNotifier{
  final String _baseUrl="192.168.1.142:8080";
  final storage = FlutterSecureStorage();
  //final String _firebaseToken='';

  Future<String?> createUser(String name,String email,bool seguro,String direccion,String telefono, String password) async {
    
    final Map<String, dynamic> authData = {
      'nombre': name,
      'email': email,
      'seguro': seguro,
      'direccion': direccion,
      'telefono': telefono,
      'password': password,
    };

    final url=Uri.http(_baseUrl,'/api/register/cliente',{});
    
    print(authData);
    final resp = await http.post(url, 
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Some token"
        },body: json.encode(authData));

    final Map<String, dynamic> decodeResp = json.decode(resp.body);
    
    print(decodeResp);
    if(decodeResp!=null){
      
      return decodeResp['message'];
    }else{
      
      return null;
    }

    
  }

Future<UsuarioModel?> login(String username, String password) async {
  final Map<String, dynamic> authData = {
    'username': username,
    'password': password,
  };

  try {
    final url = Uri.http(_baseUrl, '/api/login', {});
    final resp = await http.post(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Some token"
        },
        body: json.encode(authData));

    if (resp.statusCode == 200) {
      var a = UsuarioModel.fromJson(resp.body);
      notifyListeners();
      await storage.write(key: 'token', value: a.token);
      await storage.write(key: 'usurname', value: a.username);
      print(await storage.read(key: 'usurname'));
      print(a.username);
      return a;
    } else {
      // Si el servidor devuelve un código de error, maneja el error aquí
      print('Error: ${resp.statusCode}');
      return null;
    }
  } catch (e) {
    // Si ocurre un error durante la conexión, maneja el error aquí
    print('Error de conexión: $e');
    return null;
  }
}

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  Future<String> readUsername() async {
    return await storage.read(key: 'usurname') ?? '';
  }
  
}


class ListClientes extends ChangeNotifier{
  final String _baseUrl="192.168.1.142:8080";
  //final String _firebaseToken='';
  listClientes() {
    this.getListClientes();
  }

  List<ClienteModel> listaClienteAdmin=[];

  getListClientes() async {

    final url=Uri.http(_baseUrl,'/api/all/cliente',{});
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


    for (var citaMap in responseBody) {
      listaClienteAdmin.add(ClienteModel.fromJson(citaMap));
    }

    // Aquí tienes la lista final de citas
    print(listaClienteAdmin);
  } else {
    print('Error en la solicitud: ${resp.statusCode}');
  }
    notifyListeners();

  }
  
}
