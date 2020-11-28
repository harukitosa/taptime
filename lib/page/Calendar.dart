import 'package:flutter/material.dart';
import 'package:sagyoou/di.dart';
import 'package:sagyoou/model/task.dart';
import 'package:sagyoou/model/task_detail.dart';
import 'package:sagyoou/model/type.dart';
import 'package:sagyoou/usecase/task_usecase.dart';
import 'package:sagyoou/usecase/type_usecase.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '記録',
          style: TextStyle(color: Colors.black54),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed("/setting");
            },
          ),
        ],
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
  TypeUseCase _typeUsecase;
  List<Task> _list;
  List<TypeData> _types;
  List<TaskDetail> _taskList = [];
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    Future(() async {
      _taskUsecase = await initTask();
      _typeUsecase = await initType();
      _refreshData(DateTime.now());
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
    _refreshData(date);
  }

  void _refreshData(DateTime date) {
    Future(() async {
      _list = await _taskUsecase.getSpan(date);
      _types = await _typeUsecase.getAllType();
      _taskList = [];
      for (final task in _list) {
        for (final type in _types) {
          if (task.typeID == type.id) {
            _taskList.add(
              TaskDetail(
                content: task.content,
                id: task.id,
                typeContent: type.content,
                color: type.color,
                createTime: task.createTime,
              ),
            );
            continue;
          }
        }
      }
      setState(() {});
    });
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
          _switchTaskWidget(context),
        ],
      ),
    );
  }

  Widget _switchTaskWidget(BuildContext context) {
    if (_taskList.length > 0) {
      return _taskListWidget(context);
    }
    return _noTaskWidget(context);
  }

  Widget _noTaskWidget(BuildContext context) {
    return Center(
      child: Text("タスクはありません"),
    );
  }

  Widget _taskListWidget(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.only(
              top: 2,
              left: 2,
            ),
            // decoration: new BoxDecoration(
            //   border: Border.all(color: Colors.black12),
            // ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 30,
                  child: Center(
                    child: Text('${_taskList[index].date()}'),
                  ),
                ),
                Container(
                  width: 10,
                  height: 30,
                  margin: EdgeInsets.only(
                    right: 4,
                    left: 4,
                  ),
                  color: _taskList[index].colorObj(),
                ),
                Text('${_taskList[index].content}'),
              ],
            ),
          );
        },
        itemCount: _taskList.length,
      ),
    );
  }
}
