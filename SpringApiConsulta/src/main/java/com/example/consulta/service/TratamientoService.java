package com.example.consulta.service;

import java.util.List;

import com.example.consulta.entity.Tratamiento;
import com.example.consulta.model.TratamientoModel;

public interface TratamientoService {

	public abstract TratamientoModel addTratamiento(TratamientoModel TratamientoModel);
	public abstract Tratamiento findTratamientoById(long id);
	public abstract TratamientoModel findTratamientoByIdModel(long id);
	public abstract TratamientoModel updateTratamiento(TratamientoModel TratamientoModel);
	public abstract boolean removeTratamiento(long id);
	public abstract Tratamiento transform(TratamientoModel TratamientoModel);
	public abstract TratamientoModel transform(Tratamiento Tratamiento);
	public abstract List<TratamientoModel> listAllTratamientos();
}
