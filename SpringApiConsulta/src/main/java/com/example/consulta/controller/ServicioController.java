package com.example.consulta.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.consulta.constantes.Constantes;
import com.example.consulta.repository.CitasRepository;
import com.example.consulta.repository.ClienteRepository;
import com.example.consulta.repository.ServicioRepository;
import com.example.consulta.service.CitasService;
import com.example.consulta.service.ClienteService;
import com.example.consulta.service.ServicioService;

@Controller
@RequestMapping("/servicio")
public class ServicioController {

	@Autowired
	@Qualifier("servicioRepository")
	private ServicioRepository servicioRepository;
	
	@Autowired
	@Qualifier("servicioService")
	private ServicioService servicioService;
	
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
	
	@GetMapping("/admin/listServicios")
	public ModelAndView listServicios(@RequestParam(name = "error", required = false) String error) {
		ModelAndView mav = new ModelAndView(Constantes.CRUD_SERVICIO_VIEW);
		mav.addObject("servicios", servicioService.listAllServicios());
		mav.addObject("error", error);
		return mav;
	}
	
	@GetMapping("/admin/delete/{id}")
	public String deleteServicio(@PathVariable("id") int id, RedirectAttributes flash) throws Exception {
		if (clienteService.removeCliente(id)) {
			flash.addFlashAttribute("success", "Servicio eliminado con éxito");
			return "redirect:/servicio/admin/listServicios?success";
		} else {
			flash.addFlashAttribute("error", "No se pudo eliminar el servicio");
			return "redirect:/servicio/admin/listServicios?error";
		}
	}
}
