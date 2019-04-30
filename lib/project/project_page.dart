import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart_test/bean/project_list.dart';
import 'package:rxdart_test/data/repository/wan_repository.dart';
import 'package:rxdart_test/public_ui/webview_page.dart';
class ProjectPage extends StatefulWidget{
  int id;
  @override
  State<StatefulWidget> createState() {
    return _ProjectState();
  }

  ProjectPage(this.id);
}
class _ProjectState extends State<ProjectPage>{
  List<ProjectBean> mProjectList;
  RefreshController _refreshController;
  int page;
  CategoryBean cid;
  bool isOver = true;
  bool isShowFloatingButton = false;
  @override
  void initState() {
    super.initState();
    _refreshController = new RefreshController();
    mProjectList = new List();
    cid = CategoryBean(widget.id);
    page = 0;
    getProject();
    WidgetsBinding.instance.addPostFrameCallback((callback){
      _refreshController.scrollController.addListener((){
        double offset = _refreshController.scrollController.offset;
        if(offset < 280 && isShowFloatingButton){
          isShowFloatingButton = false;
          setState(() {});
        }
        if(offset > 280 && !isShowFloatingButton){
          isShowFloatingButton = true;
          setState(() {});
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: buildFloatingButton(),
      body: RefreshIndicator(
          child: SmartRefresher(
              enablePullDown: false,
              enablePullUp: isOver,
              onRefresh: (up){
                if(!up){
                  page++;
                  print("上拉加载更多");
                  return getProject();
                }
              },
              footerBuilder:(context,mode){
                return ClassicIndicator(mode: mode,);
              } ,
              footerConfig: LoadConfig(),
              controller: _refreshController,
              child: ListView.separated(
                  itemBuilder: builderItem,
                  separatorBuilder: (context,position){
                    return Container(height: 0,color: Colors.green[100],);},
                  itemCount: mProjectList == null ? 0 : mProjectList.length
              ),
          ),
          onRefresh: (){
            page = 0;
            mProjectList.clear();
            return getProject();
          }
      ),
    );
  }

  Future getProject() async{
    WanRepository().getProject(page, cid.toJson()).then((value){
      mProjectList.addAll(value.projects);
      isOver = !value.over;
      if(isOver){
        _refreshController.sendBack(false, RefreshStatus.idle);
      }else{
        _refreshController.sendBack(false, RefreshStatus.completed);
      }
      _refreshController.sendBack(true, RefreshStatus.completed);
      setState(() {});
    });
  }

  Widget buildFloatingButton(){
    if(isShowFloatingButton){
      return FloatingActionButton(
        onPressed: (){
          _refreshController.scrollController.animateTo(
              0, duration: Duration(milliseconds: 500 ), curve: Curves.easeInOut);
        },
        child: Icon(Icons.arrow_upward),
      );
    }else{
      return null;
    }
  }


  Widget builderItem(BuildContext context, int position) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return WebViewPage(title: mProjectList[position].title,url: mProjectList[position].link,);
        }));
      },
      child:Container(
        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child:  Card(
          elevation: 6,
            child:Container(
              color: Colors.white,
              child:   Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  mProjectList[position].title,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF3D4E5F),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  mProjectList[position].desc,
                                  style: TextStyle(fontSize: 12, color: Colors.grey),
                                  textAlign: TextAlign.left,
                                  maxLines: 3,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                mProjectList[position].author,
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              Text(
                                mProjectList[position].niceDate,
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),

                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
                      child: Image.network(
                        mProjectList[position].envelopePic,
                        width: 80,
                        height: 120,
                        fit: BoxFit.fill,
                      )),
                ],
              ) ,
            )
        ),
      )
    );
  }
}