package com.example.consulta.service;

import java.util.List;

import com.example.consulta.entity.Servicio;
import com.example.consulta.model.ServicioModel;

public interface ServicioService {

	public abstract Servicio addServicio(ServicioModel ServicioModel);
	public abstract Servicio findServicioById(long id);
	public abstract ServicioModel findServicioByIdModel(long id);
	public abstract ServicioModel updateServicio(ServicioModel ServicioModel);
	public abstract boolean removeServicio(long id);
	public abstract Servicio transform(ServicioModel ServicioModel);
	public abstract ServicioModel transform(Servicio Servicio);
	public abstract List<ServicioModel> listAllServicios();
	public abstract Servicio findServicioByNombre(String nombre);
	Servicio addServicio(Servicio Servicio);
}
