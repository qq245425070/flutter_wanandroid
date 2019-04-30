class BannerBean{
  String desc;
  int id;
  String imagePath;
  int isVisible;
  int type;
  String title;
  String url;

  BannerBean(this.desc,this.id,this.imagePath,this.isVisible,this.type,this.title,this.url);

  BannerBean.fromJson(Map<String, dynamic> json)
       : title = json['title'],
        desc = json['desc'],
        id = json['id'],
        url = json['url'],
        imagePath = json['imagePath'],
        type = json['type'],
        isVisible = json['isVisible'];

  Map<String, dynamic> toJson() => {
    'desc': desc,
    'title': title,
    'id': id,
    'imagePath': imagePath,
    'url': url,
    'type': type,
    'isVisible': isVisible,
  };

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write("\"title\":\"$title\"");
    sb.write(",\"id\":$id");
    sb.write(",\"url\":\"$url\"");
    sb.write(",\"imagePath\":\"$imagePath\"");
    sb.write('}');
    return sb.toString();
  }
}