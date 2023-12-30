import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:todo/Utils/Colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Alerts {
  clearAllDialog(onYes) {
    return showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Clear All",
                  style: TextStyle(
                      color: Pallete.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                // IconButton(
                //     onPressed: () {
                //       Get.back();
                //     },
                //     icon: Container(
                //       padding: EdgeInsets.all(3),
                //       decoration: BoxDecoration(
                //           color: Pallete.primary,
                //           borderRadius: BorderRadius.all(Radius.circular(20))),
                //       child: Icon(
                //         Icons.close_rounded,
                //         color: Pallete.secondary,
                //         size: 15,
                //       ),
                //     ))
              ],
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Are you sure?"),
              ],
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  button(
                      isFilled: true,
                      onTap: () {
                        onYes.call();
                      },
                      text: "Yes"),
                  SizedBox(
                    width: 10,
                  ),
                  button(
                      isFilled: false,
                      onTap: () {
                        Get.back();
                      },
                      text: "No"),
                ],
              ),
              SizedBox(
                height: 20,
              )
            ],
          );
        });
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  donateDialog(onTap) {
    return showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Info",
                  style: TextStyle(
                      color: Pallete.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            content: Container(
              height: Get.height * 0.20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("The actual to do widget you wanted."),
                  SizedBox(
                    height: 20,
                  ),
                  button(
                      isFilled: true,
                      text: "Donate & Support",
                      onTap: () {
                        // Copy UPI ID
                        Clipboard.setData(
                            ClipboardData(text: "devanshkumar@okhdfcbank"));

                        var snack = SnackBar(
                            content: Text(
                                "UPI ID is copied, please open any payment app and donate as per your wish"));
                        ScaffoldMessenger.of(Get.context!).showSnackBar(snack);
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "UPI ID: devanshkumar@okhdfcbank",
                    style: TextStyle(color: Pallete.primary),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      _launchUrl(
                          "https://www.freeprivacypolicy.com/live/605511f2-2c28-4bc1-8893-08273d98c16d");
                    },
                    child: Text(
                      "Privacy Policy",
                      style: TextStyle(color: Pallete.primary),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget button({isFilled, onTap, text}) {
    return GestureDetector(
      onTap: () {
        onTap.call();
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          decoration: BoxDecoration(
              color: isFilled ? Pallete.primary : null,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Pallete.primary)),
          child: Text(
            "$text",
            style: TextStyle(
                color: isFilled ? Pallete.secondary : Pallete.primary),
          )),
    );
  }
}
