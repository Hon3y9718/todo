import 'package:umesh_kumar_s_application1/core/app_export.dart';
import 'package:umesh_kumar_s_application1/presentation/info_screen/models/info_model.dart';
import 'package:flutter/material.dart';

/// A controller class for the InfoScreen.
///
/// This class manages the state of the InfoScreen, including the
/// current infoModelObj
class InfoController extends GetxController {
  TextEditingController exercisevalueController = TextEditingController();

  TextEditingController infovalueoneController = TextEditingController();

  Rx<InfoModel> infoModelObj = InfoModel().obs;

  Rx<bool> clickwritehere = false.obs;

  @override
  void onClose() {
    super.onClose();
    exercisevalueController.dispose();
    infovalueoneController.dispose();
  }
}
