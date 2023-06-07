package com.example.consulta.entity;

import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;

@Entity
public class Servicio {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private long id;
	
	@Column(name = "nombre", unique = true, nullable = false)
	private String nombre;
	@Column(name = "precio", nullable = false)
	private float precio;
	
//	@JoinTable(
//	        name = "Citas",
//	        joinColumns = @JoinColumn(name = "ID_Servicio", nullable = false),
//	        inverseJoinColumns = @JoinColumn(name="ID_Citas", nullable = false)
//	 )
//	  
//	@ManyToMany(cascade= CascadeType.ALL)
//	private List<Citas> citas;
//	
//	@JoinTable(
//	        name = "tratamientos",
//	        joinColumns = @JoinColumn(name = "ID_Servicio", nullable = false),
//	        inverseJoinColumns = @JoinColumn(name="ID_tratamientos", nullable = false)
//	 )
//	@ManyToMany(cascade= CascadeType.ALL)
//	private List<Tratamiento> tratamientos;
	
//	@OneToMany(cascade= CascadeType.ALL, mappedBy="servicio")
//	private List<Citas> citas;


//	@OneToMany(cascade= CascadeType.ALL,mappedBy="servicio")
//    private List<Tratamiento> tratamientos;

	@ManyToOne
	@JoinColumn(name="tratamiento")
	private Tratamiento tratamiento;
	
	public Servicio() {
		super();
	}

	
	
	public Servicio(long id, String nombre, float precio, Tratamiento tratamiento) {
		super();
		this.id = id;
		this.nombre = nombre;
		this.precio = precio;
		this.tratamiento = tratamiento;
	}



	public Tratamiento getTratamiento() {
		return tratamiento;
	}



	public void setTratamiento(Tratamiento tratamiento) {
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


	@Override
	public String toString() {
		return "Servicio [id=" + id + ", nombre=" + nombre + ", precio=" + precio + ", tratamiento=" + tratamiento
				+ "]";
	}

}