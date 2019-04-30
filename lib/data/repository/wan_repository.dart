
import 'package:rxdart_test/bean/ArticleListBean.dart';
import 'package:rxdart_test/bean/BannerBean.dart';
import 'package:rxdart_test/bean/ProjectTree.dart';
import 'package:rxdart_test/bean/project_list.dart';
import 'package:rxdart_test/bean/system_bean.dart';
import 'package:rxdart_test/common/common.dart';
import 'package:rxdart_test/data/api/apis.dart';
import 'package:rxdart_test/data/net/dio_util.dart';

class WanRepository {
  Future<List<BannerBean>> getBanner() async {
    BaseResp<List> baseResp = await DioUtil().request<List>(
        Method.get, WanAndroidApi.getPath(path: WanAndroidApi.BANNER));
    List<BannerBean> bannerList;
    if (baseResp.code != Constant.STATUS_SUCCESS) {
      return new Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      bannerList = baseResp.data.map((value) {
        return BannerBean.fromJson(value);
      }).toList();
    }
    return bannerList;
  }
  Future<ArticleListBean> getArticleList(int page) async{
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil().request<Map<String, dynamic>>(Method.get, WanAndroidApi.getPath(
        path: WanAndroidApi.ARTICLE_LISTPROJECT, page: page));
    if(baseResp.code != Constant.STATUS_SUCCESS){
      return Future.error(baseResp.msg);
    }
    ArticleListBean listBean;
    if(baseResp.data != null){
      listBean = ArticleListBean.fromJson(baseResp.data);
      listBean.articles = listBean.datas.map((value){
        return ArticleBean.fromJson(value);
      }).toList();
    }
    return listBean;
  }

  Future<List<ProjectTreeBean>> getProjectTree()async{
    BaseResp<List> baseResp = await DioUtil().request<List>(Method.get, WanAndroidApi.getPath(path:WanAndroidApi.PROJECT_TREE,page: null));
    if(baseResp.code != Constant.STATUS_SUCCESS){
      return Future.error(baseResp.msg);
    }
    List<ProjectTreeBean> projectList;
    if(baseResp.data != null){
      projectList = baseResp.data.map((value){
        return ProjectTreeBean.fromJson(value);
      }).toList();
    }
    return projectList;
  }

  Future<ProjectList> getProject(int page,Map<String,dynamic> data) async{
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil().request<Map<String, dynamic>>(Method.get,
        WanAndroidApi.getPath(page: page,path:WanAndroidApi.PROJECT_LIST),data: data);
    if(baseResp.code != Constant.STATUS_SUCCESS){
      return Future.error(baseResp.msg);
    }
    ProjectList projectList ;
    if(baseResp.data != null){
      projectList = ProjectList.fromJson(baseResp.data);
      projectList.projects = projectList.datas.map((value){return ProjectBean.fromJson(value);}).toList();
    }
    return projectList;
  }

  Future<List<SystemItemBean>> getSystemList() async{
    BaseResp<List> baseResp = await DioUtil().request<List>(Method.get, WanAndroidApi.getPath(path: WanAndroidApi.TREE));
    if(baseResp.code != Constant.STATUS_SUCCESS){
      return Future.error(baseResp.msg);
    }
    List<SystemItemBean> systemList;
    if(baseResp.data != null){
      systemList = baseResp.data.map((json){
        return SystemItemBean.fromJson(json);
      }).toList();
    }
    return systemList;
  }

  Future<ArticleListBean> getArticleListByCategory(int page,Map<String,dynamic> data) async{
    BaseResp<Map<String,dynamic>> baseResp = await DioUtil().request<Map<String,dynamic>>(Method.get,
        WanAndroidApi.getPath(path: WanAndroidApi.ARTICLE_LIST,page: page),data: data);
    if(baseResp.code != Constant.STATUS_SUCCESS){
      return Future.error(baseResp.msg);
    }
    ArticleListBean bean;
    if(baseResp.data != null){
      bean = ArticleListBean.fromJson(baseResp.data);
      bean.articles = bean.datas.map((json)=>ArticleBean.fromJson(json)).toList();
    }
    return bean;
  }

  Future<List<SystemItemBean>> getWXChapters()async{
    BaseResp<List> baseResp = await DioUtil().request<List>(Method.get, WanAndroidApi.getPath(path: WanAndroidApi.WXARTICLE_CHAPTERS));
    if(baseResp.code != Constant.STATUS_SUCCESS){
      return Future.error(baseResp.msg);
    }
    List<SystemItemBean> systemList;
    if(baseResp.data != null){
      systemList = baseResp.data.map((value)=>SystemItemBean.fromJson(value)).toList();
    }
    return systemList;
  }

  Future<ArticleListBean> getWxArticle(int page,int id) async{
    BaseResp<Map<String,dynamic>> baseResp = await DioUtil().request(Method.get, WanAndroidApi.getPath(path: WanAndroidApi.WXARTICLE_LIST+"/$id",page: page));
    if(baseResp.code != Constant.STATUS_SUCCESS){
      return Future.error(baseResp.msg);
    }
    ArticleListBean bean;
    if(baseResp.data != null){
      bean = ArticleListBean.fromJson(baseResp.data);
      bean.articles = bean.datas.map((value)=>ArticleBean.fromJson(value)).toList();
    }
    return bean;
  }


//
//  Future<List<ReposModel>> getArticleListProject(int page) async {
//    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
//        .request<Map<String, dynamic>>(
//            Method.get,
//            WanAndroidApi.getPath(
//                path: WanAndroidApi.ARTICLE_LISTPROJECT, page: page));
//    List<ReposModel> list;
//    if (baseResp.code != Constant.STATUS_SUCCESS) {
//      return new Future.error(baseResp.msg);
//    }
//    if (baseResp.data != null) {
//      ComData comData = ComData.fromJson(baseResp.data);
//      list = comData.datas.map((value) {
//        return ReposModel.fromJson(value);
//      }).toList();
//    }
//    return list;
//  }
//
//  Future<List<ReposModel>> getArticleList({int page, data}) async {
//    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
//        .request<Map<String, dynamic>>(Method.get,
//            WanAndroidApi.getPath(path: WanAndroidApi.ARTICLE_LIST, page: page),
//            data: data);
//    List<ReposModel> list;
//    if (baseResp.code != Constant.STATUS_SUCCESS) {
//      return new Future.error(baseResp.msg);
//    }
//    if (baseResp.data != null) {
//      ComData comData = ComData.fromJson(baseResp.data);
//      list = comData.datas.map((value) {
//        return ReposModel.fromJson(value);
//      }).toList();
//    }
//    return list;
//  }
//
//  Future<List<TreeModel>> getTree() async {
//    BaseResp<List> baseResp = await DioUtil().request<List>(
//        Method.get, WanAndroidApi.getPath(path: WanAndroidApi.TREE));
//    List<TreeModel> treeList;
//    if (baseResp.code != Constant.STATUS_SUCCESS) {
//      return new Future.error(baseResp.msg);
//    }
//    if (baseResp.data != null) {
//      treeList = baseResp.data.map((value) {
//        return TreeModel.fromJson(value);
//      }).toList();
//    }
//    return treeList;
//  }
//
//  Future<List<ReposModel>> getProjectList({int page: 1, data}) async {
//    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
//        .request<Map<String, dynamic>>(Method.get,
//            WanAndroidApi.getPath(path: WanAndroidApi.PROJECT_LIST, page: page),
//            data: data);
//    List<ReposModel> list;
//    if (baseResp.code != Constant.STATUS_SUCCESS) {
//      return new Future.error(baseResp.msg);
//    }
//    if (baseResp.data != null) {
//      ComData comData = ComData.fromJson(baseResp.data);
//      list = comData.datas.map((value) {
//        return ReposModel.fromJson(value);
//      }).toList();
//    }
//    return list;
//  }
//
//  Future<List<ReposModel>> getWxArticleList({int id, int page: 1, data}) async {
//    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
//        .request<Map<String, dynamic>>(
//            Method.get,
//            WanAndroidApi.getPath(
//                path: WanAndroidApi.WXARTICLE_LIST + '/$id', page: page),
//            data: data);
//    List<ReposModel> list;
//    if (baseResp.code != Constant.STATUS_SUCCESS) {
//      return new Future.error(baseResp.msg);
//    }
//    if (baseResp.data != null) {
//      ComData comData = ComData.fromJson(baseResp.data);
//      list = comData.datas.map((value) {
//        return ReposModel.fromJson(value);
//      }).toList();
//    }
//    return list;
//  }
//
//  Future<List<TreeModel>> getWxArticleChapters() async {
//    BaseResp<List> baseResp = await DioUtil().request<List>(Method.get,
//        WanAndroidApi.getPath(path: WanAndroidApi.WXARTICLE_CHAPTERS));
//    List<TreeModel> treeList;
//    if (baseResp.code != Constant.STATUS_SUCCESS) {
//      return new Future.error(baseResp.msg);
//    }
//    if (baseResp.data != null) {
//      treeList = baseResp.data.map((value) {
//        return TreeModel.fromJson(value);
//      }).toList();
//    }
//    return treeList;
//  }
//
//  Future<List<TreeModel>> getProjectTree() async {
//    BaseResp<List> baseResp = await DioUtil().request<List>(
//        Method.get, WanAndroidApi.getPath(path: WanAndroidApi.PROJECT_TREE));
//    List<TreeModel> treeList;
//    if (baseResp.code != Constant.STATUS_SUCCESS) {
//      return new Future.error(baseResp.msg);
//    }
//    if (baseResp.data != null) {
//      treeList = baseResp.data.map((value) {
//        return TreeModel.fromJson(value);
//      }).toList();
//    }
//    return treeList;
//  }
}
