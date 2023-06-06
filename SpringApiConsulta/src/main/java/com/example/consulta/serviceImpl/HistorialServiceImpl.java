package com.example.consulta.serviceImpl;

import java.util.List;
import java.util.stream.Collectors;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.example.consulta.entity.Historial;
import com.example.consulta.model.HistorialModel;
import com.example.consulta.repository.HistorialRepository;
import com.example.consulta.service.ClienteService;
import com.example.consulta.service.HistorialService;

@Service("historialService")
public class HistorialServiceImpl implements HistorialService {

	@Autowired
	@Qualifier("historialRepository")
	private HistorialRepository historialRepository;

	
//	@Autowired
//	@Qualifier("historialServiceImpl")
//	private HistorialService historialService;

	
	@Override
	public HistorialModel addHistorial(HistorialModel historialModel) {
		historialRepository.save(transform(historialModel));
		return historialModel;
	}


	@Override
	public Historial findHistorialById(long id) {
		return historialRepository.findById(id);
	}

	@Override
	public HistorialModel findHistorialByIdModel(long id) {
		return transform(historialRepository.findById(id));

	}

	@Override
	public HistorialModel updateHistorial(HistorialModel historialModel) {
		historialRepository.save(transform(historialModel));
		return historialModel;	}

	@Override
	public boolean removeHistorial(long id) {
		if(historialRepository.findById(id)!=null) {
			historialRepository.deleteById(id);
			return true;
		}
			return false;
	}

	@Override
	public Historial transform(HistorialModel HistorialModel) {
		ModelMapper modelMapper = new ModelMapper();
		return modelMapper.map(HistorialModel, Historial.class);
	}

	@Override
	public HistorialModel transform(Historial Historial) {
		ModelMapper modelMapper = new ModelMapper();
		return modelMapper.map(Historial, HistorialModel.class);
	}

	@Override
	public List<HistorialModel> listAllHistorials() {
		return historialRepository.findAll().stream().map(c -> transform(c)).collect(Collectors.toList());

	}

}
