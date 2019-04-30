import 'package:flutter/material.dart';
import 'package:rxdart_test/bean/ProjectTree.dart';
import 'package:rxdart_test/data/repository/wan_repository.dart';
import 'package:rxdart_test/project/project_page.dart';

class ProjectTree extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _ProjectGroup();
  }
}
class _ProjectGroup extends State<ProjectTree> with TickerProviderStateMixin {
  TabController _tabController;
  int tabCount = 0;
  List<ProjectTreeBean> mData = new List();
  @override
  void initState() {
    super.initState();
    getProject();
  }
  @override
  Widget build(BuildContext context) {
    _tabController = TabController(length: tabCount, vsync: this);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.blue,
            height: 48,
            child: TabBar(
              indicatorColor: Colors.white,
              labelStyle: TextStyle(fontSize: 16),
              unselectedLabelStyle: TextStyle(fontSize: 16),
              controller: _tabController,
              isScrollable: true,
              tabs: mData.map((data){
                return Tab(text:data.name,);
              }).toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
                children: mData.map((item){
                  return ProjectPage(item.id);
                }).toList(),
                controller: _tabController,
            ),
          )
        ],
      ),
    );
  }

  Future getProject() async{
    WanRepository().getProjectTree().then((value){
      mData = value;
      tabCount = mData == null? 0 : mData.length;
      setState(() {});
    });
  }


}