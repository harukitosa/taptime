import 'package:flutter/material.dart';
import 'package:TimeTap/model/task.dart';
import 'package:TimeTap/di.dart';
import 'package:TimeTap/model/type.dart';
import 'package:TimeTap/usecase/task_usecase.dart';
import 'package:TimeTap/usecase/type_usecase.dart';

class TaskDetailPage extends StatelessWidget {
  const TaskDetailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '詳細・編集',
          style: TextStyle(color: Colors.black54),
        ),
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
            TaskDetailPageView(),
          ],
        ),
      ),
    );
  }
}

class TaskDetailPageView extends StatefulWidget {
  TaskDetailPageView({Key key}) : super(key: key);
  @override
  _TaskDetailPageViewState createState() => _TaskDetailPageViewState();
}

class _TaskDetailPageViewState extends State<TaskDetailPageView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();
  TypeUseCase _typeUsecase;
  TaskUseCase _taskUsecase;
  List<TypeData> _typeList = [];
  Task _task;

  int taskID = 0;
  int currentSelectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Future(() async {
      _typeUsecase = await initType();
      _taskUsecase = await initTask();
      _typeList = await _typeUsecase.getAllType();
      taskID = ModalRoute.of(context).settings.arguments as int;
      _task = await _taskUsecase.getTaskByID(taskID);
      _textEditingController.text = _task.content;
      for (int i = 0; i < _typeList.length; i++) {
        if (_task.typeID == _typeList[i].id) {
          currentSelectedIndex = i;
        }
      }
      print(_task);
      setState(() {});
    });
  }

  /// Folderを削除するボタンを押した時
  void _deletePopup() {
    showDialog<AlertDialog>(
      context: context,
      child: AlertDialog(
        title: const Text('確認画面'),
        content: Text('${_task.content}を本当に削除しますか？'),
        actions: <Widget>[
          // ボタン領域
          FlatButton(
            child: const Text('キャンセル'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: const Text('削除'),
            onPressed: () async {
              await _taskUsecase.delete(_task);
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _onSave() async {
    if (_formKey.currentState.validate()) {
      this._formKey.currentState.save();
      await _taskUsecase.update(
        _task,
        _textEditingController.text,
        _typeList[currentSelectedIndex].id,
      );
      _snackBarAction();
    }
  }

  Widget _selectorItem(BuildContext context, TypeData item, int index) {
    bool selectedIndex = index == currentSelectedIndex;
    double width = selectedIndex ? 50 : 25;
    double height = selectedIndex ? 50 : 25;
    // Color borderColor = selectedIndex ? Colors.black54 : Colors.white;
    return InkWell(
      onTap: () {
        setState(() {
          currentSelectedIndex = index;
        });
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: item.colorObj(),
        ),
      ),
    );
  }

  List<Widget> _colorSelector(BuildContext context) {
    if (_typeList.length == 0) {
      return [
        Text('loading'),
      ];
    }
    List<Widget> _list = [];
    for (int i = 0; i < _typeList.length; i++) {
      _list.add(
        _selectorItem(context, _typeList[i], i),
      );
    }
    return _list;
  }

  void _snackBarAction() {
    final snackBar = SnackBar(
      content: Text('保存しました'),
      action: SnackBarAction(
        label: 'とじる',
        onPressed: () {
          Scaffold.of(context).removeCurrentSnackBar();
        },
      ),
      duration: Duration(seconds: 2),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 60),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 22.0, left: 22),
              child: TextFormField(
                controller: _textEditingController,
                keyboardType: TextInputType.multiline,
                maxLines: 1,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 2,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  hintText: 'Enter your Task', // 入力ヒント
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32.0, bottom: 22.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _colorSelector(context),
              ),
            ),
            Column(
              children: [
                Center(
                  child: Container(
                    width: 300,
                    height: 70,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      color: Colors.black,
                      onPressed: _onSave,
                      child: Text(
                        '保存',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.black,
                      size: 32,
                    ),
                    onPressed: _deletePopup,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
