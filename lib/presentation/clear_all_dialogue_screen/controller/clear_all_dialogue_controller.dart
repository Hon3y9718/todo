import 'package:umesh_kumar_s_application1/core/app_export.dart';
import 'package:umesh_kumar_s_application1/presentation/clear_all_dialogue_screen/models/clear_all_dialogue_model.dart';
import 'package:flutter/material.dart';

/// A controller class for the ClearAllDialogueScreen.
///
/// This class manages the state of the ClearAllDialogueScreen, including the
/// current clearAllDialogueModelObj
class ClearAllDialogueController extends GetxController {
  TextEditingController exercisevalueController = TextEditingController();

  TextEditingController clearalloneController = TextEditingController();

  Rx<ClearAllDialogueModel> clearAllDialogueModelObj =
      ClearAllDialogueModel().obs;

  Rx<bool> clickwritehere = false.obs;

  @override
  void onClose() {
    super.onClose();
    exercisevalueController.dispose();
    clearalloneController.dispose();
  }
}
