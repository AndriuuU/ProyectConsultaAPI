package com.example.consulta.repository;

import java.io.Serializable;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.consulta.entity.Servicio;

@Repository("servicioRepository")
public interface ServicioRepository extends JpaRepository<Servicio,Serializable> {
	
	public abstract Servicio findById(long id);
	public abstract Servicio findByNombre(String nombre);
}
