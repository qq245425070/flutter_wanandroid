class ProjectList{
  int curpage;
  List datas;
  bool over;
  List<ProjectBean> projects;
  ProjectList.fromJson(Map<String,dynamic> json):
      curpage = json["curpage"],
      over = json["over"],
      datas = json["datas"]
  ;
}
class CategoryBean{
  int cid;

  CategoryBean(this.cid);

  Map<String,dynamic> toJson()=>{"cid":cid};
}
class ProjectBean{
  String link;
  String title;
  String desc;
  String author;
  String niceDate;
  String envelopePic;
  ProjectBean.fromJson(Map<String,dynamic> json):
      link = json["link"],
      title = json["title"],
      desc = json["desc"],
      author = json["author"],
      niceDate = json["niceDate"],
      envelopePic = json["envelopePic"]
  ;
}