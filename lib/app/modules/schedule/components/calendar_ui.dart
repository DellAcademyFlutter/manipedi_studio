import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:manipedi_studio/app/modules/schedule/pages/daily_schedules.dart';
import 'package:manipedi_studio/app/modules/schedule/schedule_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarController _calendarController;
  final scheduleController = Modular.get<ScheduleController>();
  final Map<DateTime, List> _events = {DateTime(2021, 1, 4): ['New Year\'s Day']};

  //Example: =
  //   final Map<DateTime, List> _events = {DateTime(2021, 1, 4): ['New Year\'s Day']};

  @override
  void initState() {
    super.initState();
    //initializeDateFormatting('pt_BR', null);
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime daySelected, List events, List holidays) {

    //Atualizando o dia selecionado no controller
    scheduleController.selectedDay = daySelected;
    scheduleController.day = daySelected.day.toString();
    scheduleController.month = daySelected.month.toString();
    scheduleController.year = daySelected.year.toString();

    Navigator.pushNamed(context, DailySchedules.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      // Configurações básicas
      //locale: 'pt_BR',
      calendarController: _calendarController,
      events: _events,

      //Estilo do calendário
      calendarStyle: CalendarStyle(
        selectedColor: Colors.pinkAccent[400],
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.brown[700],
        outsideDaysVisible: false,
      ),

      //Estilo do cabeçalho
      headerStyle: HeaderStyle(
        titleTextStyle: TextStyle().copyWith(color: Colors.pink),
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),

      builders: CalendarBuilders(
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Container(
                margin: const EdgeInsets.all(4.0),
                padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                color: Colors.pink[200],
                width: 100,
                height: 100,
                child: Center(
                  child: Text(
                    '${date.day}',
                    style: TextStyle().copyWith(fontSize: 18.0),
                  ),
                ),
              ),
            );
          }
          return children;
        },
      ),

      onDaySelected: (date, events, holidays) {
        _onDaySelected(date, events, holidays);
      },
    );
  }
}



Widget _buildHolidaysMarker() {
  return Row(
    children: [
      Container(
        height: 40,
        width: 40,
        color: Colors.green,
      ),
      Icon(
        Icons.auto_awesome,
        size: 20.0,
        color: Colors.pink[800],
      ),
    ],
  );
}
