import '../../../core/app_export.dart';
import 'listexercisetex_item_model.dart';

/// This class defines the variables used in the [app_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class AppModel {
  Rx<List<ListexercisetexItemModel>> listexercisetexItemList =
      Rx(List.generate(1, (index) => ListexercisetexItemModel()));
}
