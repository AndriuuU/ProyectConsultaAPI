
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:consulta_dermatologica/models/models.dart';
import 'package:intl/intl.dart';

import 'auth_service.dart';

class CitasService extends ChangeNotifier {
  final String _baseUrl = "dermatoloapi.azurewebsites.net";
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
      final url = Uri.https(_baseUrl, '/api/get/citas', {});
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
      final url = Uri.https(_baseUrl, '/api/delete/citas/$citaId', {});
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
  final String _baseUrl="dermatoloapi.azurewebsites.net";

  CitasServiceAdmin() {
    this.getListCitasAdmin();
  }

  List<CitasModel> listaCitasAdmin=[];

  getListCitasAdmin() async {

    final url=Uri.https(_baseUrl,'/api/all/citas',{});
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
  final String _baseUrl="dermatoloapi.azurewebsites.net";
  final storage = FlutterSecureStorage();
  //final String _firebaseToken='';

  

  Future<String?> cogerCita(DateTime? selectedDay, String? selectedHora, int? servicioId,String? nombreServicio) async {
    if (selectedDay == null || selectedHora == null || servicioId == null) {
      // Manejar el caso en el que los parámetros son nulos
      return null;
    }

    // Formatear la fecha
    String fechaFormateada = DateFormat('yyyy-MM-ddT').format(selectedDay);

    // Formatear la hora
    DateTime hora = DateFormat('hh:mm a').parse(selectedHora);
    String horaFormateada = DateFormat('HH:mm:ss.SSS').format(hora);

    // Combinar la fecha y la hora
    String fechacom = '$fechaFormateada$horaFormateada'+"Z";
DateTime fecha = DateTime.parse(fechacom);
// Formatear la fecha y la hora según tus especificaciones
  String horaFormateadanew = DateFormat('hh:mm a').format(fecha);
  String diaSemana = DateFormat('EEEE', 'es').format(fecha);
  String dia = DateFormat('d').format(fecha);
  String mes = DateFormat('MMMM', 'es').format(fecha);
  String anio = DateFormat('yyyy').format(fecha);

  // Combinar la información formateada
  String resultado = '$horaFormateadanew&$diaSemana&$dia&$mes&$anio&'+nombreServicio.toString();

  print(resultado);
    print(resultado);
try {
    final Map<String, dynamic> citaData = {
      'fechaCita': resultado,
      'fechaCompleta': fechacom,
      "servicio": {
        "id": servicioId,
      }
    };

    String token = await AuthService().readToken();
    final url = Uri.https(_baseUrl, '/api/register/citas', {});
    print(url);

    final resp = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": token,
      },
      body: json.encode(citaData),
    );

    print(resp.body);

    final Map<String, dynamic> decodeResp = json.decode(resp.body);

    print(decodeResp['id']);
    if (decodeResp['id']==null) {
      print("REPETIDO");
      return "REPETIDO";

    }else if (decodeResp['id']!=0) {
      print("CITA OBTENIDA");
      notifyListeners();
      return diaSemana+" "+dia+" "+mes;
    } else {
      return "ERROR";
    }
     } catch (e) {
      print('Error al decodificar la respuesta del servidor: $e');
      return null;
    }
  }
  

  
}
