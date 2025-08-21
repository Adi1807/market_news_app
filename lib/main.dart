import 'package:flutter/material.dart';
import 'package:market_news_app/services/news_service.dart';
import 'package:market_news_app/services/theme_notifier.dart';
import 'package:market_news_app/services/timer_service.dart';
import 'package:market_news_app/views/news_list_view.dart';
import 'package:market_news_app/services/notification_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await notificationService.init();
  newsService.getNews();
  timerService.startTimer();
  final themeNotifier = ThemeNotifier();
  runApp(
    ChangeNotifierProvider(
      create: (_) => themeNotifier,
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      home: NewsListView(),
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeNotifier.themeMode,
    );
  }

  @override
  void dispose() {
    timerService.closeTimer();
    super.dispose();
  }
}
