
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:consulta_dermatologica/models/models.dart';

import 'auth_service.dart';

class CitasService extends ChangeNotifier {
  final String _baseUrl = "192.168.1.142:8080";
  final storage = FlutterSecureStorage();
  List<CitasModel> listaCitas = [];
  bool isLoading = false;
  bool hasError = false;
  String errorMessage = '';

  CitasService() {
    this.getListCitas();
  }

  Future<void> getListCitas() async {
    isLoading = true;
    hasError = false;
    errorMessage = '';

    notifyListeners();

    try {
      String token = await AuthService().readToken();
      final url = Uri.http(_baseUrl, '/api/get/citas', {});
      print(url);

      final resp = await http.get(url,
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "Authorization": token
          });

      print(resp.body);

      if (resp.statusCode == 200) {
        final responseBody = json.decode(resp.body);

        listaCitas.clear();

        for (var citaMap in responseBody) {
          listaCitas.add(CitasModel.fromJson(citaMap));
        }

        print(listaCitas);
      } else {
        print('Error en la solicitud: ${resp.statusCode}');
        hasError = true;
        errorMessage = 'Error en la solicitud: ${resp.statusCode}';
      }
    } catch (e) {
      print('Error: $e');
      hasError = true;
      errorMessage = 'Error: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  Future<void> eliminarCita(int citaId) async {
    isLoading = true;
    hasError = false;
    errorMessage = '';
    try {
      String token = await AuthService().readToken();
      final url = Uri.http(_baseUrl, '/api/delete/citas/$citaId', {});
      final response = await http.delete(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": token,
        },
      );

      if (response.statusCode == 200) {
        notifyListeners();
        await getListCitas();
      } else {
        hasError = true;
        errorMessage = 'Error al eliminar la cita: ${response.statusCode}';
        print('Error al eliminar la cita: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      
      hasError = true;
      errorMessage = 'Error: $e';
    } finally {
      isLoading = false;
      
      
    }
  }
}


class CitasServiceAdmin extends ChangeNotifier{
  final String _baseUrl="192.168.1.142:8080";

  CitasServiceAdmin() {
    this.getListCitasAdmin();
  }

  List<CitasModel> listaCitasAdmin=[];

  getListCitasAdmin() async {

    final url=Uri.http(_baseUrl,'/api/all/citas',{});
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

  notifyListeners();
    for (var citaMap in responseBody) {
      listaCitasAdmin.add(CitasModel.fromJson(citaMap));
    }

    // Aquí tienes la lista final de citas
    print(listaCitasAdmin);
  } else {
    print('Error en la solicitud: ${resp.statusCode}');
  }

  }
  
    
}


//Coger citas
class CogerCitasService extends ChangeNotifier{
  final String _baseUrl="192.168.1.142:8080";
  final storage = FlutterSecureStorage();
  //final String _firebaseToken='';
  CogerCitasService() {
  

  Future<String?> cogerCita(String fechaCita,String fechaCompleta,int servicio) async {
    
    final Map<String, dynamic> citaData = {
      'fechaCita': fechaCita,
      'fechaCompleta': fechaCompleta,
       "servicio": {
        "id":servicio
        }
    };
    String token= await AuthService().readToken();
    final url=Uri.http(_baseUrl,'/api/register/citas',{});
    print(url);

    final resp = await http.post(url, 
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": token
        },body: json.encode(citaData));

    print(resp.body);

    final Map<String, dynamic> decodeResp = json.decode(resp.body);
    
    print(decodeResp);
    if(decodeResp!=null){
        notifyListeners();
      return decodeResp['message'];
    }else{
      
      return null;
    }
  notifyListeners();
  }
  }
}
