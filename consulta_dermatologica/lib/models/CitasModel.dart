
import 'models.dart';

class CitasModel {
    int id;
    String fechaCita;
    ClienteModel cliente;
    ServicioModel servicio;
    bool activa;

    CitasModel({
        required this.id,
        required this.fechaCita,
        required this.cliente,
        required this.servicio,
        required this.activa,
    });

    factory CitasModel.fromJson(Map<String, dynamic> json) => CitasModel(
        id: json["id"],
        fechaCita: json["fechaCita"],
        cliente: ClienteModel.fromJson(json["cliente"]),
        servicio: ServicioModel.fromJson(json["servicio"]),
        activa: json["activa"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fechaCita": fechaCita,
        "cliente": cliente.toJson(),
        "servicio": servicio.toJson(),
        "activa": activa,
    };
}
