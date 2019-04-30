class ArticleListBean{
  int offset;
  bool over;
  int pageCount;
  int size ;
  int total;
  int curPage;
  List datas;
  List<ArticleBean> articles;

  ArticleListBean.fromJson(Map<String, dynamic> json):
      offset = json["offset"],
      size = json["size"],
      pageCount = json["pageCount"],
      total = json["total"],
      curPage = json["curPage"],
      datas = json["datas"],
        over = json["over"]
  ;
}
class ArticleBean{
  String author;
  int chapterId;
  String chapterName;
  int courseId;
  String link;
  String niceDate;
  int superChapterId;
  String superChapterName;
  String title;
  int zan;
  ArticleBean.fromJson(Map<String,dynamic> json):
      author = json["author"],
      chapterId = json["chapterId"],
      chapterName = json["chapterName"],
      superChapterId = json["superChapterId"],
      superChapterName = json["superChapterName"],
      link = json["link"],
      title = json["title"],
      courseId = json["courseId"],
      niceDate = json["niceDate"],
      zan = json["zan"];
}