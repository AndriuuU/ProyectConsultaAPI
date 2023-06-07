package com.example.consulta.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfig {

	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		http.csrf().disable().addFilterBefore(new JWTAuthorizationFilter(), UsernamePasswordAuthenticationFilter.class).
		authorizeHttpRequests((requests) -> requests.requestMatchers("/**").permitAll());
//			);
//			requestMatchers("/", "/imgs/","/photos/","/auth/**","/webjars/**","/css/**","/noticias/**","/files/**").permitAll().
//			requestMatchers("/api/admin/**").hasRole("ADMIN").
//			requestMatchers("/api/user/**").hasRole("USER").
//			requestMatchers("/api/all/**").hasAnyRole("USER","ADMIN").	
//			
//			//WEB
//			
//		
//		http.authorizeRequests((requests)->requests
//			.requestMatchers("/cliente/admin/**","/emple/admin/**","/cita/admin/**where").hasRole("ADMIN")
//			.requestMatchers("/css/**").permitAll()
//			.requestMatchers("/**").permitAll())
////			.anyRequest().authenticated())
//			.formLogin((form)->form
//			       .loginPage("/auth/login")
//			       .defaultSuccessUrl("/home",true)
//			       .permitAll())
////			        
//			.logout((logout)->logout.permitAll()
//					.logoutUrl("/auth/logout")
//					.logoutSuccessUrl("/auth/login?logout"));

		return http.build();
	}
	protected void configure(HttpSecurity http) throws Exception {
	      http
	          .logout(logout -> logout                                                
	              .logoutUrl("/auth/logout")                                            
	              .logoutSuccessUrl("/auth/login")                                      
	              .invalidateHttpSession(true)
	                                      
	          );
	  }

	@Bean
	AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration) throws Exception{
		return authenticationConfiguration.getAuthenticationManager();
}
}