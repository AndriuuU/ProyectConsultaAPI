package com.example.consulta.serviceImpl;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.example.consulta.entity.Cliente;
import com.example.consulta.entity.Historial;
import com.example.consulta.entity.User;
import com.example.consulta.model.ClienteModel;
import com.example.consulta.model.HistorialModel;
import com.example.consulta.repository.ClienteRepository;
import com.example.consulta.repository.UserRepository;
import com.example.consulta.service.ClienteService;
import com.example.consulta.service.HistorialService;

@Service("clienteService")
public class ClienteServiceImpl implements ClienteService {

	@Autowired
	@Qualifier("clienteRepository")
	private ClienteRepository clienteRepository;

	@Autowired
	@Qualifier("userService")
	private UserService userService;

	@Autowired
	@Qualifier("historialService")
	private HistorialService historialService;
	
	@Autowired
	@Qualifier("userRepository")
	private UserRepository userRepository;

	@Override
	public List<ClienteModel> listAllClientes() {
		return clienteRepository.findAll().stream().map(c -> transform(c)).collect(Collectors.toList());
	}

	@Override
	public Cliente findByEmail(String email) {
		return clienteRepository.findByEmail(email);
	}

	@Override
	public Cliente addCliente(ClienteModel cliente) {
		User a = userService.registrar(
				new User(cliente.getId(), cliente.getEmail(), cliente.getPassword(), true, "ROLE_USER", null));
		cliente.setNombre(cliente.getNombre());
		cliente.setEmail(cliente.getEmail());
		cliente.setSeguro(cliente.isSeguro());
		cliente.setDireccion(cliente.getDireccion());
		cliente.setTelefono(cliente.getTelefono());
		cliente.setPassword(userService.passwordEncoder().encode(cliente.getPassword()));
		cliente.setUsuario(a);

		return clienteRepository.save(transform(cliente));

	}

	@Override
	public boolean removeCliente(long id) throws Exception  {
		Cliente c = clienteRepository.findById(id);
		
			if (c != null) {
				clienteRepository.deleteById(id);
				
				if (c.getUsuario() != null) {

					userService.deleteUser(c.getUsuario().getUsername());

				}
				return true;
			}

		return false;
	}

	@Override
	public Cliente updateCliente(ClienteModel cliente) {
		cliente.setNombre(cliente.getNombre());
		cliente.setEmail(cliente.getEmail());
		cliente.setSeguro(cliente.isSeguro());
		cliente.setDireccion(cliente.getDireccion());
		cliente.setTelefono(cliente.getTelefono());
		cliente.setPassword(userService.passwordEncoder().encode(cliente.getPassword()));
		cliente.setUsuario(cliente.getUsuario());
		cliente.setHistorial(null);
		return clienteRepository.save(transform(cliente));
	}

	@Override
	public Cliente transform(ClienteModel clientesModel) {
		ModelMapper modelMapper = new ModelMapper();
		return modelMapper.map(clientesModel, Cliente.class);
	}

	@Override
	public ClienteModel transform(Cliente clientes) {
		ModelMapper modelMapper = new ModelMapper();
		return modelMapper.map(clientes, ClienteModel.class);
	}

	@Override
	public Cliente findCliente(long id) {
		return clienteRepository.findById(id);

	}

	@Override
	public Cliente insertHistorialCliente(ClienteModel cliente) {
		cliente.setHistorial(HistorialCliente(cliente));
		return clienteRepository.save(transform(cliente));
	}
	
	public List<Historial> HistorialCliente(ClienteModel cliente) {
		List<HistorialModel> listHistorialModel=historialService.listAllHistorials();
		List<Historial> listHisto=new ArrayList<>();
		for(HistorialModel hm:listHistorialModel) {
			if(hm.getCliente().getId()==cliente.getId()) {
				listHisto.add(historialService.transform(hm));
			}
		}
		return listHisto;
	}
	

}
