package com.example.consulta.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.validation.constraints.Size;

@Entity
public class User {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private long id;
	
	@Column(name = "username", unique = true, nullable = false)
	private String username;
	
	@Column(name = "password", nullable = false)
	@Size(max=100)
	private String password;
	
	private boolean enable;
	
	private String role;
	
	private String token;

	
	public User(String username, @Size(max = 100) String password, boolean enable, String role, String token) {
		super();
		this.username = username;
		this.password = password;
		this.enable = enable;
		this.role = role;
		this.token = token;
	}

	public User(long id, String username, String password, boolean enable, String role, String token) {
		super();
		this.id = id;
		this.username = username;
		this.password = password;
		this.enable = enable;
		this.role = role;
		this.token = token;
	}

	public User() {
		super();
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public boolean isEnable() {
		return enable;
	}

	public void setEnable(boolean enable) {
		this.enable = enable;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", enable=" + enable + ", role="
				+ role + ", token=" + token + "]";
	}
	
	

}
