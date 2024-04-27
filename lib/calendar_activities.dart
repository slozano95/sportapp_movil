import 'package:flutter/material.dart';
import 'package:sportapp_movil/UI/colors.dart';
import 'package:sportapp_movil/datamanager.dart';
import 'package:sportapp_movil/login_view.dart';
import 'package:sportapp_movil/plan_selector_view.dart';
import 'package:sportapp_movil/utils.dart';
import 'package:table_calendar/table_calendar.dart';
import 'UI/components.dart';

class CalendarActivities extends StatefulWidget {
  const CalendarActivities({super.key});

  @override
  _CalendarActivitiesState createState() => _CalendarActivitiesState();
}

class _CalendarActivitiesState extends State<CalendarActivities> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  DateTime today = DateTime.now();
  String _title = "";

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
    List<Event> events = [];
    for (var element in DataManager().allEntrenamientos) {
      var date = DateTime.parse(element.fechaEntrenamiento ?? "");
      if (date.year == day.year &&
          date.month == day.month &&
          date.day == day.day) {
        events.add(Event(("Entrenamiento: ${element.nombre}")));
      }
    }
    for (var element in DataManager().allEventos) {
      var date = DateTime.parse(element.evento?.fechaEvento ?? "");
      if (date.year == day.year &&
          date.month == day.month &&
          date.day == day.day) {
        events.add(Event(("Evento: ${element.evento?.nombre}")));
      }
    }
    for (var element in DataManager().stravaActivities) {
      var date = DateTime.parse(element.start_date_local ?? "");
      if (date.year == day.year &&
          date.month == day.month &&
          date.day == day.day) {
        events.add(Event(
            ("Strava: ${element.name} (${getReadableTime(element.elapsed_time)})")));
      }
    }
    return events;
  }

  String getReadableTime(int? elapsed_time) {
    if (elapsed_time == null) {
      return "";
    }
    var hours = (elapsed_time / 3600).floor();
    var minutes = ((elapsed_time % 3600) / 60).floor();
    var seconds = (elapsed_time % 60);
    return "${hours}h: ${minutes}m: ${seconds}s";
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      Container(
          padding: const EdgeInsets.fromLTRB(38, 12, 38, 0),
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    signOut();
                  },
                  child: Container(
                      width: 30,
                      height: 30,
                      key: Key("icon_back"),
                      color: Colors.transparent,
                      child: const Image(
                          image: AssetImage("assets/icon_logout.png"),
                          width: 30))),
              Spacer(),
              Text(_title),
              Spacer(),
              GestureDetector(
                  onTap: () {
                    reloadCalendarData();
                  },
                  child: Container(
                      width: 30,
                      height: 30,
                      key: Key("icon_back"),
                      color: Colors.transparent,
                      child:
                          Icon(Icons.replay_outlined, color: AppColors.orange)))
            ],
          )),
      TableCalendar(
        locale: "es_ES",
        rowHeight: 43,
        headerStyle:
            const HeaderStyle(formatButtonVisible: false, titleCentered: true),
        availableGestures: AvailableGestures.all,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        focusedDay: _focusedDay,
        firstDay: kFirstDay,
        lastDay: kLastDay,
        rangeStartDay: _rangeStart,
        rangeEndDay: _rangeEnd,
        calendarFormat: _calendarFormat,
        rangeSelectionMode: _rangeSelectionMode,
        eventLoader: _getEventsForDay,
        startingDayOfWeek: StartingDayOfWeek.monday,
        onDaySelected: _onDaySelected,
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
        calendarStyle: const CalendarStyle(
          todayDecoration: BoxDecoration(
            color: AppColors.orange,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: AppColors.orange,
            shape: BoxShape.circle,
          ),
          selectedTextStyle: TextStyle(color: Colors.white),
          todayTextStyle: TextStyle(color: Colors.white),
        ),
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
                    horizontal: 10.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    onTap: () => print('${value[index]}'),
                    title: Text('${value[index]}'),
                  ),
                );
              },
            );
          },
        ),
      ),
      UIComponents.tabBar(context, TabItem.calendar)
    ])));
  }

  void signOut() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
    );
  }

  void reloadCalendarData() {
    setState(() {
      _title = "Cargando datos...";
    });
    DataManager().getCalendarData().then((value) {
      setState(() {
        _title = "";
      });
    });
  }
}
