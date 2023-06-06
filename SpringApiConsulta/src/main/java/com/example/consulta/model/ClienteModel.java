package com.example.consulta.model;

import java.util.List;

import com.example.consulta.entity.Citas;
import com.example.consulta.entity.Historial;
import com.example.consulta.entity.User;

public class ClienteModel {

	private long id;
	private String nombre;
	private String email;
	private boolean seguro;
	private String direccion;
	private String telefono;
	private String password;
	private List<Citas> citas;
	private List<Historial> historial;
	private User usuario;
	
	public ClienteModel() {
		super();
	}

	public ClienteModel(long id, String nombre, String email, boolean seguro, String direccion, String telefono,
			String password, List<Historial> historial, User usuario) {
		super();
		this.id = id;
		this.nombre = nombre;
		this.email = email;
		this.seguro = seguro;
		this.direccion = direccion;
		this.telefono = telefono;
		this.password = password;
		this.historial = historial;
		this.usuario = usuario;
	}


	public ClienteModel(long id, String nombre, String email, boolean seguro, String direccion, String telefono,
			String password, List<Citas> citas, List<Historial> historial, User usuario) {
		super();
		this.id = id;
		this.nombre = nombre;
		this.email = email;
		this.seguro = seguro;
		this.direccion = direccion;
		this.telefono = telefono;
		this.password = password;
		this.citas = citas;
		this.historial = historial;
		this.usuario = usuario;
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


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public boolean isSeguro() {
		return seguro;
	}


	public void setSeguro(boolean seguro) {
		this.seguro = seguro;
	}


	public String getDireccion() {
		return direccion;
	}


	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}


	public String getTelefono() {
		return telefono;
	}


	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public List<Historial> getHistorial() {
		return historial;
	}


	public void setHistorial(List<Historial> historial) {
		this.historial = historial;
	}

	

	public User getUsuario() {
		return usuario;
	}



	public void setUsuario(User usuario) {
		this.usuario = usuario;
	}

	


	public List<Citas> getCitas() {
		return citas;
	}



	public void setCitas(List<Citas> citas) {
		this.citas = citas;
	}




	@Override
	public String toString() {
		return "ClienteModel [id=" + id + ", nombre=" + nombre + ", email=" + email + ", seguro=" + seguro
				+ ", direccion=" + direccion + ", telefono=" + telefono + ", password=" + password + ", historial=" + historial + "]";
	}



}
