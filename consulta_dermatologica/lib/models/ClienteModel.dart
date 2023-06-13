
import 'models.dart';

class ClienteModel {
    int id;
    String nombre;
    String email;
    bool seguro;
    String direccion;
    String telefono;
    String password;
    UsuarioModel usuario;

    ClienteModel({
        required this.id,
        required this.nombre,
        required this.email,
        required this.seguro,
        required this.direccion,
        required this.telefono,
        required this.password,
        required this.usuario,
    });

    factory ClienteModel.fromJson(Map<String, dynamic> json) => ClienteModel(
        id: json["id"],
        nombre: json["nombre"],
        email: json["email"],
        seguro: json["seguro"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        password: json["password"],
        usuario: UsuarioModel.fromMap(json["usuario"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "email": email,
        "seguro": seguro,
        "direccion": direccion,
        "telefono": telefono,
        "password": password,
        "usuario": usuario.toJson(),
    };
}
