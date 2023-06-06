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
	
	@OneToMany(cascade= CascadeType.ALL, mappedBy="servicio")
	private List<Citas> citas;


	@OneToMany(cascade= CascadeType.ALL,mappedBy="servicio")
    private List<Tratamiento> tratamientos;

	public Servicio() {
		super();
	}

	public Servicio(long id, String nombre, float precio, List<Citas> citas, List<Tratamiento> tratamientos) {
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