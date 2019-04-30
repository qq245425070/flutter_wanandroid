import 'package:flutter/material.dart';
import 'package:rxdart_test/bean/system_bean.dart';
import 'package:rxdart_test/data/repository/wan_repository.dart';
import 'package:rxdart_test/system/system_item.dart';
class SystemTreePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SystemTreeState();
  }
}
class SystemTreeState extends State<SystemTreePage>{

  List<SystemItemBean> mData;
  @override
  void initState() {
    super.initState();
    getSystemData();
  }
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: buildItem,
        itemCount: mData == null ? 0 : mData.length,
        physics: new AlwaysScrollableScrollPhysics(),
        cacheExtent: 10,
        separatorBuilder: (context,index){
          return Container(height: 1,color: Colors.grey[200],);
        },
    );
  }

  void getSystemData() {
    WanRepository().getSystemList().then((value){
      mData = value == null ? List() : value;
      print(value.toString());
      setState(() {});
    });
  }


  Widget buildItem(BuildContext context, int index) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return  SystemItemPage(mData[index]);
        }));
      },
      child: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      alignment: Alignment.centerLeft,
                      child:  Text(
                        mData[index].name,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF3D4E5F),
                          fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: buildChildren(mData[index].children),
                    ),
                  ],
                ),
              ),
            ),
            Icon(Icons.chevron_right,color: Colors.grey,),
          ],
        ),
      ),
    );
  }

  Widget buildChildren(List<SystemItemBean> children) {
    List<Widget> titles = [];
    for(SystemItemBean bean in children){
      titles.add(
          Chip(
            label: Text(bean.name),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: nameToColor(bean.name),
          )
      );
    }
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.start,
      children: titles,
    );
  }
  Color nameToColor(String name) {
    final int hash = name.hashCode & 0xffff;
    final double hue = (360.0 * hash / (1 << 15)) % 360.0;
    return HSVColor.fromAHSV(1.0, hue, 0.4, 0.90).toColor();
  }
}