package com.example.consulta.serviceImpl;

import java.util.List;
import java.util.stream.Collectors;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.example.consulta.entity.Servicio;
import com.example.consulta.model.ServicioModel;
import com.example.consulta.repository.ServicioRepository;
import com.example.consulta.service.ServicioService;


@Service("servicioService")
public class ServicioServiceImpl implements ServicioService {

	@Autowired
	@Qualifier("servicioRepository")
	private ServicioRepository servicioRepository;
	
//	@Autowired
//	@Qualifier("servicioServiceImpl")
//	private ServicioService servicioService;

	
	@Override
	public Servicio addServicio(Servicio Servicio) {
		
		return servicioRepository.save(Servicio);
	}

	@Override
	public Servicio addServicio(ServicioModel ServicioModel) {
		return servicioRepository.save(transform(ServicioModel));
	}
	
	@Override
	public Servicio findServicioById(long id) {
		return servicioRepository.findById(id);
	}
	
	@Override
	public Servicio findServicioByNombre(String nombre) {
		return servicioRepository.findByNombre(nombre);
	}

	@Override
	public ServicioModel findServicioByIdModel(long id) {
		return transform(servicioRepository.findById(id));

	}

	@Override
	public ServicioModel updateServicio(ServicioModel ServicioModel) {
		servicioRepository.save(transform(ServicioModel));
		return ServicioModel;	}

	@Override
	public boolean removeServicio(long id) {
		if(servicioRepository.findById(id)!=null) {
			servicioRepository.deleteById(id);
			return true;
		}
			return false;
	}

	@Override
	public Servicio transform(ServicioModel ServicioModel) {
		ModelMapper modelMapper = new ModelMapper();
		return modelMapper.map(ServicioModel, Servicio.class);
	}

	@Override
	public ServicioModel transform(Servicio Servicio) {
		ModelMapper modelMapper = new ModelMapper();
		return modelMapper.map(Servicio, ServicioModel.class);
	}

	@Override
	public List<ServicioModel> listAllServicios() {
		return servicioRepository.findAll().stream().map(c -> transform(c)).collect(Collectors.toList());

	}


}
