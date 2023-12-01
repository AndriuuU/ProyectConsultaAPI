package com.example.consulta.controller;

import java.sql.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.consulta.entity.Citas;
import com.example.consulta.entity.Cliente;
import com.example.consulta.entity.Historial;
import com.example.consulta.entity.Servicio;
import com.example.consulta.entity.Tratamiento;
import com.example.consulta.entity.User;
import com.example.consulta.model.CitasModel;
import com.example.consulta.model.ClienteModel;
import com.example.consulta.model.HistorialModel;
import com.example.consulta.model.ServicioModel;
import com.example.consulta.model.TratamientoModel;
import com.example.consulta.service.CitasService;
import com.example.consulta.service.ClienteService;
import com.example.consulta.service.HistorialService;
import com.example.consulta.service.ServicioService;
import com.example.consulta.service.TratamientoService;
import com.example.consulta.serviceImpl.UserService;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

@RestController
@RequestMapping("/api")
public class UserController {

	@Autowired
	@Qualifier("userService")
	private UserService userService;

	@Autowired
	@Qualifier("clienteService")
	private ClienteService clienteService;

	@Autowired
	@Qualifier("servicioService")
	private ServicioService servicioService;

	@Autowired
	@Qualifier("tratamientoService")
	private TratamientoService tratamientoService;

	@Autowired
	@Qualifier("citasService")
	private CitasService citasService;

	@Autowired
	@Qualifier("historialService")
	private HistorialService historialService;

	@Autowired
	private AuthenticationManager authenticationManager;

	@PostMapping("/login")
	public com.example.consulta.entity.User login(@RequestBody com.example.consulta.entity.User user) {

		Authentication authentication = authenticationManager
				.authenticate(new UsernamePasswordAuthenticationToken(user.getUsername(), user.getPassword()));
		SecurityContextHolder.getContext().setAuthentication(authentication);
		com.example.consulta.entity.User usuario = userService.findUsuario(user.getUsername());
		String token = getJWTTokenCliente(user.getUsername());
		usuario.setUsername(user.getUsername());
		usuario.setPassword(user.getPassword());
		usuario.setToken(token);
		return usuario;
	}

	@PostMapping("/register")
	public ResponseEntity<?> saveUser(@RequestBody com.example.consulta.entity.User user) {
		boolean exist = userService.findUsuario(user.getUsername()) != null;
		if (exist) {
			return ResponseEntity.internalServerError().body("EL USUARIO YA EXISTE");
		} else {
			String token = getJWTTokenCliente(user.getUsername());
			user.setToken(token);
			return ResponseEntity.status(HttpStatus.CREATED).body(userService.registrar(user));
		}
	}

//	private String getJWTToken(String username) {
//		String secretKey = "mySecretKey";
//		List<GrantedAuthority> grantedAuthorities = AuthorityUtils
//				.commaSeparatedStringToAuthorityList(userService.findUsuario(username).getRole());
//		String token = Jwts.builder().setId("softtekJWT").setSubject(username)
//				.claim("authorities",
//						grantedAuthorities.stream().map(GrantedAuthority::getAuthority).collect(Collectors.toList()))
//				.setIssuedAt(new Date(System.currentTimeMillis()))
//				.setExpiration(new Date(System.currentTimeMillis() + 600000))
//				.signWith(SignatureAlgorithm.HS512, secretKey.getBytes()).compact();
//		return token;
//	}
//	
//	private String getJWTTokenCiente(String username) {
//		String secretKey = "mySecretKey";
//		List<GrantedAuthority> grantedAuthorities = AuthorityUtils
//				.commaSeparatedStringToAuthorityList(username);
//		String token = Jwts.builder().setId("softtekJWT").setSubject(username)
//				.claim("authorities",
//						grantedAuthorities.stream().map(GrantedAuthority::getAuthority).collect(Collectors.toList()))
//				.setIssuedAt(new Date(System.currentTimeMillis()))
//				.setExpiration(new Date(System.currentTimeMillis() + 6000000))
//				.signWith(SignatureAlgorithm.HS512, secretKey.getBytes()).compact();
//		System.out.println("Login: "+token);
//		return "Bearer " + token;
//	}
////
//	
	public String getJWTTokenCliente(String username) {
		String SECRET_KEY = "mySecretKey";
		List<GrantedAuthority> grantedAuthorities = AuthorityUtils.commaSeparatedStringToAuthorityList(username);
		String token = Jwts.builder().setId("softtekJWT").setSubject(username)
				.claim("authorities",
						grantedAuthorities.stream().map(GrantedAuthority::getAuthority).collect(Collectors.toList()))
				.setIssuedAt(new Date(System.currentTimeMillis()))
				.setExpiration(new Date(System.currentTimeMillis() + 6000000))
				.signWith(SignatureAlgorithm.HS512, SECRET_KEY.getBytes()).compact();
		return token;
	}

//
//	 
	public Claims parseToken(String token) {
		String SECRET_KEY = "mySecretKey";
		return Jwts.parser().setSigningKey(SECRET_KEY.getBytes()).parseClaimsJws(token).getBody();
	}

	// Usuario

	// Mostrar usuario
	@GetMapping("/view/user/{id}")
	public ResponseEntity<?> viewUser(@PathVariable String id) {

		return ResponseEntity.ok(userService.loadUserByUsername(id));

	}

	// Activar usuario
	@PostMapping("/activar/user/{id}")
	public ResponseEntity<?> enabelUser(@PathVariable long id) {
		int enable = userService.activar(userService.findUsuario(id).getUsername());
		com.example.consulta.entity.User user = userService.findUsuario(id);
		if (user != null)
			return ResponseEntity.ok(user);
		else
			return ResponseEntity.noContent().build();

	}
	//Update password
	@PostMapping("/update/userpass")
	public ResponseEntity<?> updateUserPassword(@RequestBody com.example.consulta.entity.User  user,@RequestHeader("Authorization") String token) {
		if (token != null) {
	        Claims claimsusername = parseToken(token);
	        String username = claimsusername.getSubject();

	        try {
	            User updatedUser = userService.updateUserPassword(user, username);
	            return ResponseEntity.status(HttpStatus.CREATED).body(updatedUser);
	        } catch (UserNotFoundException e) {
	            return ResponseEntity.internalServerError().body("El usuario no existe");
	        }
	    } else {
	        return ResponseEntity.internalServerError().body("El token no es válido");
	    }
	}
	public class UserNotFoundException extends Exception {
	    public UserNotFoundException(String message) {
	        super(message);
	    }
	}
	
	// Modificar Usuario
	// Actualiza una categoría si existe
	// Buscar Otra manera
	@PostMapping("/update/user/")
	public ResponseEntity<?> updateUser(@RequestBody com.example.consulta.entity.User user) {
		boolean exist = userService.findUsuario(user.getId()) != null;
		if (!exist) {
			return ResponseEntity.internalServerError().body(null);
		} else {
			return ResponseEntity.status(HttpStatus.CREATED).body(userService.updateUser(user));
		}
	}

	// Eliminar user
	@DeleteMapping("/delete/user/{id}")
	public ResponseEntity<?> deleteUser(@PathVariable long id) throws Exception {
		User c = userService.findUsuario(id);
		boolean deleted = userService.deleteUser(userService.findUsuario(id).getUsername());
		if (deleted)
			return ResponseEntity.ok(c);
		else
			return ResponseEntity.noContent().build();

	}

	// Cientes

	// Crea un nuevo cliente
	@PostMapping("/register/cliente")
	public ResponseEntity<?> createCliente(@RequestBody ClienteModel cliente) {
		boolean exist = clienteService.findByEmail(cliente.getEmail()) != null;
		if (exist) {
			return ResponseEntity.internalServerError().body("El usuario ya existe");
		} else
			return ResponseEntity.status(HttpStatus.CREATED).body(clienteService.addCliente(cliente));
	}

	// Obtener todos los clientes
	@GetMapping("/all/cliente")
	public ResponseEntity<?> getAllClientes() {
		boolean exist = clienteService.listAllClientes() != null;
		if (exist) {
			List<ClienteModel> clientes = clienteService.listAllClientes();
			return ResponseEntity.ok(clientes);
		} else
			return ResponseEntity.noContent().build();
	}

	// Obtener un cliente
	@GetMapping("/get/cliente/{id}")
	public ResponseEntity<?> getCliente(@PathVariable long id) {
		boolean exist = clienteService.findCliente(id) != null;
		if (exist) {
			Cliente clientes = clienteService.findCliente(id);
			return ResponseEntity.ok(clientes);
		} else
			return ResponseEntity.noContent().build();
	}
	// Obtener un cliente token
	@GetMapping("/get/cliente")
	public ResponseEntity<?> getClienteToken(@RequestHeader("Authorization") String token) {
		
		if (token != null) {
			Claims claimsusername = parseToken(token);
			String username = claimsusername.getSubject();
			Cliente cliente = clienteService.findByEmail(username);
			
			return ResponseEntity.ok(cliente);
		} else
			return ResponseEntity.noContent().build();
	}

	// Eliminar cliente
	@DeleteMapping("/delete/cliente/{id}")
	public ResponseEntity<?> deleteUserCliente(@PathVariable long id) throws Exception {
		Cliente c = clienteService.findCliente(id);
		boolean deleted = clienteService.removeCliente(id);
		if (deleted)
			return ResponseEntity.ok(c);
		else
			return ResponseEntity.noContent().build();

	}
	//update cliente
	@PostMapping("/update/cliente")
	public ResponseEntity<?> updateCliente(@RequestBody Cliente cliente,@RequestHeader("Authorization") String token) {
		if (token != null) {
			Claims claimsusername = parseToken(token);
			String username = claimsusername.getSubject();
			User user=userService.findUsuario(username);
//			Cliente clienteNew = clienteService.findByEmail(username);
//			userService.updateUser(user);
//			if(clienteNew==cliente) {
				return ResponseEntity.status(HttpStatus.CREATED).body(clienteService.updateCliente(clienteService.transform(cliente)));
//			}else
//				return ResponseEntity.internalServerError().body("No es el mismo usuario");
		} else {
			return ResponseEntity.internalServerError().body("El usuario no existe");
		
		}
	}
	// Servicios

	// Obtener todos los servicios
	@GetMapping("/all/servicios/")
	public ResponseEntity<?> getAllServicios() {
		boolean exist = servicioService.listAllServicios() != null;

		if (exist) {
			List<ServicioModel> servicio = servicioService.listAllServicios();
			return ResponseEntity.ok(servicio);
		} else
			return ResponseEntity.noContent().build();
	}

	// Obtener un servicio
	@GetMapping("/get/servicios/{id}")
	public ResponseEntity<?> getServicio(@PathVariable long id) {
		boolean exist = servicioService.findServicioById(id) != null;
		if (exist) {
			ServicioModel servicio = servicioService.findServicioByIdModel(id);
			return ResponseEntity.ok(servicio);
		} else
			return ResponseEntity.noContent().build();
	}

	// Insertar Servicio
	@PostMapping("/register/servicio")
	public ResponseEntity<?> insertServicio(@RequestBody ServicioModel servicio) {
		boolean exist = servicioService.findServicioByNombre(servicio.getNombre()) != null;
		if (exist) {
			return ResponseEntity.internalServerError().body("El servicio ya exliste");
		} else
			return ResponseEntity.status(HttpStatus.CREATED).body(servicioService.addServicio(servicio));
	}

	// Eliminar Servicio
	@DeleteMapping("/delete/servicio/{id}")
	public ResponseEntity<?> deleteServicio(@PathVariable long id) throws Exception {
		Servicio s = servicioService.findServicioById(id);
		boolean deleted = servicioService.removeServicio(id);
		if (deleted)
			return ResponseEntity.ok(s);
		else
			return ResponseEntity.noContent().build();

	}

	// Citas
	// Registrar
//	@PostMapping("/register/citas")
//	public ResponseEntity<?> insertCitas(@RequestBody CitasModel citas, @RequestHeader("Authorization") String token) {
//		boolean exist = citasService.findByFechaCitas(citas.getFechaCita())!=null;
//		System.out.println(token);
//		if (!exist && validateToken(token)) {
//			
//			String secretKey = "mySecretKey";
//			
//		    try {
//		        Claims claims = Jwts.parser().setSigningKey(secretKey).parseClaimsJws(token).getBody();
//		        System.out.println(claims);
//		        String username = claims.getSubject();
//		        System.out.println("USERNAME: "+username);
//		        Cliente cliente = clienteService.findByEmail(username);
//		        citas.setCliente(cliente);
//		        List<Citas> listCitas= cliente.getCitas();
//		        listCitas.add(citasService.transform(citas));
//		        cliente.setCitas(listCitas);
//		        clienteService.updateCliente(clienteService.transform(cliente));
//		        return ResponseEntity.status(HttpStatus.CREATED).body(citasService.addCitas(citas));
//		    }catch (Exception e) {
//				System.out.println(e.toString());
//			}
//		}
//		return ResponseEntity.internalServerError().body("ERROR");
//		
//	
//	}

	@PostMapping("/register/citas")
	public ResponseEntity<?> insertCitas(@RequestBody CitasModel citas, @RequestHeader("Authorization") String token) {
		boolean exist = citasService.findByFechaCitas(citas.getFechaCita()) != null;
		
		boolean existService = servicioService.findServicioById(citas.getServicio().getId())!=null;

		System.out.println(token);

		if (!exist && token != null && existService) {

			Claims claimsusername = parseToken(token);
			String username = claimsusername.getSubject();
			Cliente cliente = clienteService.findByEmail(username);
			Servicio servi= servicioService.findServicioById(citas.getServicio().getId());
			if (cliente != null) {
				citas.setCliente(cliente);
				citas.setServicio(servi);
//				clienteService.updateCliente(clienteService.transform(cliente));

				return ResponseEntity.status(HttpStatus.CREATED).body(citasService.addCitas(citas));
			}

		}
		return ResponseEntity.internalServerError().body("ERROR");

	}

	// Ver todos
	@GetMapping("/all/citas")
	public ResponseEntity<?> Citas() {
		List<CitasModel> exist = citasService.listAllCitass();
		if (exist != null) {
			return ResponseEntity.ok(exist);
		} else
			return ResponseEntity.noContent().build();
	}

	// Ver una cliente
	@GetMapping("/get/citas")
	public ResponseEntity<?> CitasCliente(@RequestHeader("Authorization") String token) {
		if (token != null) {
			Claims claimsusername = parseToken(token);
			String username = claimsusername.getSubject();
			Cliente cliente = clienteService.findByEmail(username);
			List<CitasModel> miCita = citasService.listCitasCliente(cliente.getId());
			if (miCita != null) 
				return ResponseEntity.ok(miCita);
			
		}
		return ResponseEntity.noContent().build();
		
	}

	// Ver una cita
	@GetMapping("/get/citas/{id}")
	public ResponseEntity<?> Citas(@PathVariable long id) {
		Citas c = citasService.findCitasById(id);

		if (c != null) {
			return ResponseEntity.ok(c);
		} else
			return ResponseEntity.noContent().build();
	}

	// Eliminar citas
	@DeleteMapping("/delete/citas/{id}")
	public ResponseEntity<?> deleteCitas(@PathVariable long id) throws Exception {
		Citas c = citasService.findCitasById(id);
		boolean deleted = citasService.removeCitas(id);
		if (deleted)
			return ResponseEntity.ok(c);
		else
			return ResponseEntity.noContent().build();

	}

	// Historial

	// Obtener todos tratamientos
	@GetMapping("/all/historiales")
	public ResponseEntity<?> allHistorial() {
		List<HistorialModel> exist = historialService.listAllHistorials();
		if (exist != null) {
			return ResponseEntity.ok(exist);
		} else
			return ResponseEntity.noContent().build();
	}

	@GetMapping("/get/historial/{id}")
	public ResponseEntity<?> getHistorial(@PathVariable long id) {
		HistorialModel exist = historialService.findHistorialByIdModel(id);
		if (exist != null) {
			return ResponseEntity.ok(exist);
		} else
			return ResponseEntity.noContent().build();
	}

	// Registrar
	@PostMapping("/register/historial")
	public ResponseEntity<?> insertHistorial(@RequestBody HistorialModel historial) {
		boolean exist = historialService.findHistorialByIdModel(historial.getId()) != null;
		if (exist) {
			return ResponseEntity.internalServerError().body("El Tratamiento ya existe");
		} else {
			return ResponseEntity.status(HttpStatus.CREATED).body(historialService.addHistorial(historial));
		}

	}

	// Eliminar tratamiento
	@DeleteMapping("/delete/historial/{id}")
	public ResponseEntity<?> deleteHistorial(@PathVariable long id) throws Exception {
		Historial t = historialService.findHistorialById(id);
		boolean deleted = historialService.removeHistorial(id);
		if (deleted)
			return ResponseEntity.ok(t);
		else
			return ResponseEntity.noContent().build();

	}

	// Tratamiento
	// Obtener todos tratamientos
	@GetMapping("/all/tratamiento")
	public ResponseEntity<?> allTratamiento() {
		List<TratamientoModel> exist = tratamientoService.listAllTratamientos();
		if (exist != null) {
			return ResponseEntity.ok(exist);
		} else
			return ResponseEntity.noContent().build();
	}

	@GetMapping("/get/tratamiento/{id}")
	public ResponseEntity<?> getTratamiento(@PathVariable long id) {
		TratamientoModel exist = tratamientoService.findTratamientoByIdModel(id);
		if (exist != null) {
			return ResponseEntity.ok(exist);
		} else
			return ResponseEntity.noContent().build();
	}

	// Registrar
	@PostMapping("/register/tratamiento")
	public ResponseEntity<?> insertTratamiento(@RequestBody TratamientoModel tratamiento) {
		boolean exist = tratamientoService.findTratamientoById(tratamiento.getId()) != null;
		if (exist) {
			return ResponseEntity.internalServerError().body("El Tratamiento ya existe");
		} else {
			return ResponseEntity.status(HttpStatus.CREATED).body(tratamientoService.addTratamiento(tratamiento));
		}

	}

	// Eliminar tratamiento
	@DeleteMapping("/delete/tratamiento/{id}")
	public ResponseEntity<?> deleteTratamiento(@PathVariable long id) throws Exception {
		Tratamiento t = tratamientoService.findTratamientoById(id);
		boolean deleted = tratamientoService.removeTratamiento(id);
		if (deleted)
			return ResponseEntity.ok(t);
		else
			return ResponseEntity.noContent().build();

	}

}
