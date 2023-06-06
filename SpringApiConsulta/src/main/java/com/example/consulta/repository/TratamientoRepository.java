package com.example.consulta.repository;

import java.io.Serializable;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.consulta.entity.Tratamiento;

@Repository("tratamientoRepository")
public interface TratamientoRepository extends JpaRepository<Tratamiento,Serializable> {
	
	public abstract Tratamiento findById(long id);

}
