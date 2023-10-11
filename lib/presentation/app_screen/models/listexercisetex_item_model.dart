import '../../../core/app_export.dart';

/// This class is used in the [listexercisetex_item_widget] screen.
class ListexercisetexItemModel {
  ListexercisetexItemModel({this.id}) {
    id = id ?? Rx("");
  }

  Rx<String>? id;
}
