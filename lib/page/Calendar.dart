import 'package:flutter/material.dart';
import 'package:sagyoou/di.dart';
import 'package:sagyoou/model/task.dart';
import 'package:sagyoou/usecase/task_usecase.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            CalendarView(),
          ],
        ),
      ),
    );
  }
}

class CalendarView extends StatefulWidget {
  CalendarView({Key key}) : super(key: key);

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  TaskUseCase _taskUsecase;
  List<Task> _list;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    Future(() async {
      _taskUsecase = await initTask();
      _list = await _taskUsecase.getAllTask();
      for (int i = 0; i < _list.length; i++) {
        print(_list[i].createTime);
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(
    DateTime date,
    List<dynamic> list,
    List<dynamic> list2,
  ) async {
    _list = await _taskUsecase.getSpan(date);
    setState(() {});
    print(date);
    print(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          TableCalendar(
            calendarController: _calendarController,
            initialCalendarFormat: CalendarFormat.week,
            // events: _events,
            // holidays: _holidays,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              selectedColor: Colors.black,
              todayColor: Colors.black54,
              markersColor: Colors.black,
              outsideDaysVisible: false,
            ),
            headerStyle: HeaderStyle(
              formatButtonTextStyle: TextStyle().copyWith(
                color: Colors.white,
                fontSize: 15.0,
              ),
              formatButtonDecoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            onDaySelected: _onDaySelected,
            // onVisibleDaysChanged: _onVisibleDaysChanged,
            // onCalendarCreated: _onCalendarCreated,
          ),
          Flexible(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8,
                    right: 4,
                    left: 4,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Text('${_list[index].content}'),
                  ),
                );
              },
              itemCount: _list.length,
            ),
          ),
        ],
      ),
    );
  }
}
