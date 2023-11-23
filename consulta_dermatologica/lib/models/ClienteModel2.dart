import 'dart:convert';

class ClienteModel2 {
    int id;
    String nombre;
    String email;
    bool seguro;
    String direccion;
    String telefono;
    String password;
    Usuario usuario;

    ClienteModel2({
        required this.id,
        required this.nombre,
        required this.email,
        required this.seguro,
        required this.direccion,
        required this.telefono,
        required this.password,
        required this.usuario,
    });

    factory ClienteModel2.fromJson(String str) => ClienteModel2.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ClienteModel2.fromMap(Map<String, dynamic> json) => ClienteModel2(
        id: json["id"],
        nombre: json["nombre"],
        email: json["email"],
        seguro: json["seguro"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        password: json["password"],
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
        "usuario": usuario.toMap(),
    };
}

class Usuario {
    int id;
    String username;
    String password;
    bool enable;
    String role;
    dynamic token;

    Usuario({
        required this.id,
        required this.username,
        required this.password,
        required this.enable,
        required this.role,
        required this.token,
    });

    factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        enable: json["enable"],
        role: json["role"],
        token: json["token"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "password": password,
        "enable": enable,
        "role": role,
        "token": token,
    };
}
