import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:market_news_app/models/news_model.dart';

class NotificationService {
  late InitializationSettings initSettings;
  late NotificationDetails notificationDetails;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialization settings for Android
  AndroidInitializationSettings androidInitSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  // Initialization settings for Windows
  WindowsInitializationSettings windowsInitSettings =
      WindowsInitializationSettings(
        appName: 'market_news_app',
        appUserModelId: 'com.example.market_news_app', // must be unique
        guid: '12345678-1234-5678-1234-567812345678', // fixed UUID string
        iconPath: null, // optional, can set "assets/app_icon.ico"
      );

  AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'market_news_app',
    'General Notifications',
    channelDescription: 'Channel for demo notifications',
    importance: Importance.max,
    priority: Priority.high,
  );

  WindowsNotificationDetails windowsDetails = WindowsNotificationDetails();

  Future<void> init() async {
    initSettings = InitializationSettings(
      android: androidInitSettings,
      windows: windowsInitSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        debugPrint('Notification tapped: ${response.payload}');
      },
    );
    notificationDetails = NotificationDetails(
      android: androidDetails,
      windows: windowsDetails,
    );
  }

  int i = 0;

  Future<void> showNotification(NewsModel newsModel) async {
    await flutterLocalNotificationsPlugin.show(
      i,
      newsModel.title,
      newsModel.desc,
      notificationDetails,
      payload: 'custom_payload',
    );
    i++;
  }
}

NotificationService notificationService = NotificationService();
