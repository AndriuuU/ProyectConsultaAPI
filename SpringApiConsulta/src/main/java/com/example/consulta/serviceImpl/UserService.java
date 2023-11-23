package com.example.consulta.serviceImpl;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.core.userdetails.User.UserBuilder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.consulta.repository.UserRepository;

@Service("userService")
public class UserService implements UserDetailsService {

	@Autowired
	@Qualifier("userRepository")
	private UserRepository userRepository;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		com.example.consulta.entity.User usuario = userRepository.findByUsername(username);

		UserBuilder builder = null;

		if (usuario != null) {
			builder = User.withUsername(username);
			builder.disabled(false);
			builder.password(usuario.getPassword());
			builder.authorities(new SimpleGrantedAuthority(usuario.getRole()));

		} else
			throw new UsernameNotFoundException("Usuario no encontrado");
		return builder.build();
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	public com.example.consulta.entity.User registrar(com.example.consulta.entity.User user) {
		user.setUsername(user.getUsername());
		user.setPassword(passwordEncoder().encode(user.getPassword()));
		user.setEnable(true);
		if(user.getRole()==null) {
			user.setRole("ROLE_USER");
		}
		return userRepository.save(user);
	}
	
	public com.example.consulta.entity.User updateUser(com.example.consulta.entity.User user) {
		return userRepository.save(user);
	}

	public int activar(String username) {
		int a = 0;
		com.example.consulta.entity.User u = userRepository.findByUsername(username);

		u.setId(u.getId());

		if (u.isEnable() == false) {
			u.setEnable(true);
			a = 1;
		} else {
			u.setEnable(false);
			a = 0;
		}
		u.setRole(u.getRole());

		userRepository.save(u);
		return a;
	}

	public boolean deleteUser(String username) throws Exception {
		com.example.consulta.entity.User u = userRepository.findByUsername(username);
		if (u != null) {
		
			if (u.getUsername() != null) {
				userRepository.delete(u);
			}
		return true;
	}

		return false;
	}

	public List<com.example.consulta.entity.User> listAllUsuarios() {
		return userRepository.findAll().stream().collect(Collectors.toList());
	}

	public com.example.consulta.entity.User findUsuario(String username) {
		return userRepository.findByUsername(username);
	}

	public com.example.consulta.entity.User findUsuario(long id) {
		return userRepository.findById(id);

	}

}
