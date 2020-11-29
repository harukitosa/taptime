import 'package:flutter/material.dart';
import 'package:taptime/di.dart';
import 'package:taptime/model/task.dart';
import 'package:taptime/model/task_detail.dart';
import 'package:taptime/model/type.dart';
import 'package:taptime/usecase/task_usecase.dart';
import 'package:taptime/usecase/type_usecase.dart';
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
  Future<List<TaskDetail>> _taskList;
  CalendarController _calendarController;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    Future(() async {
      _taskUsecase = await initTask();
      _typeUsecase = await initType();
      _taskList = _fetchData(_selectedDate);
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
    _selectedDate = date;
    _taskList = _fetchData(_selectedDate);
    setState(() {});
  }

  Future<List<TaskDetail>> _fetchData(DateTime date) async {
    _list = await _taskUsecase.getSpan(date);
    _types = await _typeUsecase.getAllType();
    var _tasks = <TaskDetail>[];
    for (final task in _list) {
      for (final type in _types) {
        if (task.typeID == type.id) {
          _tasks.add(
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
    return _tasks;
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
          _taskListWidget(context),
        ],
      ),
    );
  }

  Widget _taskListWidget(BuildContext context) {
    return Flexible(
      child: FutureBuilder<List<TaskDetail>>(
        future: _taskList,
        builder: (
          BuildContext context,
          AsyncSnapshot<List<TaskDetail>> snapshot,
        ) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                );
              }
              if (snapshot.hasData) {
                return _listShow(context, snapshot.data);
              }
              return Center(
                child: SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: CircularProgressIndicator(),
                ),
              );
            default:
              return Center(
                child: SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: CircularProgressIndicator(),
                ),
              );
          }
        },
      ),
    );
  }

  Widget _listShow(BuildContext context, List<TaskDetail> _tasks) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.only(
            top: 2,
            left: 2,
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(
                    '/taskdetail',
                    arguments: _tasks[index].id,
                  )
                  .then(
                    (value) => {
                      _fetchData(DateTime.now()),
                    },
                  );
            },
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 30,
                  child: Center(
                    child: Text('${_tasks[index].date()}'),
                  ),
                ),
                Container(
                  width: 10,
                  height: 30,
                  margin: EdgeInsets.only(
                    right: 4,
                    left: 4,
                  ),
                  color: _tasks[index].colorObj(),
                ),
                Text('${_tasks[index].text()}'),
              ],
            ),
          ),
        );
      },
      itemCount: _tasks.length,
    );
  }
}
