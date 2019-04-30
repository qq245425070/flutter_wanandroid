import 'package:flutter/material.dart';
import 'package:rxdart_test/bean/system_bean.dart';
import 'package:rxdart_test/data/repository/wan_repository.dart';
import 'package:rxdart_test/wx/chart_public.dart';
class WxChartPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return WxChartState();
  }

}

class WxChartState extends State<WxChartPage> with TickerProviderStateMixin{

  TabController _tabController;
  List<SystemItemBean> mData=[];
  int tabLength;
  @override
  void initState() {
    super.initState();
    tabLength = 0;
    getTitleData();
  }
  @override
  Widget build(BuildContext context) {
    _tabController = TabController(length: tabLength, vsync: this);
    return Scaffold(
      body:Column(
        children: <Widget>[
          Container(
            height: 48,
            color: Colors.blue,
            width: double.infinity,
            child:  TabBar(
              tabs: mData.map((bean)=>Tab(text: bean.name,)).toList(),
              controller: _tabController,
              indicatorColor: Colors.white,
              isScrollable: true,
              labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: mData.map((item)=>ChartPublicPage(item.id)).toList(),
            ),
          ),
        ],
      )
    );
  }

  Future getTitleData() async{
    WanRepository().getWXChapters().then((value){
      if(value != null) {
        mData = value;
        tabLength = mData.length;
        setState(() {});
      }
    });
  }
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

}