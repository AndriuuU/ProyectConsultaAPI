// To parse this JSON data, do
//
//     final clienteModel = clienteModelFromMap(jsonString);

import 'dart:convert';

import 'models.dart';

class ClienteModel {
    int id;
    String nombre;
    String email;
    bool seguro;
    String direccion;
    String telefono;
    String password;
    List<Cita> citas;
    dynamic historial;
    Usuario usuario;

    ClienteModel({
        required this.id,
        required this.nombre,
        required this.email,
        required this.seguro,
        required this.direccion,
        required this.telefono,
        required this.password,
        required this.citas,
        this.historial,
        required this.usuario,
    });

    factory ClienteModel.fromJson(String str) => ClienteModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ClienteModel.fromMap(Map<String, dynamic> json) => ClienteModel(
        id: json["id"],
        nombre: json["nombre"],
        email: json["email"],
        seguro: json["seguro"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        password: json["password"],
        citas: List<Cita>.from(json["citas"].map((x) => Cita.fromMap(x))),
        historial: json["historial"],
        usuario: Usuario.fromMap(json["usuario"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "email": email,
        "seguro": seguro,
        "direccion": direccion,
        "telefono": telefono,
        "password": password,
        "citas": List<dynamic>.from(citas.map((x) => x.toMap())),
        "historial": historial,
        "usuario": usuario.toMap(),
    };
}