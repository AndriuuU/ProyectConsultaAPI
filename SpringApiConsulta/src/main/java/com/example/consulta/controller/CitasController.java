package com.example.consulta.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.consulta.constantes.Constantes;
import com.example.consulta.entity.Citas;
import com.example.consulta.model.CitasModel;
import com.example.consulta.repository.CitasRepository;
import com.example.consulta.repository.ClienteRepository;
import com.example.consulta.service.CitasService;
import com.example.consulta.service.ClienteService;

@Controller
@RequestMapping("/cita")
public class CitasController {

	@Autowired
	@Qualifier("clienteRepository")
	private ClienteRepository clienteRepository;

	@Autowired
	@Qualifier("citasRepository")
	private CitasRepository citasRepository;

	@Autowired
	@Qualifier("clienteService")
	private ClienteService clienteService;

	@Autowired
	@Qualifier("citasService")
	private CitasService citasService;

	@GetMapping("/usuario/miscitas")
	public ModelAndView registerForm(Model model) {
		ModelAndView mav = new ModelAndView(Constantes.OBTENER_MI_CITA);
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String userEmail = authentication.getName();
		if(!userEmail.equalsIgnoreCase("anonymousUser")) {
			List<Citas> listci = clienteService.findByEmail(userEmail).getCitas();
		
			mav.addObject("citas", listci);
		}

		return mav;
	}

	@PostMapping("/usuario/get/cita")
	public String registrarCita(@ModelAttribute CitasModel cita, RedirectAttributes flash) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String userEmail = authentication.getName();
		long idCliente = clienteService.findByEmail(userEmail).getId();
		if (citasService.findCitasById(cita.getId()) == null) {
			cita.setCliente(clienteService.findCliente(idCliente));
			citasService.addCitas(cita);
			flash.addFlashAttribute("success", "Cita obtenida");
			return "redirect:/cita/usuario/miscitas";
		} else {
			flash.addFlashAttribute("error", "No se pudo coger la cita");
			return "redirect:/cita/usuario/miscitas?error";
		}
	}

	@GetMapping("/usuario/obtener/cita")
	public ModelAndView registerCita(Model model) {
		ModelAndView mav = new ModelAndView(Constantes.OBTENER_CITA);
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String userEmail = authentication.getName();
		long idCliente = clienteService.findByEmail(userEmail).getId();
		List<CitasModel> listci = citasService.listAllCitass();
		if (listci != null) {
			mav.addObject("citas", listci);
		}
		return mav;
	}
}
