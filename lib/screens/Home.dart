import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:home_widget/home_widget.dart';
import 'package:todo/Utils/Colors.dart';
import 'package:todo/Widgets/Alert.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool checkVal = false;

  var list = [];

  int _counter = 0;

  @override
  void initState() {
    HomeWidget.widgetClicked.listen((Uri? uri) => loadData());
    WidgetsBinding.instance.addPostFrameCallback((_) => getData());

    loadAd();
    super.initState();
  }

  getData() {
    var data = db.read("list");
    print("GetData: $data");
    if (data == null) {
      list = [];
    } else {
      list = data;
    }
    setState(() {});
  }

  saveData() {
    db.write("list", list);
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
      await HomeWidget.saveWidgetData<String>('_tasks', jsonEncode(list));
    } else {
      await HomeWidget.saveWidgetData<String>('_tasks', "null");
    }
    await HomeWidget.updateWidget(
        name: 'AppWidgetProvider', iOSName: 'AppWidgetProvider');
  }

  var db = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.secondary,
      floatingActionButton: GestureDetector(
        onTap: () {
          Alerts().clearAllDialog(() {
            setState(() {
              list.clear();
              saveData();
              updateAppWidget(clear: true);
              Get.back();
            });
          });
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
          "To Do",
          style: TextStyle(fontSize: 20, color: Pallete.primary),
        ),
        backgroundColor: Pallete.secondary,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Alerts().donateDialog(() {});
              },
              icon: Icon(
                Icons.info,
                color: Pallete.primary,
              ))
        ],
      ),
      bottomNavigationBar: _bannerAd != null
          ? SizedBox(
              width: _bannerAd!.size.width.toDouble(),
              height: _bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            )
          : Container(),
      body: RefreshIndicator(
        onRefresh: () async {
          await getData();
        },
        child: ListView.separated(
          itemCount: list.length + 1,
          itemBuilder: (context, index) {
            if (index < list.length) {
              var task = list[index];
              bool? isDone = task["isDone"] as bool;
              return ListTile(
                leading: Transform.scale(
                  scale: 1.3,
                  child: Checkbox(
                    value: isDone,
                    onChanged: (value) {
                      setState(() {
                        list[index]['isDone'] = value!;
                        print(list);
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
                      decoration: isDone! ? TextDecoration.lineThrough : null,
                      color: isDone! ? Pallete.primary : null),
                ),
              );
            } else {
              return ListTile(
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
                    onSubmitted: (val) {
                      setState(() {
                        list.add({"task": val, "isDone": false});
                        saveData();
                        updateAppWidget();
                      });
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Click & Write here",
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 97, 147, 246))),
                  ));
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
    );
  }

  // Ad Blocks
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  final AdSize adSize = AdSize(width: 300, height: 50);

  // TODO: replace this test ad unit with your own ad unit.
  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

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
}
