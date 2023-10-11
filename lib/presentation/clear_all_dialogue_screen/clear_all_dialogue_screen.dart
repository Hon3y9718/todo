import 'controller/clear_all_dialogue_controller.dart';
import 'package:flutter/material.dart';
import 'package:umesh_kumar_s_application1/core/app_export.dart';
import 'package:umesh_kumar_s_application1/widgets/custom_checkbox_button.dart';
import 'package:umesh_kumar_s_application1/widgets/custom_elevated_button.dart';
import 'package:umesh_kumar_s_application1/widgets/custom_outlined_button.dart';
import 'package:umesh_kumar_s_application1/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class ClearAllDialogueScreen extends GetWidget<ClearAllDialogueController> {
  const ClearAllDialogueScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          height: 759.v,
          width: double.maxFinite,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.h, 8.v, 16.h, 56.v),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        controller: controller.exercisevalueController,
                        hintText: "lbl_exercise".tr,
                        prefix: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.h,
                            vertical: 6.v,
                          ),
                          margin: EdgeInsets.only(right: 16.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              4.h,
                            ),
                            border: Border.all(
                              color: appTheme.blueA700,
                              width: 1.h,
                            ),
                          ),
                          child: CustomImageView(
                            svgPath: ImageConstant.imgCheckmarkBlueA700,
                          ),
                        ),
                        prefixConstraints: BoxConstraints(
                          maxHeight: 33.v,
                        ),
                      ),
                      SizedBox(height: 8.v),
                      Row(
                        children: [
                          Container(
                            height: 24.adaptSize,
                            width: 24.adaptSize,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                4.h,
                              ),
                              border: Border.all(
                                color: appTheme.blueA700,
                                width: 1.h,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 16.h,
                              top: 4.v,
                              bottom: 4.v,
                            ),
                            child: Text(
                              "msg_take_a_cold_shower2".tr,
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.v),
                      Divider(
                        color: appTheme.blueA700,
                      ),
                      SizedBox(height: 8.v),
                      Obx(
                        () => CustomCheckboxButton(
                          text: "msg_click_write_here".tr,
                          value: controller.clickwritehere.value,
                          padding: EdgeInsets.symmetric(vertical: 4.v),
                          onChange: (value) {
                            controller.clickwritehere.value = value;
                          },
                        ),
                      ),
                      Spacer(),
                      CustomOutlinedButton(
                        width: 122.h,
                        text: "lbl_clear_all".tr,
                        buttonStyle: CustomButtonStyles.outlineBlueATL4,
                        alignment: Alignment.centerRight,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: AppDecoration.fillBlack,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Spacer(),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16.h),
                        decoration: AppDecoration.outlineBlack.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder8,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomTextFormField(
                              controller: controller.clearalloneController,
                              hintText: "lbl_clear_all2".tr,
                              hintStyle: theme.textTheme.titleSmall!,
                              textInputAction: TextInputAction.done,
                              suffix: Container(
                                margin:
                                    EdgeInsets.fromLTRB(30.h, 12.v, 16.h, 12.v),
                                child: CustomImageView(
                                  svgPath: ImageConstant.imgClose,
                                ),
                              ),
                              suffixConstraints: BoxConstraints(
                                maxHeight: 41.v,
                              ),
                              contentPadding: EdgeInsets.only(
                                left: 30.h,
                                top: 12.v,
                                bottom: 12.v,
                              ),
                              borderDecoration:
                                  TextFormFieldStyleHelper.fillWhiteA,
                              filled: true,
                              fillColor: appTheme.whiteA70001,
                            ),
                            SizedBox(height: 32.v),
                            Text(
                              "lbl_are_you_sure".tr,
                              style: CustomTextStyles.bodySmallOnPrimary,
                            ),
                            SizedBox(height: 15.v),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomOutlinedButton(
                                  width: 88.h,
                                  text: "lbl_yes".tr,
                                  buttonStyle:
                                      CustomButtonStyles.outlineBlueATL8,
                                  buttonTextStyle:
                                      CustomTextStyles.bodySmallWhiteA700,
                                ),
                                CustomOutlinedButton(
                                  width: 82.h,
                                  text: "lbl_no".tr,
                                  margin: EdgeInsets.only(left: 32.h),
                                  buttonTextStyle:
                                      CustomTextStyles.bodySmallOnPrimary_1,
                                ),
                              ],
                            ),
                            SizedBox(height: 32.v),
                          ],
                        ),
                      ),
                      SizedBox(height: 275.v),
                      CustomElevatedButton(
                        text: "lbl_advertisement".tr,
                        buttonStyle: CustomButtonStyles.none,
                        decoration:
                            CustomButtonStyles.gradientOrangeToPurpleDecoration,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
