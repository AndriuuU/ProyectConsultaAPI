package com.example.consulta.model;


public class UserModel {
	
	private long id;
	private String username;
	private String password;
	private boolean enable;
	private String role;
	private String token;
	
	public UserModel() {
		super();
	}
	
	public UserModel(String username, String password, boolean enable, String role, String token) {
		super();
		this.username = username;
		this.password = password;
		this.enable = enable;
		this.role = role;
		this.token = token;
	}

	public UserModel(long id, String username, String password, boolean enable, String role, String token) {
		super();
		this.id = id;
		this.username = username;
		this.password = password;
		this.enable = enable;
		this.role = role;
		this.token = token;
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
		return "UserModel [id=" + id + ", username=" + username + ", password=" + password + ", enable=" + enable
				+ ", role=" + role + ", token=" + token + "]";
	}
	
	
}
