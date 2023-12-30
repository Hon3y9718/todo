package com.devansh.todo

import android.annotation.SuppressLint
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.os.Build
import android.util.Log
import android.widget.ArrayAdapter
import android.widget.RemoteViews
import androidx.annotation.RequiresApi
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider
import org.json.JSONArray
import org.json.JSONObject


class AppWidgetProvider : HomeWidgetProvider() {
    @RequiresApi(Build.VERSION_CODES.Q)
    @SuppressLint("ResourceType")
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.app_widget).apply {

                // Open App on Widget Click
                val pendingIntent = HomeWidgetLaunchIntent.getActivity(context,
                        MainActivity::class.java)
                setOnClickPendingIntent(R.id.widget_root, pendingIntent)

                setOnClickPendingIntent(R.id.task1Image, pendingIntent)
                setOnClickPendingIntent(R.id.task1, pendingIntent)
                setOnClickPendingIntent(R.id.task2Image, pendingIntent)
                setOnClickPendingIntent(R.id.task2, pendingIntent)
                setOnClickPendingIntent(R.id.task3Image, pendingIntent)
                setOnClickPendingIntent(R.id.task3, pendingIntent)
                setOnClickPendingIntent(R.id.task4Image, pendingIntent)
                setOnClickPendingIntent(R.id.task4, pendingIntent)

                val counter = widgetData.getInt("_counter", 0)

                var taskList = widgetData.getString("_tasks", "null")

//                fun changeImage(): RemoteViews.RemoteResponse {
//                    var isDone = false
//                    if(isDone){
//                        setImageViewResource(R.id.task1Image, R.drawable.done)
//                        isDone = false
//                    } else {
//                        setImageViewResource(R.id.task1Image, R.drawable.undone)
//                        isDone = true
//                    }
//                    return RemoteViews.RemoteResponse()
//                }

                if (taskList == "null") {
                    val noTaskText = "You don't have any task!"
                    setTextViewText(R.id.tv_counter, noTaskText)
                    setTextViewText(R.id.task1, "")
                    setTextViewText(R.id.task2, "")
                    setTextViewText(R.id.task3, "")
                    setTextViewText(R.id.task4, "")

                    setImageViewResource(R.id.task1Image, android.R.color.transparent)
                    setImageViewResource(R.id.task2Image, android.R.color.transparent)
                    setImageViewResource(R.id.task3Image, android.R.color.transparent)
                    setImageViewResource(R.id.task4Image, android.R.color.transparent)
                }
                else {
                    val jsonList = JSONArray(taskList)
                    Log.v("Widget Logs", "Widget Logs: $taskList, ${jsonList[0]}")
                    var count = 0;
                    if(jsonList.length() < 1){
                        setTextViewText(R.id.task1, "")
                        setTextViewText(R.id.task2, "")
                        setTextViewText(R.id.task3, "")
                        setTextViewText(R.id.task4, "")

                        setImageViewResource(R.id.task1Image, android.R.color.transparent)
                        setImageViewResource(R.id.task2Image, android.R.color.transparent)
                        setImageViewResource(R.id.task3Image, android.R.color.transparent)
                        setImageViewResource(R.id.task4Image, android.R.color.transparent)
                    } else {
                        for (i in 0 until jsonList.length()) {
                            var task = jsonList.getJSONObject(i)
                            if (count < 4) {
                                if (count == 0) {
                                    setTextViewText(R.id.task1, task.get("task").toString())
                                    val isDone = task.get("isDone")
                                    if (isDone == true) {
                                        setImageViewResource(R.id.task1Image, R.drawable.done)
                                    } else {
                                        setImageViewResource(R.id.task1Image, R.drawable.undone)
                                    }

                                    // Pending intent to update counter on button click
//                                    val taskIntent = HomeWidgetBackgroundIntent.getBroadcast(context,
//                                        Uri.parse("myAppWidget://tasks?index=$i&isDone=${isDone}"))
//                                    setOnClickPendingIntent(R.id.task1Image, taskIntent)
//                                    setOnClickPendingIntent(R.id.task1, taskIntent)

                                } else if (count == 1) {
                                    setTextViewText(R.id.task2, task.get("task").toString())
                                    val isDone = task.get("isDone")
                                    if (isDone == true) {
                                        setImageViewResource(R.id.task2Image, R.drawable.done)
                                    } else {
                                        setImageViewResource(R.id.task2Image, R.drawable.undone)
                                    }

                                    // Pending intent to update counter on button click
//                                    val taskIntent = HomeWidgetBackgroundIntent.getBroadcast(context,
//                                        Uri.parse("myAppWidget://tasks?index=$i&isDone=${isDone}"))
//                                    setOnClickPendingIntent(R.id.task2Image, taskIntent)
//                                    setOnClickPendingIntent(R.id.task2, taskIntent)
                                } else if (count == 2) {
                                    setTextViewText(R.id.task3, task.get("task").toString())
                                    val isDone = task.get("isDone")
                                    if (isDone == true) {
                                        setImageViewResource(R.id.task3Image, R.drawable.done)
                                    } else {
                                        setImageViewResource(R.id.task3Image, R.drawable.undone)
                                    }

                                    // Pending intent to update counter on button click
//                                    val taskIntent = HomeWidgetBackgroundIntent.getBroadcast(context,
//                                        Uri.parse("myAppWidget://tasks?index=$i&isDone=${isDone}"))
//                                    setOnClickPendingIntent(R.id.task3Image, taskIntent)
//                                    setOnClickPendingIntent(R.id.task3, taskIntent)
                                } else {
                                    setTextViewText(R.id.task4, task.get("task").toString())
                                    val isDone = task.get("isDone")
                                    if (isDone == true) {
                                        setImageViewResource(R.id.task4Image, R.drawable.done)
                                    } else {
                                        setImageViewResource(R.id.task4Image, R.drawable.undone)
                                    }

                                    // Pending intent to update counter on button click
//                                    val taskIntent = HomeWidgetBackgroundIntent.getBroadcast(context,
//                                        Uri.parse("myAppWidget://tasks?index=$i&isDone=${isDone}"))

//                                    setOnClickPendingIntent(R.id.task4Image, taskIntent)
//                                    setOnClickPendingIntent(R.id.task4, taskIntent)
                                }
                                count++
                            }
                        }
                    }
                }

                // Pending intent to update counter on button click
//                val backgroundIntent = HomeWidgetBackgroundIntent.getBroadcast(context,
//                        Uri.parse("myAppWidget://updatecounter"))
//                setOnClickPendingIntent(R.id.bt_update, backgroundIntent)
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}