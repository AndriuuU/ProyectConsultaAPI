package com.example.consulta.repository;

import java.io.Serializable;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.consulta.entity.Historial;

@Repository("historialRepository")
public interface HistorialRepository extends JpaRepository<Historial,Serializable> {
	
	public abstract Historial findById(long id);

}
