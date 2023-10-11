import '../controller/app_controller.dart';
import 'package:get/get.dart';

/// A binding class for the AppScreen.
///
/// This class ensures that the AppController is created when the
/// AppScreen is first loaded.
class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppController());
  }
}
