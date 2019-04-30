import 'package:flutter/material.dart';
import 'package:rxdart_test/bean/ArticleListBean.dart';
import 'package:rxdart_test/bean/BannerBean.dart';
import 'package:rxdart_test/data/repository/wan_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:rxdart_test/public_ui/webview_page.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }

}
class _HomePage extends State<HomePage>{
  int bannerCount = 0;
  int itemCount = 0;
  List<BannerBean> data;
  RefreshController _refreshController;
  int page = 0;
  bool isOver = false,isShowFloatButton = false;
  List<ArticleBean> mArticleList;
  Future getBannerData()async{
    WanRepository().getBanner().then((list){
      bannerCount = list.length;
      data = list;
      setState(() {
      });
    });
  }
  Future getArticleData() async{
    WanRepository().getArticleList(page).then((data){
      mArticleList.addAll(data.articles);
      isOver = !data.over;
      itemCount = mArticleList.length;
      if(isOver){
        _refreshController.sendBack(false, RefreshStatus.idle);
      }else{
        _refreshController.sendBack(false, RefreshStatus.completed);
      }
      _refreshController.sendBack(true, RefreshStatus.completed);
      setState(() {
      });
    });
  }
  @override
  void initState() {
    super.initState();
    _refreshController = new RefreshController();
    //监听视图绘制完成的回调相当于onResume()
    WidgetsBinding.instance.addPostFrameCallback((callback){
      //如果监听每一帧结束 可以使用
      ////Adds a persistent frame callback
      ////持久帧的回调
      //addPersistentFrameCallback(FrameCallback callback) → void
      _refreshController.scrollController.addListener((){
        double offset = _refreshController.scrollController.offset;
        if(offset < 280 && isShowFloatButton){
          isShowFloatButton = false;
          setState(() {});
        }else if(offset > 280 && !isShowFloatButton){
          isShowFloatButton = true;
          setState(() { });
        }
      });
    });

    mArticleList = new List();
    getBannerData();
    getArticleData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new RefreshIndicator(
          child: new SmartRefresher(
              enablePullDown: false,
              enablePullUp: true,
              enableOverScroll: true,
              footerBuilder: (context, mode) {
                return new ClassicIndicator(mode: mode);
              },
              footerConfig: new LoadConfig(),
              controller: _refreshController,
              onRefresh: (up) {
                if(up) {
                  page = 0;
                  mArticleList.clear();
                  print("下拉刷新\n");
                }else{
                  print("上拉加载\n");
                  page ++;
                }
                return getArticleData();
              },
              child:ListView.separated(
                itemCount: bannerCount == 0 ? itemCount : 1 + itemCount,
                itemBuilder:(context , position){
                  if(position == 0) {
                    return Container(height: 200, color: Colors.transparent,child: getBanner(),);
                  }
                  return getArticleWidget(position-1);
                },
                separatorBuilder: (context,index){
                  return Container(height:1,color: Colors.grey[100],);
                },
              )
          ),
          onRefresh: () {
            page = 0;
            mArticleList.clear();
            print("下拉刷新");
            return getArticleData();
          }),
      floatingActionButton: builderFloatingButton(),
    );
  }

  Widget getArticleWidget(int position){
    return new InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder:(context){
          return WebViewPage(title: mArticleList[position].title,url: mArticleList[position].link,);
        }));
      },
      child:Column(
        children: <Widget>[
            Row(
             children: <Widget>[
               Expanded(
                 child:Container(
                   padding: EdgeInsets.all(15),
                   child: Text(mArticleList[position].title,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,),maxLines: 2, textAlign: TextAlign.left,),
                 ),
               ),
                Container(
                   padding: EdgeInsets.all(15),
                     child:Text(mArticleList[position].niceDate,textAlign: TextAlign.right,style: TextStyle(fontSize: 12),),
                 )
             ],
           ),
              Container(
                alignment: Alignment.centerLeft,
               padding: EdgeInsets.fromLTRB(15, 0, 0, 15),
               child: Text(mArticleList[position].author,style: TextStyle(color: Colors.blue,fontSize: 12),textAlign: TextAlign.left,),
             ),
        ],
      )
    );
  }

  Widget getItem(int position){
    return new Image.network(data[position].imagePath);
  }
  Widget getBanner(){
    return Swiper(
      itemCount: bannerCount,
      autoplay: true,
      pagination: SwiperPagination(),
      itemBuilder: (context,position){
        if(bannerCount == 0){
          return Container(color: Colors.green[100]);
        }else{
          return getBannerItem(position);
        }
      },
    );
  }
  Widget getBannerItem(int position){
    return InkWell(
      onTap: ()=>print(data[position].imagePath),
      child: Container(
        child: Image.network(
          data[position].imagePath,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget builderFloatingButton() {
    if(_refreshController.scrollController == null || _refreshController.scrollController.offset < 280){
      return null;
    }
    return FloatingActionButton(onPressed: (){
      _refreshController.scrollController.animateTo(0.0,
      duration: new Duration(milliseconds: 300), curve: Curves.linear);
    },
      child: Icon(Icons.arrow_upward),
    );

  }

  @override
  void dispose() {
    super.dispose();
//    _refreshController.scrollController.dispose();
  }
}