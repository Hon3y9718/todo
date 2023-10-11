import '../controller/clear_all_dialogue_controller.dart';
import 'package:get/get.dart';

/// A binding class for the ClearAllDialogueScreen.
///
/// This class ensures that the ClearAllDialogueController is created when the
/// ClearAllDialogueScreen is first loaded.
class ClearAllDialogueBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClearAllDialogueController());
  }
}
