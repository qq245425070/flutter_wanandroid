import 'package:flutter/material.dart';
import 'package:rxdart_test/bean/ArticleListBean.dart';
import 'package:rxdart_test/data/repository/wan_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart_test/main/article_widget.dart';
class ChartPublicPage extends StatefulWidget{
  int cid;
  @override
  State<StatefulWidget> createState() {
    return ChartPublicState();
  }

  ChartPublicPage(this.cid);
}

class ChartPublicState extends State<ChartPublicPage>{

  int page = 1;
  RefreshController _controller;
  bool hasMore = true;
  List<ArticleBean> mData = [];
  int itemCount = 0;
  @override
  void initState() {
    super.initState();
    _controller = RefreshController();
    getArticleData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enableOverScroll: true,
        enablePullDown: false,
        enablePullUp: hasMore,
        controller: _controller,
        footerConfig: LoadConfig(),
        footerBuilder: (context,mode){
          return ClassicIndicator(mode: mode,);
        },
        onRefresh: (up){
          if(!up){
            page++;
            return getArticleData();
          }
        },
        child: ListView.separated(
            itemBuilder: (context,index){
              return ArticleWidget(mData[index]);
            },
            separatorBuilder: (context,index){
              return Container(height: 1,color: Colors.blue[100],);
            },
            itemCount: itemCount),
      ),
    );
  }

  Future getArticleData() async{
    WanRepository().getWxArticle(page, widget.cid).then((value){
      if(value != null) {
        print(value.toString());
        mData.addAll(value.articles);
        itemCount = mData.length;
        hasMore = !value.over;
        if(mounted) {
          _controller.sendBack(false, RefreshStatus.idle);
          setState(() {});
        }
      }
    });
  }
  @override
  void dispose() {
    super.dispose();
  }

}