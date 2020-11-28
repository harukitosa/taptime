import 'package:flutter/material.dart';
import 'package:taptime/di.dart';
import 'package:taptime/usecase/task_usecase.dart';
import 'package:taptime/usecase/type_usecase.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TapTime",
          style: TextStyle(color: Colors.black54),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed("/calendar");
            },
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _FormWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormWidget extends StatefulWidget {
  _FormWidget({Key key}) : super(key: key);

  @override
  __FormWidgetState createState() => __FormWidgetState();
}

class __FormWidgetState extends State<_FormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();
  TypeUseCase _typeUsecase;
  TaskUseCase _taskUsecase;

  @override
  void initState() {
    super.initState();
    Future(() async {
      _typeUsecase = await initType();
      _taskUsecase = await initTask();
      setState(() {});
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _onSave() async {
    if (_formKey.currentState.validate()) {
      this._formKey.currentState.save();
      await _taskUsecase.createTask(_textEditingController.text, 1);
      _textEditingController.text = "";
      _snackBarAction();
    }
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
      duration: Duration(seconds: 3),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 22.0, left: 22),
            child: TextFormField(
              controller: _textEditingController,
              keyboardType: TextInputType.multiline,
              maxLines: 8,
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
          Center(
            child: Container(
              width: 300,
              height: 70,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                color: Colors.black,
                onPressed: _onSave,
                child: Text(
                  '記録',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
