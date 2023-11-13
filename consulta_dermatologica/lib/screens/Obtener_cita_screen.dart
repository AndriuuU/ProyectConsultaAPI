import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'package:consulta_dermatologica/services/services.dart';
import 'package:consulta_dermatologica/models/models.dart';

class ObtenerCita extends StatefulWidget {
  @override
  _ObtenerCitaState createState() => _ObtenerCitaState();
}

class _ObtenerCitaState extends State<ObtenerCita> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? _selectedHora;
  ServicioModel? _selectedService;

  final List<String> horasDisponibles = [
    '09:00 AM',
    '09:45 AM',
    '10:30 AM',
    '11:15 AM',
    '12:00 PM',
    '12:45 PM',
    '13:30 PM'
  ];
  

  @override
  Widget build(BuildContext context) {
    final servicioService = Provider.of<ServicioService>(context);
    final allServices = servicioService.listaServicios;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_return),
          onPressed: () =>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PaginaPrincipal()))

        ),
        title: Text("Obtener nueva cita"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
        //   AppBar(
        //     title: Text("Calendario"),
        // backgroundColor: Colors.red,
        // ),
        AppBar(
          
            backgroundColor: Colors.red,
            title: Text(
              'Calendario',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TableCalendar(
            firstDay: DateTime.now(),
            lastDay: DateTime.utc(2024, 12, 31),
            focusedDay: _focusedDay,
            rangeStartDay: DateTime.now(),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: _calendarFormat,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _selectedHora = null;
                _selectedService = null;
              });
              
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          if (_selectedDay != null)
            DropdownButton<ServicioModel>(
              value: _selectedService,
              items: allServices.map((servicio) {
                return DropdownMenuItem<ServicioModel>(
                  value: servicio,
                  child: Text(servicio.nombre), // Asegúrate de tener un campo 'nombre' en tu modelo de servicio
                );
              }).toList(),
              onChanged: (selectedService) {
                setState(() {
                  _selectedService = selectedService;
                });
              },
              hint: Text('Seleccione un servicio'),
            ),
           if (_selectedDay != null)
            DropdownButton<String>(
              value: _selectedHora,
              items: horasDisponibles.map((hora) {
                return DropdownMenuItem<String>(
                  value: hora,
                  child: Text(hora),
                );
              }).toList(),
              onChanged: (selectedHora) {
                setState(() {
                  _selectedHora = selectedHora;
                });
              },
              hint: Text('Seleccione una hora'),
            ),
          if (_selectedDay != null && _selectedHora != null && _selectedService != null) 
          ElevatedButton(
            
            onPressed: () {
             
                print(_selectedDay);
                print(_selectedHora);
                print(_selectedService);
                // Aquí puedes manejar la lógica para reservar la cita
                // Utiliza _selectedDay, _selectedHora y _selectedService para guardar la cita en tu base de datos o donde sea necesario.
                // Por ejemplo, puedes mostrar un diálogo de confirmación o enviar los datos a un servidor.
              
            },
            child: Text('Reservar Cita'),
          )

          else if(_selectedDay==null)
          Center(
              child: Text('Seleccina una fecha')
          )
          
          
        ],
      ),
    );
  }
}
