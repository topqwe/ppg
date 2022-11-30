import 'package:flex_grid/flex_grid.dart';
import 'package:loading_more_list/loading_more_list.dart';

class GridRow extends FlexGridRow {
  GridRow({required this.name});
  final String name;

  @override
  List<Object> get columns =>
      List<String>.generate(6, (int index) => 'Column:$index');

  // static List<String> cloumnNames = List<String>.generate(
  //     6, (int index) => index == 0 ? 'ID' : 'Header:$index');

  static List<String>  cloumnNames = ['C0','C1','C2',
  'C3','C4','C5'];

}

class FlexGridSource extends LoadingMoreBase<GridRow> {
  int _pageIndex = 0;

  void _load() {
    for (int i = 0; i < 9; i++) {
      add(GridRow(name: 'index:$_pageIndex-$i'));
    }
  }

  @override
  bool get hasMore => _pageIndex < 1;

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    await Future<void>.delayed(const Duration(seconds: 0));
    _load();
    _pageIndex++;
    return true;
  }

  @override
  Future<bool> refresh([bool notifyStateChanged = false]) async {
    _pageIndex = 0;
    return super.refresh(notifyStateChanged);
  }
}
