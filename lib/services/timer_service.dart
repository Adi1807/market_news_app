import 'dart:async';

import 'package:market_news_app/services/news_service.dart';

class TimerService {
  Timer? timer;
  void startTimer() {
    if (timer != null && timer!.isActive) return;
    timer = Timer.periodic(Duration(seconds: 5), (_) {
      newsService.getNews();
    });
  }

  void closeTimer() {
    timer?.cancel();
    timer = null;
  }
}

TimerService timerService = TimerService();
