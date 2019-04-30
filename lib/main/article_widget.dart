import 'package:flutter/material.dart';
import 'package:rxdart_test/bean/ArticleListBean.dart';
import 'package:rxdart_test/public_ui/webview_page.dart';
class ArticleWidget extends StatelessWidget{
  ArticleBean _bean;
  ArticleWidget(this._bean);
  @override
  Widget build(BuildContext context) {
    return new InkWell(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder:(context){
            return WebViewPage(title: _bean.title,url: _bean.link,);
          }));
        },
        child:Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child:Container(
                    padding: EdgeInsets.all(15),
                    child: Text(_bean.title,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,),maxLines: 2, textAlign: TextAlign.left,),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child:Text(_bean.niceDate,textAlign: TextAlign.right,style: TextStyle(fontSize: 12),),
                )
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(15, 0, 0, 15),
              child: Text(_bean.author,style: TextStyle(color: Colors.blue,fontSize: 12),textAlign: TextAlign.left,),
            ),
          ],
        )
    );;
  }

}