package com.example.consulta.entity;

import jakarta.annotation.Nullable;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class Citas {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private long id;
	
	@Column(name = "CitaFecha", unique = true)
	private String fechaCita;
	
	private boolean activa;

	@ManyToOne
    @JoinColumn(name = "cliente")
    private Cliente cliente;	
	
//	@ManyToOne
//	@JoinColumn(name="citas")
//	private Historial historial;
	
	@ManyToOne
	@JoinColumn(name="servicio")
	private Servicio servicio;


	
	public Citas(long id, String fechaCita, boolean activa, Cliente cliente, Servicio servicio) {
		super();
		this.id = id;
		this.fechaCita = fechaCita;
		this.activa = activa;
		this.cliente = cliente;
		this.servicio = servicio;
	}

	public Citas() {
		super();
	}

	public Cliente getCliente() {
		return cliente;
	}

	public void setCliente(Cliente cliente) {
		this.cliente = cliente;
	}



	public long getId() {
		return id;
	}


	public void setId(long id) {
		this.id = id;
	}

	public Servicio getServicio() {
		return servicio;
	}


	public void setServicio(Servicio servicio) {
		this.servicio = servicio;
	}


	public boolean isActiva() {
		return activa;
	}


	public void setActiva(boolean activa) {
		this.activa = activa;
	}

	public String getFechaCita() {
		return fechaCita;
	}

	public void setFechaCita(String fechaCita) {
		this.fechaCita = fechaCita;
	}

	@Override
	public String toString() {
		return "Citas [id=" + id + ", fechaCita=" + fechaCita + ", activa=" + activa + ", cliente=" + cliente
				+ ", servicio=" + servicio + "]";
	}


	
}
