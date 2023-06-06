package com.example.consulta.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import com.example.consulta.constantes.Constantes;
import com.example.consulta.entity.Cliente;
import com.example.consulta.entity.User;
import com.example.consulta.model.UserModel;
import com.example.consulta.repository.UserRepository;
import com.example.consulta.service.ClienteService;
import com.example.consulta.serviceImpl.UserService;

import jakarta.validation.Valid;

@Controller
@RequestMapping("/cliente")
public class ClienteController {

	@Autowired
	@Qualifier("userService")
	private UserService userService;

	@Autowired
	@Qualifier("userRepository")
	private UserRepository userRepository;

	@Autowired
	@Qualifier("clienteService")
	private ClienteService clienteService;

	@GetMapping("/home")
	public RedirectView redirect() {
		return new RedirectView("/cliente/admin/listClientes");
	}

	@GetMapping("/admin/listClientes")
	public ModelAndView listClientes(@RequestParam(name = "error", required = false) String error) {
		ModelAndView mav = new ModelAndView(Constantes.CRUD_CLIENTE_VIEW);
		mav.addObject("clientes", clienteService.listAllClientes());
		mav.addObject("error", error);
		return mav;
	}

	@GetMapping("/admin/insertCliente")
	public String registerForm(Model model, @RequestParam(name = "error", required = false) String error) {
		model.addAttribute("alumno", new Cliente());
		model.addAttribute("message", error);
		return Constantes.INSERT_CLIENTE;
	}

	@PostMapping("/admin/insert/cliente")
	public String register(@ModelAttribute Cliente cliente, RedirectAttributes flash) {
		if (userRepository.findByUsername(cliente.getEmail()) == null) {
			clienteService.addCliente(clienteService.transform(cliente));
			flash.addFlashAttribute("success", "Cliente registrado correctamente");
			return "redirect:/cliente/admin/listClientes";
		} else {
			flash.addFlashAttribute("error", "No se pudo registrar el cliente");
			return "redirect:/cliente/admin/listClientes?error";
		}

	}

	// Metodo de borrar
	@GetMapping("/admin/delete/cliente/{id}")
	public String deleteAlumno(@PathVariable("id") int id, RedirectAttributes flash) throws Exception {
		if (clienteService.removeCliente(id)) {
			flash.addFlashAttribute("success", "Cliente eliminado con éxito");
			return "redirect:/cliente/admin/listClientes?success";
		} else {
			flash.addFlashAttribute("error", "No se pudo eliminar el cliente");
			return "redirect:/cliente/admin/listClientes?error";
		}
	}

	// User

	@GetMapping("/admin/listUsers")
	public ModelAndView listUsers() {
		ModelAndView mav = new ModelAndView(Constantes.CRUD_USER_VIEW);
		mav.addObject("users", userService.listAllUsuarios());
		return mav;
	}

	@GetMapping("/admin/insertUser")
	public String registerFormUser(Model model, @RequestParam(name = "error", required = false) String error) {
		model.addAttribute("user", new com.example.consulta.entity.User());
		model.addAttribute("message", error);
		return Constantes.INSERT_USER;
	}

	@PostMapping("/admin/insert/user")
	public String registerUser(@ModelAttribute com.example.consulta.entity.User user, RedirectAttributes flash) {
		if (userRepository.findByUsername(user.getUsername()) == null) {
			userService.registrar(user);
			flash.addFlashAttribute("success", "Usuario registrado correctamente");
			return "redirect:/cliente/admin/listUsers";
		} else {
			flash.addFlashAttribute("error", "No se pudo registrar al usuario");
			return "redirect:/cliente/admin/listUsers?error";
		}
	}

	// Metodo de borrar
	@GetMapping("/admin/delete/user/{id}")
	public String deleteUser(@PathVariable("id") int id, RedirectAttributes flash) throws Exception {
		if (userService.deleteUser(userService.findUsuario(id).getUsername()))
			flash.addFlashAttribute("success", "Usuario eliminado con éxito");
		else
			flash.addFlashAttribute("error", "No se pudo eliminar el usuario");
		return "redirect:/cliente/admin/listUsers?error";
	}

	// Activar/deactivar
	@GetMapping("/admin/activar/user/{id}")
	public String activarUser(@PathVariable("id") int id, RedirectAttributes flash) throws Exception {
		if (userService.activar(userService.findUsuario(id).getUsername()) != 0) {
			flash.addFlashAttribute("success", "Usuario ACTIVADO");
			return "redirect:/cliente/admin/listUsers?success";
		}else {
			flash.addFlashAttribute("error", "Usuario DESACTIVADO");
			return "redirect:/cliente/admin/listUsers?error";
		}
	}

}
