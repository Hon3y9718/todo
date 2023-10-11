import '../controller/info_controller.dart';
import 'package:get/get.dart';

/// A binding class for the InfoScreen.
///
/// This class ensures that the InfoController is created when the
/// InfoScreen is first loaded.
class InfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InfoController());
  }
}
