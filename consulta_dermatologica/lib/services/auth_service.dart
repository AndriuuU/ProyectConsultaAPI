import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:consulta_dermatologica/models/models.dart';



class AuthService extends ChangeNotifier{
  final String _baseUrl="192.168.1.137:8080";
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
    if(decodeResp.containsValue('id')){
      
      return decodeResp['message'];
    }else{
      
      return decodeResp['message'];
    }

    
  }

  Future<String?> login(String email, String password) async {
    
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    final url=Uri.http(_baseUrl,'/public/api/login',{});
    
    final resp= await http.post(url,headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Some token"
        },
        body: json.encode(authData));

    final Map<String, dynamic> decodeResp = json.decode(resp.body);
    if(decodeResp.containsValue(true)){
      
      return decodeResp['data']['type'];
      
    }else{
      
      return null;
    }

  }

}