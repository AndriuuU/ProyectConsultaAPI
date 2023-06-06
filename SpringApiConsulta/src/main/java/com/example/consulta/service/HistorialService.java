package com.example.consulta.service;

import java.util.List;

import com.example.consulta.entity.Historial;
import com.example.consulta.model.HistorialModel;



public interface HistorialService {
	
	public abstract HistorialModel addHistorial(HistorialModel HistorialModel);
	public abstract Historial findHistorialById(long id);
	public abstract HistorialModel findHistorialByIdModel(long id);
	public abstract HistorialModel updateHistorial(HistorialModel HistorialModel);
	public abstract boolean removeHistorial(long id);
	public abstract Historial transform(HistorialModel HistorialModel);
	public abstract HistorialModel transform(Historial Historial);
	public abstract List<HistorialModel> listAllHistorials();
 
}
