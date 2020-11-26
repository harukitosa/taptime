import 'package:flutter/material.dart';
import 'package:sagyoou/di.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sagyoou"),
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
  final _task = initTask();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState.validate()) {
      this._formKey.currentState.save();
      print(_textEditingController.text);
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
              maxLines: 12,
              decoration: const InputDecoration(
                labelText: "Task", // ラベル
                border: InputBorder.none,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                color: Colors.blue[200],
                onPressed: _onSave,
                child: Text('保存'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
