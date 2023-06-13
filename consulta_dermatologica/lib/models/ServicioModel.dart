

import 'models.dart';

class ServicioModel {
    int id;
    String nombre;
    double precio;
    TratamientoModel tratamiento;

    ServicioModel({
        required this.id,
        required this.nombre,
        required this.precio,
        required this.tratamiento,
    });

    factory ServicioModel.fromJson(Map<String, dynamic> json) => ServicioModel(
        id: json["id"],
        nombre: json["nombre"],
        precio: json["precio"],
        tratamiento: TratamientoModel.fromJson(json["tratamiento"]),
       
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "precio": precio,
        "tratamiento": tratamiento.toJson(),
    };
}
