import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:consulta_dermatologica/src/utils.dart';

import '../models/models.dart';
import 'screens.dart';

class CalendarioCitasScreen extends StatefulWidget {
  @override
  _TableEventsExampleState createState() => _TableEventsExampleState();
}

class _TableEventsExampleState extends State<CalendarioCitasScreen> {
   late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode =
      RangeSelectionMode.toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

CitasService citasService = CitasService();

final List<String> fechasCitas = [];


  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

 List<Event> _getEventsForDay(DateTime day) {
  final formattedDay = DateFormat('yyyy-MM-dd').format(day); // Formato deseado de la fecha

  final eventsForDay = fechasCitas
      .where((fecha) => DateFormat('yyyy-MM-dd').format(parseDateTime(fecha)) == formattedDay)
      .map((fecha) => Event(fecha))
      .toList();

  return eventsForDay;
}

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);

    List<Event> events = [];
    for (var day in days) {
      events.addAll(_getEventsForDay(day));
    }

    return events;
  }

  DateTime parseDateTime(String dateString) {
    return DateTime.parse(dateString);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

   @override
  Widget build(BuildContext context) {
    
    List<CitasModel> citas = citasService.listaCitas;
    fechasCitas.clear();
    for(CitasModel fecha in citas) {
      fechasCitas.add(fecha.fechaCompleta);
    }
    
    final List<DateTime> parsedDates =
        fechasCitas.map((dateString) => parseDateTime(dateString)).toList();

   return Scaffold(
      appBar: AppBar(
            leading: IconButton(
            icon: Icon(Icons.keyboard_return),
            onPressed: () =>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PaginaPrincipal()))

          ),
            title: Text("Calendario mis citas"),
            backgroundColor: Colors.deepPurple
          ),
      body: Column(
        children: [
          TableCalendar<Event>(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              // Use `CalendarStyle` to customize the UI
              outsideDaysVisible: false,
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () => print('${value[index]}'),
                        title: Text(formatDateTime('${value[index]}')),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String formatDateTime(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat("dd/MM/yyyy").format(dateTime);
    String formattedTime = DateFormat("HH:mm").format(dateTime);

    return 'Cita: $formattedDate a las $formattedTime.';
  }
}
