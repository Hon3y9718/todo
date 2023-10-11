import 'package:umesh_kumar_s_application1/core/app_export.dart';
import 'package:umesh_kumar_s_application1/presentation/app_screen/models/app_model.dart';

/// A controller class for the AppScreen.
///
/// This class manages the state of the AppScreen, including the
/// current appModelObj
class AppController extends GetxController {
  Rx<AppModel> appModelObj = AppModel().obs;

  Rx<bool> takeacoldshower = false.obs;

  Rx<bool> clickwritehere = false.obs;
}
