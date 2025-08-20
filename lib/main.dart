import 'package:flutter/material.dart';
import 'package:market_news_app/services/news_service.dart';
import 'package:market_news_app/services/timer_service.dart';
import 'package:market_news_app/views/news_list_view.dart';
import 'package:market_news_app/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await notificationService.init();
  newsService.getNews();
  timerService.startTimer();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: NewsListView());
  }

  @override
  void dispose() {
    timerService.closeTimer();
    super.dispose();
  }
}
