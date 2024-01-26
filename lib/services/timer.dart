import 'dart:async';

enum TimerState {
  running,
  paused,
  stopped,
}

class TimerController {
  Duration _initialDuration = Duration(minutes: 60, seconds: 0);
  Duration _duration = Duration(minutes: 60, seconds: 0);
  Timer? _timer;
  TimerState _timerState = TimerState.stopped;

  Duration get duration => _duration;
  TimerState get timerState => _timerState;

  void startTimer(void Function() onTimerUpdate) {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (Timer timer) {
      _duration -= oneSecond;
      if (_duration.inSeconds <= 0) {
        stopTimer();
      }
      onTimerUpdate();
    });
    _timerState = TimerState.running;
  }

  void stopTimer() {
    _timer?.cancel();
    _timerState = TimerState.paused;
  }

  void resetTimer() {
    _timer?.cancel();
    _duration = _initialDuration;
    _timerState = TimerState.stopped;
  }

  void toggleTimer(void Function() onTimerUpdate) {
    if (_timerState == TimerState.running) {
      stopTimer();
    } else if (_timerState == TimerState.paused) {
      startTimer(onTimerUpdate);
    } else {
      startTimer(onTimerUpdate);
    }
  }

  void dispose() {
    _timer?.cancel();
  }
}