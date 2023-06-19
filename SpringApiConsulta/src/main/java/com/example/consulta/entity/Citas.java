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
	@Column(name = "FechaCompleta", unique = true)
	private String FechaCompleta;
	
	private boolean activa;
	
	@ManyToOne
	@JoinColumn(name="Cliente")
	private Cliente cliente;
	
	@ManyToOne
	@JoinColumn(name="citas")
	private Historial historial;
	
	@ManyToOne
	@JoinColumn(name="servicio")
	private Servicio servicio;


	public Citas(@Nullable long id, @Nullable String fechaCita, @Nullable Cliente cliente, @Nullable Historial historial, @Nullable Servicio servicio, boolean activa) {
	    super();
	    this.id = id;
	    this.fechaCita = fechaCita;
	    this.cliente = cliente;
	    this.historial = historial;
	    this.servicio = servicio;
	    this.activa = activa;
	}
	
	public Citas(long id, String fechaCita, String fechaCompleta, boolean activa, Cliente cliente, Historial historial,
			Servicio servicio) {
		super();
		this.id = id;
		this.fechaCita = fechaCita;
		FechaCompleta = fechaCompleta;
		this.activa = activa;
		this.cliente = cliente;
		this.historial = historial;
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

	public Historial getHistorial() {
		return historial;
	}

	public void setHistorial(Historial historial) {
		this.historial = historial;
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

	public String getFechaCompleta() {
		return FechaCompleta;
	}

	public void setFechaCompleta(String fechaCompleta) {
		FechaCompleta = fechaCompleta;
	}

	@Override
	public String toString() {
		return "Citas [id=" + id + ", fechaCita=" + fechaCita + ", FechaCompleta=" + FechaCompleta + ", activa="
				+ activa + ", cliente=" + cliente + ", historial=" + historial + ", servicio=" + servicio + "]";
	}



	
}
