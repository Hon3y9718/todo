import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:home_widget/home_widget.dart';

import 'screens/Home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  HomeWidget.registerBackgroundCallback(backgroundCallback);
  runApp(MyApp());
}

// Called when Doing Background Work initiated from Widget
backgroundCallback(Uri? uri) async {
  int _counter = 0;
  var db = GetStorage();
  var tasks;
  if (uri!.host.contains("tasks")) {
    await HomeWidget.getWidgetData<String>('_tasks', defaultValue: "null")
        .then((value) async {
      if (value != "null") {
        var json = jsonDecode(value!);

        var index = int.parse(uri!.queryParameters["index"]!);
        var isDone = uri!.queryParameters["isDone"];
        print("isDone: $isDone, ${isDone.runtimeType}");
        if (isDone == "true") {
          json[index]["isDone"] = false;
        } else {
          json[index]["isDone"] = true;
        }
        db.write("list", json);
        print("WidgetData: $json");

        await HomeWidget.saveWidgetData<String>('_tasks', jsonEncode(json));
        await HomeWidget.updateWidget(
            name: 'AppWidgetProvider', iOSName: 'AppWidgetProvider');
      }
    });
  }
  if (uri!.host == 'updatecounter') {
    await HomeWidget.getWidgetData<int>('_counter', defaultValue: 0)
        .then((value) {
      _counter = value!;
      _counter++;
    });
    await HomeWidget.saveWidgetData<int>('_counter', _counter);
    await HomeWidget.updateWidget(
        name: 'AppWidgetProvider', iOSName: 'AppWidgetProvider');
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
