import 'package:flutter/material.dart';
import 'package:TimeTap/di.dart';
import 'package:TimeTap/model/type.dart';
import 'package:TimeTap/usecase/type_usecase.dart';

class TypeDataDetail extends StatelessWidget {
  const TypeDataDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "タグの変更",
          style: TextStyle(color: Colors.black54),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: TypeDataDetailPage(),
    );
  }
}

class TypeDataDetailPage extends StatefulWidget {
  TypeDataDetailPage({Key key}) : super(key: key);

  @override
  _TypeDataDetailPageState createState() => _TypeDataDetailPageState();
}

class _TypeDataDetailPageState extends State<TypeDataDetailPage> {
  TypeUseCase _typeUsecase;
  List<TypeData> _types = [];
  var _typesController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future(() async {
      _typeUsecase = await initType();
      _types = await _typeUsecase.getAllType();
      for (var i = 0; i < _types.length; i++) {
        _typesController[i].text = _types[i].content;
      }
      setState(() {});
    });
  }

  Widget _inputForm(BuildContext context, int index) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.all(12),
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _types[index].colorObj(),
          ),
        ),
        Container(
          width: 300,
          child: TextFormField(
            controller: _typesController[index],
            textInputAction: TextInputAction.next,
            autofocus: true,
            validator: (value) {
              if (value.isEmpty) {
                return 'テキストを入力してください。';
              }
              return null;
            },
            onSaved: (value) {},
          ),
        ),
      ],
    );
  }

  Future<void> _save() async {
    List<TypeData> _list = [];
    for (int i = 0; i < _types.length; i++) {
      _list.add(
        TypeData(
          id: _types[i].id,
          content: _typesController[i].text,
          color: _types[i].color,
          createTime: _types[i].createTime,
          updateTime: _types[i].updateTime,
          delete: _types[i].delete,
        ),
      );
    }
    await _typeUsecase.save(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _types.length != 0
            ? <Widget>[
                _inputForm(context, 0),
                _inputForm(context, 1),
                _inputForm(context, 2),
                _inputForm(context, 3),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      color: Colors.black,
                      // 送信ボタンクリック時の処理
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          _save();
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text('更新しました。'),
                            ),
                          );
                        }
                      },
                      child: Text(
                        '保存する',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ]
            : [],
      ),
    );
  }
}
