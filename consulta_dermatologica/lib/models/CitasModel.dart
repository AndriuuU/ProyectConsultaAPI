
import 'dart:convert';

import 'models.dart';

class CitasModel {
    int id;
    String fechaCita;
    ClienteModel cliente;
    dynamic historial;
    ServicioModel servicio;
    bool activa;
    String fechaCompleta;

    CitasModel({
        required this.id,
        required this.fechaCita,
        required this.cliente,
        this.historial,
        required this.servicio,
        required this.activa,
        required this.fechaCompleta,
    });

    factory CitasModel.fromRawJson(String str) => CitasModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CitasModel.fromJson(Map<String, dynamic> json) => CitasModel(
        id: json["id"],
        fechaCita: json["fechaCita"],
        cliente: ClienteModel.fromJson(json["cliente"]),
        historial: json["historial"],
        servicio: ServicioModel.fromJson(json["servicio"]),
        activa: json["activa"],
        fechaCompleta: json["fechaCompleta"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fechaCita": fechaCita,
        "cliente": cliente.toJson(),
        "historial": historial,
        "servicio": servicio.toJson(),
        "activa": activa,
        "fechaCompleta": fechaCompleta,
    };
}