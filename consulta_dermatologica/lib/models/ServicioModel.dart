

import 'models.dart';

class ServicioModel {
    int id;
    String nombre;
    double precio;
    TratamientoModel? tratamiento;

    ServicioModel({
        required this.id,
        required this.nombre,
        required this.precio,
        required this.tratamiento,
    });

    factory ServicioModel.fromJson(Map<String, dynamic> json) {
      return ServicioModel(
        id: json["id"],
        nombre: json["nombre"],
        precio: json["precio"],
        tratamiento: json["tratamiento"] != null
            ? TratamientoModel.fromJson(json["tratamiento"])
            : TratamientoModel(id: 1,cadaCuanto: "3 semanas",nombre: "Prueba",precio: 123),
      );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "precio": precio,
    };
}
