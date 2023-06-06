import 'dart:convert';

class Cita {
    int id;
    String fechaCita;
    dynamic cliente;
    dynamic historial;
    dynamic servicio;
    bool activa;

    Cita({
        required this.id,
        required this.fechaCita,
        this.cliente,
        this.historial,
        this.servicio,
        required this.activa,
    });

    factory Cita.fromJson(String str) => Cita.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Cita.fromMap(Map<String, dynamic> json) => Cita(
        id: json["id"],
        fechaCita: json["fechaCita"],
        cliente: json["cliente"],
        historial: json["historial"],
        servicio: json["servicio"],
        activa: json["activa"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "fechaCita": fechaCita,
        "cliente": cliente,
        "historial": historial,
        "servicio": servicio,
        "activa": activa,
    };
}