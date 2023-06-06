package com.example.consulta.serviceImpl;

import java.util.List;
import java.util.stream.Collectors;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.example.consulta.entity.Tratamiento;
import com.example.consulta.model.TratamientoModel;
import com.example.consulta.repository.TratamientoRepository;
import com.example.consulta.service.TratamientoService;


@Service("tratamientoService")
public class TratamientoServiceImpl implements TratamientoService {

	
	@Autowired
	@Qualifier("tratamientoRepository")
	private TratamientoRepository tratamientoRepository;
	
//	@Autowired
//	@Qualifier("tratamientoServiceImpl")
//	private TratamientoService tratamientoService;

	
	@Override
	public TratamientoModel addTratamiento(TratamientoModel tratamientoModel) {
		tratamientoRepository.save(transform(tratamientoModel));
		return tratamientoModel;
	}


	@Override
	public Tratamiento findTratamientoById(long id) {
		return tratamientoRepository.findById(id);
	}

	@Override
	public TratamientoModel findTratamientoByIdModel(long id) {
		return transform(tratamientoRepository.findById(id));

	}

	@Override
	public TratamientoModel updateTratamiento(TratamientoModel TratamientoModel) {
		tratamientoRepository.save(transform(TratamientoModel));
		return TratamientoModel;	}

	@Override
	public boolean removeTratamiento(long id) {
		if(tratamientoRepository.findById(id)!=null) {
			tratamientoRepository.deleteById(id);
			return true;
		}
			return false;
	}

	@Override
	public Tratamiento transform(TratamientoModel TratamientoModel) {
		ModelMapper modelMapper = new ModelMapper();
		return modelMapper.map(TratamientoModel, Tratamiento.class);
	}

	@Override
	public TratamientoModel transform(Tratamiento Tratamiento) {
		ModelMapper modelMapper = new ModelMapper();
		return modelMapper.map(Tratamiento, TratamientoModel.class);
	}

	@Override
	public List<TratamientoModel> listAllTratamientos() {
		return tratamientoRepository.findAll().stream().map(c -> transform(c)).collect(Collectors.toList());

	}

}
