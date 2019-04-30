class ProjectTreeBean{
  int id;
  String name;
  ProjectTreeBean.fromJson(Map<String,dynamic> json):
      id = json["id"],
      name = json["name"];
  @override
  String toString() {
    StringBuffer sb = new StringBuffer("{");
    sb.write("id = $id");
    sb.write(",");
    sb.write("name = $name");
    sb.write("}");
    return sb.toString();
  }
}