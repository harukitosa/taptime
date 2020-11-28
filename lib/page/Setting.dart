import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatelessWidget {
  final list = [
    _ItemIconMap(title: '利用規約', icon: const Icon(Icons.settings)),
    _ItemIconMap(title: 'プライバシーポリシー', icon: const Icon(Icons.settings)),
  ];

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      final error = new ArgumentError('wrong url $url');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    /// _onTap
    /// [index]押された場所のインデックス
    /// List内のアイコンが押された時に呼び出される
    void _onTap(int index) {
      if (list[index].title == '利用規約') {
        _launchURL('https://harukitosa.github.io/tap_time_kiyaku.html');
      }
      if (list[index].title == 'プライバシーポリシー') {
        _launchURL('https://harukitosa.github.io/tap_time_privacy.html');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '設定',
          style: TextStyle(color: Colors.black54),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _IconListView(onTap: _onTap, list: list),
          ],
        ),
      ),
    );
  }
}

class _ItemIconMap {
  _ItemIconMap({@required this.title, @required this.icon});
  final String title;
  final Icon icon;
}

class _IconListView extends StatelessWidget {
  const _IconListView({
    Key key,
    @required this.onTap,
    @required this.list,
  }) : super(key: key);

  final List<_ItemIconMap> list;
  final ValueChanged<int> onTap;

  void _itemTap(int index) {
    onTap(index);
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return FlatButton(
            onPressed: () => {_itemTap(index)},
            child: Text('${list[index].title}'),
          );
        },
        itemCount: list.length,
      ),
    );
  }
}
