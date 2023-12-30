import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:home_widget/home_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:todo/Utils/Colors.dart';
import 'package:todo/Widgets/Alert.dart';
import 'package:todo/screens/homeController.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool checkVal = false;

  int _counter = 0;

  @override
  void initState() {
    HomeWidget.widgetClicked.listen((Uri? uri) => loadData());
    WidgetsBinding.instance.addPostFrameCallback((_) => getData());

    loadAd();
    loadInterAd();
    super.initState();
  }

  var controller = Get.put(HomeController());

  getData() {
    var data = db.read("list");
    print("GetData: $data");
    if (data == null) {
      controller.list.value = [];
    } else {
      controller.list.value = data;
    }
    setState(() {});
  }

  saveData() {
    db.write("list", controller.list);
  }

  void loadData() async {
    await HomeWidget.getWidgetData<int>('_counter', defaultValue: 0)
        .then((value) {
      _counter = value!;
    });

    await HomeWidget.getWidgetData<String>("_tasks", defaultValue: "null")
        .then((val) {
      if (val != "null") {
        print("Tasks from Widget: $val");
      }
    });
    setState(() {});
  }

  Future<void> updateAppWidget({clear = false}) async {
    _counter++;
    await HomeWidget.saveWidgetData<int>('_counter', _counter);
    if (!clear) {
      var tempList = [];
      for (var task in controller.list) {
        if (task["isDone"] == false) {
          tempList.add(task);
        }
      }
      await HomeWidget.saveWidgetData<String>('_tasks', jsonEncode(tempList));
    } else {
      await HomeWidget.saveWidgetData<String>('_tasks', "null");
    }
    await HomeWidget.updateWidget(
        name: 'AppWidgetProvider', iOSName: 'AppWidgetProvider');
  }

  var db = GetStorage();
  FocusNode _focusNode = FocusNode();
  TextEditingController taskController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  onSubmit() {
    if(taskController.text.isNotEmpty){
      controller.list.add({"task": taskController.text, "isDone": false});
      saveData();
      updateAppWidget();
      taskController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Pallete.secondary,
        floatingActionButton: GestureDetector(
          onTap: () {
            if(controller.list.isNotEmpty){
              Alerts().clearAllDialog(() {
                setState(() {
                  controller.list.clear();
                  saveData();
                  updateAppWidget(clear: true);
                  Get.back();
                });
                if(_interstitialAd != null){
                  _interstitialAd?.show();
                }
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Pallete.primary,
                content: Text("No task to clear")));
            }
          },
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Pallete.primary)),
              child: Text(
                "Clear All",
                style: TextStyle(color: Pallete.primary),
              )),
        ),
        appBar: AppBar(
          title: Text(
            "todo life",
            style: TextStyle(fontSize: 20, color: Pallete.primary),
          ),
          backgroundColor: Pallete.secondary,
          elevation: 0,
          actions: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: (){
                  Share.share('It’ll help you achieve your goals and ambitions no matter how big or small, download the To Do Life app now for free.\nhttps://techicious.com');
                },
                child: Image.asset(
                      "assets/images/share.png",
                      height: 20,
                      width: 20,
                    ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 20),
              child: GestureDetector(
                    onTap: (){
                      Alerts().donateDialog(() {});
                    },
                    child: Icon(
                      Icons.info,
                      color: Pallete.primary,
                    ),
                  ),
            )
          ],
        ),
        bottomNavigationBar: _bannerAd != null
            ? SizedBox(
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              )
            : Container(),
        body: Container(
          height: Get.height,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children:[ 
                RefreshIndicator(
                onRefresh: () async {
                  await getData();
                },
                child: Obx(
                  () => ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.list.length + 1,
                    itemBuilder: (context, index) {
                      if (index < controller.list.length) {
                        var task = controller.list[index];
                        bool? isDone = task["isDone"] as bool;
                        return ListTile(
                          leading: Transform.scale(
                            scale: 1.3,
                            child: Checkbox(
                              value: isDone,
                              onChanged: (value) {
                                setState(() {
                                  controller.list[index]['isDone'] = value!;
                                  print(controller.list);
                                  saveData();
                                  updateAppWidget();
                                });
                              },
                              side: MaterialStateBorderSide.resolveWith(
                                (states) =>
                                    BorderSide(width: 1.0, color: Pallete.primary),
                              ),
                              activeColor: Pallete.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                            ),
                          ),
                          title: Text(
                            "${task["task"]}",
                            style: TextStyle(
                                fontSize: 16,
                                decoration:
                                    isDone! ? TextDecoration.lineThrough : null,
                                color: isDone! ? Pallete.primary : null),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: Get.width * 0.6,
                        child: Divider(
                          indent: 10,
                          endIndent: 10,
                          height: 5,
                          color: Pallete.primary,
                        ),
                      );
                    },
                  ),
                ),
              ),
              ListTile(
                          leading: Transform.scale(
                            scale: 1.3,
                            child: Checkbox(
                              value: false,
                              onChanged: (value) {},
                              side: MaterialStateBorderSide.resolveWith(
                                (states) =>
                                    BorderSide(width: 1.0, color: Pallete.primary),
                              ),
                              activeColor: Pallete.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                            ),
                          ),
                          title: TextField(
                            focusNode: _focusNode,
                            onSubmitted: (value) {
                              if(taskController.text.isNotEmpty){
                                onSubmit();
                                _scrollController.jumpTo(_scrollController.position.maxScrollExtent + 100);
                                _focusNode.requestFocus();
                              }
                            },
                            textInputAction: TextInputAction.done,
                            controller: taskController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Click & Write here",
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 97, 147, 246))),
                          ))
              ]
            ),
          ),
        ));
  }

  // Ad Blocks
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  InterstitialAd? _interstitialAd;
  bool _isInterstialAdLoaded = false;

  final _interstitialAdId = 'ca-app-pub-4375627503790957/5586412713'; // Testing 'ca-app-pub-3940256099942544/1033173712';

  final AdSize adSize = AdSize(width: 300, height: 50);

  final adUnitId = 'ca-app-pub-4375627503790957/4696018783'; // Testing - 'ca-app-pub-3940256099942544/6300978111'
     
  /// Loads a banner ad.
  void loadAd() {
    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          setState(() {
            _isLoaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    )..load();
  }

  /// Loads an interstitial ad.
  void loadInterAd() {
    InterstitialAd.load(
        adUnitId: _interstitialAdId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('InterstitialAd :  $ad loaded.');
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
