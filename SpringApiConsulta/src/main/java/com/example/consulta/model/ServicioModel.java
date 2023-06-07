package com.example.consulta.model;

import java.util.List;

import com.example.consulta.entity.Citas;
import com.example.consulta.entity.Tratamiento;


public class ServicioModel {

	private long id;
	private String nombre;
	private float precio;
//	private List<Citas> citas;
//	private List<Tratamiento> tratamientos;
	private Tratamiento tratamiento;

	public ServicioModel() {
		super();
	}


	


//	public ServicioModel(long id, String nombre, float precio, List<Citas> citas, List<Tratamiento> tratamientos) {
//		super();
//		this.id = id;
//		this.nombre = nombre;
//		this.precio = precio;
//		this.citas = citas;
//		this.tratamientos = tratamientos;
//	}

	public ServicioModel(long id, String nombre, float precio, Tratamiento tratamiento) {
		super();
		this.id = id;
		this.nombre = nombre;
		this.precio = precio;
		this.tratamiento = tratamiento;
	}





	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public float getPrecio() {
		return precio;
	}

	public void setPrecio(float precio) {
		this.precio = precio;
	}

	public Tratamiento getTratamiento() {
		return tratamiento;
	}


	public void setTratamiento(Tratamiento tratamiento) {
		this.tratamiento = tratamiento;
	}

	@Override
	public String toString() {
		return "ServicioModel [id=" + id + ", nombre=" + nombre + ", precio=" + precio + ", tratamiento=" + tratamiento
				+ "]";
	}

	
}
