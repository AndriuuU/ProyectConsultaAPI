package com.example.consulta.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class Tratamiento {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private long id;
	
	@Column(name = "nombre", unique = true, nullable = false)
	private String nombre;
	@Column(name = "precio", nullable = false)
	private float precio;
	
	private String cadaCuanto;

//	@ManyToOne
//	@JoinColumn(name="servicio")
//	private Servicio servicio;
	
	public Tratamiento() {
		super();
	}


	public Tratamiento(long id, String nombre, float precio, String cadaCuanto) {
	super();
	this.id = id;
	this.nombre = nombre;
	this.precio = precio;
	this.cadaCuanto = cadaCuanto;
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

	public String getCadaCuanto() {
		return cadaCuanto;
	}

	public void setCadaCuanto(String cadaCuanto) {
		this.cadaCuanto = cadaCuanto;
	}


	@Override
	public String toString() {
		return "Tratamiento [id=" + id + ", nombre=" + nombre + ", precio=" + precio + ", cadaCuanto=" + cadaCuanto
				+ "]";
	}
	
	
}
