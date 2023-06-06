package com.example.consulta.repository;

import java.io.Serializable;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.consulta.entity.Cliente;
import com.example.consulta.model.ClienteModel;

@Repository("clienteRepository")
public interface ClienteRepository extends JpaRepository<Cliente, Serializable> {

	public abstract Cliente findByEmail(String email);
	public abstract Cliente findById(long id);
}
