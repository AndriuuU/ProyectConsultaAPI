package com.example.consulta.service;

import java.util.List;

import com.example.consulta.entity.Cliente;
import com.example.consulta.model.ClienteModel;

public interface ClienteService {

	public abstract List<ClienteModel> listAllClientes();
	
	public abstract Cliente findByEmail(String email);
	
	public abstract Cliente addCliente(ClienteModel ClientesModel);

	public abstract boolean removeCliente(long id) throws Exception;
	
	public abstract Cliente updateCliente(ClienteModel ClientesModel);
	
	public abstract Cliente transform(ClienteModel ClientesModel);
	
	public abstract ClienteModel transform(Cliente Clientes);
	
	public abstract Cliente findCliente(long id);

	

}
