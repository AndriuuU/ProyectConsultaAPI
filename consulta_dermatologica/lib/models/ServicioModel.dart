

import 'models.dart';

class ServicioModel {
    int id;
    String nombre;
    int precio;
    TratamientoModel tratamiento;
    String cadaCuanto;

    ServicioModel({
        required this.id,
        required this.nombre,
        required this.precio,
        required this.tratamiento,
        required this.cadaCuanto,
    });

    factory ServicioModel.fromJson(Map<String, dynamic> json) => ServicioModel(
        id: json["id"],
        nombre: json["nombre"],
        precio: json["precio"],
        tratamiento: TratamientoModel.fromJson(json["tratamiento"]),
        cadaCuanto: json["cadaCuanto"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "precio": precio,
        "tratamiento": tratamiento.toJson(),
        "cadaCuanto": cadaCuanto,
    };
}
