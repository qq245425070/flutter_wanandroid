class SystemItemBean{
  List<SystemItemBean> children;
  String name;
  int id;

  SystemItemBean.fromJson(Map<String,dynamic> json):
      name = json["name"],
      children = (json["children"] as List)?.map((e)=> e == null ? null : new SystemItemBean.fromJson(e))?.toList(),
      id = json["id"];

  @override
  String toString() {
    StringBuffer sb = new StringBuffer("{");
    sb.write("children = $children");
    sb.write(",");
    sb.write("name = $name");
    sb.write(",");
    sb.write("id = $id");
    sb.write("}");
    return sb.toString();
  }
}
