/**
 * @Name:请求列表父类实现
 * @Desc:
 * @Author: Tony
 */
// part of httpplugin;

mixin PagingMixin<T> {
  int pageSize = 10;
  int page = 1;

  List<T> data = [];
  bool get hasMoreData => data.length % pageSize == 0 || data.isEmpty;

  Future dataRefresh(){
    return Future.value();
  }

  Future loadMore(){
    return Future.value();
  }
}