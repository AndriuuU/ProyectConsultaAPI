package com.example.consulta.model;

import java.util.List;

import com.example.consulta.entity.Citas;
import com.example.consulta.entity.Cliente;


public class HistorialModel {

	private long id;
	private boolean asistio;
	private Cliente cliente;
	private List<Citas> Citas;

	
	public HistorialModel(long id, boolean asistio, Cliente cliente, List<com.example.consulta.entity.Citas> citas) {
		super();
		this.id = id;
		this.asistio = asistio;
		this.cliente = cliente;
		Citas = citas;
	}
	
	public boolean isAsistio() {
		return asistio;
	}

	public void setAsistio(boolean asistio) {
		this.asistio = asistio;
	}

	public Cliente getCliente() {
		return cliente;
	}

	public void setCliente(Cliente cliente) {
		this.cliente = cliente;
	}

	public HistorialModel() {
		super();
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	
	public List<Citas> getCitas() {
		return Citas;
	}
	public void setCitas(List<Citas> citas) {
		Citas = citas;
	}
	@Override
	public String toString() {
		return "Historial [id=" + id + ", cliente=" + cliente + "]";
	}
	
	
}
