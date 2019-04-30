import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart_test/common/common.dart';
import 'package:rxdart_test/data/net/dio_util.dart';
import 'package:rxdart_test/main/HomePage.dart';
import 'package:rxdart_test/project/project_tree.dart';
import 'package:rxdart_test/system/system_tree.dart';
import 'package:rxdart_test/wx/wx_chat.dart';

void main() => runApp(MyAppWight());
class MyAppWight extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyAppWight();
  }

}
class _MyAppWight extends State<MyAppWight> {
  int currentIndex = 0;
  List<String> titles = List();
  var pages = [HomePage(),ProjectTree(),SystemTreePage(),WxChartPage()];
  @override
  void initState() {
    super.initState();
    titles.add("首页");
    titles.add("项目");
    titles.add("体系");
    titles.add("公众号");
    Options options = DioUtil.getDefOptions();
    options.baseUrl = Constant.SERVER_ADDRESS;
    HttpConfig config = new HttpConfig(options: options);
    DioUtil().setConfig(config);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            elevation: 1,
            title: Text(titles[currentIndex]),
          ),
          body: IndexedStack(children: pages, index: currentIndex),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(title:Text("首页"),icon: Icon(Icons.android)),
              BottomNavigationBarItem(title:Text("项目"),icon: Icon(Icons.print)),
              BottomNavigationBarItem(title:Text("体系"),icon: Icon(Icons.subject)),
              BottomNavigationBarItem(title:Text("公众号"),icon: Icon(Icons.group)),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            onTap: (index){
                setState(() {
                  currentIndex = index;
                });
            },
          ),
      ),
    );
  }
}

