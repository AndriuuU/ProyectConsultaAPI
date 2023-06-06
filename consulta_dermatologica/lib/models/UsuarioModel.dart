
import 'dart:convert';

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
        this.token,
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
