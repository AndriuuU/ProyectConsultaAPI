import 'dart:convert';

TratamientoModel tratamientoModelFromJson(String str) => TratamientoModel.fromJson(json.decode(str));

String tratamientoModelToJson(TratamientoModel data) => json.encode(data.toJson());

class TratamientoModel {
    int id;
    String nombre;
    double precio;
    String cadaCuanto;

    TratamientoModel({
        required this.id,
        required this.nombre,
        required this.precio,
        required this.cadaCuanto,
    });

    factory TratamientoModel.fromJson(Map<String, dynamic> json) => TratamientoModel(
        id: json["id"],
        nombre: json["nombre"],
        precio: json["precio"],
        cadaCuanto: json["cadaCuanto"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "precio": precio,
        "cadaCuanto": cadaCuanto,
    };
}
