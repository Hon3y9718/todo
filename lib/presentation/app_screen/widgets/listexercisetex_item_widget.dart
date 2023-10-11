import '../controller/app_controller.dart';
import '../models/listexercisetex_item_model.dart';
import 'package:flutter/material.dart';
import 'package:umesh_kumar_s_application1/core/app_export.dart';

// ignore: must_be_immutable
class ListexercisetexItemWidget extends StatelessWidget {
  ListexercisetexItemWidget(
    this.listexercisetexItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  ListexercisetexItemModel listexercisetexItemModelObj;

  var controller = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.h),
      child: Row(
        children: [
          Container(
            height: 24.adaptSize,
            width: 24.adaptSize,
            padding: EdgeInsets.symmetric(
              horizontal: 6.h,
              vertical: 8.v,
            ),
            decoration: AppDecoration.outlineBlueA.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder8,
            ),
            child: CustomImageView(
              svgPath: ImageConstant.imgCheckmark,
              height: 7.v,
              width: 10.h,
              alignment: Alignment.topCenter,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16.h,
              top: 5.v,
              bottom: 3.v,
            ),
            child: Text(
              "lbl_exercise".tr,
              style: theme.textTheme.bodySmall!.copyWith(
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
