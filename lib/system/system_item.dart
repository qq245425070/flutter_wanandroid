import 'package:flutter/material.dart';
import 'package:rxdart_test/bean/system_bean.dart';
import 'package:rxdart_test/system/system_child.dart';
class SystemItemPage extends StatefulWidget {
  SystemItemBean _itemBean;
  @override
  State<StatefulWidget> createState() {
    return SystemItemState();
  }

  SystemItemPage(this._itemBean);
}
class SystemItemState extends State<SystemItemPage> with TickerProviderStateMixin<SystemItemPage>{

  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget._itemBean.children.length, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(widget._itemBean.name),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.blue,
            height: 48,
            width: double.infinity,
              child: TabBar(
                controller: _tabController,
                tabs: widget._itemBean.children.map((value){
                  return Text(value.name);
                }).toList(),
                isScrollable: true,
                indicatorColor: Colors.white,
                labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                unselectedLabelStyle: TextStyle(fontSize: 16,),
              ),
          ),
          Expanded(
            child: TabBarView(
              children: widget._itemBean.children.map((value)=>SystemChildPage(value.id)).toList(),
              controller: _tabController,
            ),
          ),
        ],
      )
    );
  }

}