package com.example.consulta.model;

import com.example.consulta.entity.Cliente;
import com.example.consulta.entity.Historial;
import com.example.consulta.entity.Servicio;

public class CitasModel {

	private long id;
	private String fechaCita;
	private Cliente cliente;
	private Historial historial;
	private Servicio servicio;
	private boolean activa;
	
	
	public CitasModel() {
		super();
	}


	public CitasModel(long id, String fechaCita, Cliente cliente, Historial historial, Servicio servicio,
			boolean activa) {
		super();
		this.id = id;
		this.fechaCita = fechaCita;
		this.cliente = cliente;
		this.historial = historial;
		this.servicio = servicio;
		this.activa = activa;
	}


	public long getId() {
		return id;
	}


	public void setId(long id) {
		this.id = id;
	}


	public String getFechaCita() {
		return fechaCita;
	}


	public void setFechaCita(String fechaCita) {
		this.fechaCita = fechaCita;
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


	@Override
	public String toString() {
		return "CitasModel [id=" + id + ", fechaCita=" + fechaCita + ", cliente=" + cliente + ", historial=" + historial
				+ ", servicio=" + servicio + ", activa=" + activa + "]";
	}

	
	
	
}
