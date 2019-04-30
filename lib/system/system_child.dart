import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart_test/bean/ArticleListBean.dart';
import 'package:rxdart_test/bean/project_list.dart';
import 'package:rxdart_test/data/repository/wan_repository.dart';
import 'package:rxdart_test/main/article_widget.dart';
class SystemChildPage extends StatefulWidget{
  int cid;
  @override
  State<StatefulWidget> createState() {
    return SystemChildState();
  }

  SystemChildPage(this.cid);
}
class SystemChildState extends State<SystemChildPage>{
  List<ArticleBean> mData = [];
  int page = 0;
  Map<String,dynamic> data;
  bool hasMore = true;
  RefreshController _refreshController;
  bool isShow = false;
  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    CategoryBean bean = CategoryBean(widget.cid);
    data = bean.toJson();
    getArticle();
    WidgetsBinding.instance.addPostFrameCallback((callback){
      _refreshController.scrollController.addListener((){
        double offset = _refreshController.scrollController.offset;
        if(offset < 200 && isShow){
          isShow = false;
          setState((){});
        }
        if(offset > 200 && !isShow){
          isShow = true;
          setState((){});
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildFloatingButton(),
      body: SmartRefresher(
        enablePullUp: hasMore,
        enablePullDown: false,
        enableOverScroll: true,
        onRefresh: (up){
          if(!up){
            page++;
            getArticle();
          }
        },
        controller: _refreshController,
        footerBuilder: (config,mode){
          return ClassicIndicator(mode: mode,);
        },
        footerConfig: LoadConfig(),
        child: ListView.separated(itemBuilder: (context,index)=> ArticleWidget(mData[index]),
            separatorBuilder: (context,index){
              return Container(height: 1,color: Colors.black12,);
              },
            itemCount: mData.length),
      ),
    );
  }
  Widget buildFloatingButton(){
    if(!isShow){
      return null;
    }
    return FloatingActionButton(
      onPressed: (){
        _refreshController.scrollController.animateTo(0, duration: Duration(milliseconds: 500 ), curve: Curves.linear);
      },
      child: Icon(Icons.arrow_upward),
    );
  }

  Future getArticle() async{
    WanRepository().getArticleListByCategory(page, data).then((value){
      mData.addAll(value.articles);
      hasMore = !value.over;
      _refreshController.sendBack(false, RefreshStatus.idle);
      setState(() {});
    });
  }

}