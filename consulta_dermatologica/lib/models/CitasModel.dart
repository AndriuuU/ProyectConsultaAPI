
import 'dart:convert';

import 'models.dart';

class CitasModel {
    int id;
    String fechaCita;
    ClienteModel cliente;
    ServicioModel? servicio;
    bool activa;

    CitasModel({
        required this.id,
        required this.fechaCita,
        required this.cliente,
        this.servicio,
        required this.activa,
    });
    List<CitasModel> citasList = [];
    factory CitasModel.fromRawJson(String str) => CitasModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CitasModel.fromJson(Map<String, dynamic> json) => CitasModel(
        id: json["id"],
        fechaCita: json["fechaCita"],
        cliente: ClienteModel.fromJson(json["cliente"]),
        servicio: json["servicio"] == null ? null : ServicioModel.fromJson(json["servicio"]),
        activa: json["activa"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fechaCita": fechaCita,
        "cliente": cliente.toJson(),
        "servicio": servicio?.toJson(),
        "activa": activa,
    };
}
