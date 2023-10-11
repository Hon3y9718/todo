import '../app_screen/widgets/listexercisetex_item_widget.dart';
import 'controller/app_controller.dart';
import 'models/listexercisetex_item_model.dart';
import 'package:flutter/material.dart';
import 'package:umesh_kumar_s_application1/core/app_export.dart';
import 'package:umesh_kumar_s_application1/widgets/custom_checkbox_button.dart';
import 'package:umesh_kumar_s_application1/widgets/custom_elevated_button.dart';
import 'package:umesh_kumar_s_application1/widgets/custom_outlined_button.dart';

// ignore_for_file: must_be_immutable
class AppScreen extends GetWidget<AppController> {
  const AppScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: Padding(
          padding: EdgeInsets.only(top: 16.v),
          child: Obx(
            () => ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (
                context,
                index,
              ) {
                return Divider(
                  height: 1.v,
                  thickness: 1.v,
                  color: appTheme.blueA100,
                  indent: 16.h,
                  endIndent: 16.h,
                );
              },
              itemCount: controller
                  .appModelObj.value.listexercisetexItemList.value.length,
              itemBuilder: (context, index) {
                ListexercisetexItemModel model = controller
                    .appModelObj.value.listexercisetexItemList.value[index];
                return ListexercisetexItemWidget(
                  model,
                );
              },
            ),
          ),
        ),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 8.v),
                  child: Divider(
                    indent: 16.h,
                    endIndent: 16.h,
                  ),
                ),
              ),
              Obx(
                () => CustomCheckboxButton(
                  text: "msg_take_a_cold_shower".tr,
                  value: controller.takeacoldshower.value,
                  margin: EdgeInsets.only(
                    left: 16.h,
                    top: 8.v,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 4.v),
                  textStyle: CustomTextStyles.bodySmallOnPrimary,
                  onChange: (value) {
                    controller.takeacoldshower.value = value;
                  },
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 8.v),
                  child: Divider(
                    indent: 16.h,
                    endIndent: 16.h,
                  ),
                ),
              ),
              Obx(
                () => CustomCheckboxButton(
                  text: "msg_click_write_here".tr,
                  value: controller.clickwritehere.value,
                  margin: EdgeInsets.only(
                    left: 16.h,
                    top: 8.v,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 4.v),
                  textStyle: CustomTextStyles.bodySmallBlueA100,
                  onChange: (value) {
                    controller.clickwritehere.value = value;
                  },
                ),
              ),
              CustomOutlinedButton(
                width: 122.h,
                text: "lbl_clear_all".tr,
                margin: EdgeInsets.only(
                  top: 550.v,
                  right: 16.h,
                ),
                alignment: Alignment.centerRight,
              ),
              SizedBox(height: 16.v),
              CustomElevatedButton(
                text: "lbl_advertisement".tr,
                buttonStyle: CustomButtonStyles.none,
                decoration: CustomButtonStyles.gradientOrangeToPurpleDecoration,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
