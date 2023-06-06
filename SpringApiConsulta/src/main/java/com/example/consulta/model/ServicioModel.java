package com.example.consulta.model;

import java.util.List;

import com.example.consulta.entity.Citas;
import com.example.consulta.entity.Tratamiento;


public class ServicioModel {

	private long id;
	private String nombre;
	private float precio;
	private List<Citas> citas;
	private List<Tratamiento> tratamientos;

	public ServicioModel() {
		super();
	}

	public ServicioModel(long id, String nombre, float precio, List<Citas> citas, List<Tratamiento> tratamientos) {
		super();
		this.id = id;
		this.nombre = nombre;
		this.precio = precio;
		this.citas = citas;
		this.tratamientos = tratamientos;
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

	public List<Citas> getCitas() {
		return citas;
	}

	public void setCitas(List<Citas> citas) {
		this.citas = citas;
	}

	public List<Tratamiento> getTratamientos() {
		return tratamientos;
	}

	public void setTratamientos(List<Tratamiento> tratamientos) {
		this.tratamientos = tratamientos;
	}

	@Override
	public String toString() {
		return "Servicio [id=" + id + ", nombre=" + nombre + ", precio=" + precio + ", citas=" + citas
				+ ", tratamientos=" + tratamientos + "]";
	}

	
}
