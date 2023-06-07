
import 'dart:convert';

class UsuarioModel {
    int id;
    String username;
    String password;
    bool enable;
    String role;
    dynamic token;

    UsuarioModel({
        required this.id,
        required this.username,
        required this.password,
        required this.enable,
        required this.role,
        this.token,
    });

    factory UsuarioModel.fromJson(String str) => UsuarioModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UsuarioModel.fromMap(Map<String, dynamic> json) => UsuarioModel(
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
