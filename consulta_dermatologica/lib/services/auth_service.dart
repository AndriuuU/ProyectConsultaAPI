import 'dart:convert';
import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:consulta_dermatologica/models/models.dart';



class AuthService extends ChangeNotifier{
  final String _baseUrl="192.168.1.137:8080";
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

    final url = Uri.http(_baseUrl, '/api/login', {});

    final resp = await http.post(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Some token"
        },
        body: json.encode(authData));

    var a = UsuarioModel.fromJson(resp.body);

    if (a.id!=null) {
      await storage.write(key: 'token', value: a.token);
      await storage.write(key: 'id', value: a.id.toString());
      
      print(a);
      return a;
    } else {
      return null;
    }
  }
  
  Future<String> readToken() async {
    
    return await storage.read(key: 'token') ?? '';
    
  }
  Future<String> readId() async {
    
    return await storage.read(key: 'id') ?? '';
    
  }
  
}