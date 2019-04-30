class BaseBean<T>{
  int errorCode;
  String errorMsg;
  T data;
  BaseBean(this.errorCode,this.errorMsg,this.data);

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write(",\"code\":$errorCode");
    sb.write(",\"msg\":\"$errorMsg\"");
    sb.write(",\"data\":\"$data\"");
    sb.write('}');
    return sb.toString();
  }
}
