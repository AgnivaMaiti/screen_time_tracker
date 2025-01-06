import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// A class that tracks the time spent on different screens.
class ScreenTimeTracker {
  static final ScreenTimeTracker _instance = ScreenTimeTracker._internal();

  factory ScreenTimeTracker() {
    return _instance;
  }

  ScreenTimeTracker._internal();

  final Map<String, Duration> _screenTimeMap = {};
  final Map<String, Timer> _screenTimers = {};

  bool _debugMode = false;

  /// Enable debug mode to log screen time updates.
  void enableDebugMode() {
    _debugMode = true;
  }

  /// Disable debug mode.
  void disableDebugMode() {
    _debugMode = false;
  }

  void _log(String message) {
    if (_debugMode) {
      print("[ScreenTimeTracker] $message");
    }
  }

  /// Start tracking time for the active screen.
  ///
  /// This method should be called when a screen becomes active.
  /// If another screen is being tracked, it will automatically stop tracking
  /// the previous screen.
  ///
  /// [screenName] is the name of the screen to track.
  void startTracking(String screenName) {
    if (!_screenTimeMap.containsKey(screenName)) {
      _screenTimeMap[screenName] = Duration.zero;
    }

    _log("Started tracking: $screenName");

    // Start a timer to track the screen time for the given screen.
    _screenTimers[screenName] = Timer.periodic(Duration(seconds: 1), (timer) {
      _screenTimeMap[screenName] =
          _screenTimeMap[screenName]! + Duration(seconds: 1);
      _log("Time spent on $screenName: ${_screenTimeMap[screenName]}");
    });
  }

  /// Stop tracking time for the current screen.
  void stopTracking(String screenName) {
    if (_screenTimers.containsKey(screenName)) {
      _log("Stopped tracking: $screenName");
      _screenTimers[screenName]?.cancel();
      _screenTimers.remove(screenName);
    }
  }

  /// Get the time spent on a specific screen.
  Duration getTimeSpentOnScreen(String screenName) {
    return _screenTimeMap[screenName] ?? Duration.zero;
  }

  /// Reset the screen time data.
  void resetScreenTime() {
    _screenTimeMap.clear();
    _screenTimers.clear();
  }

  /// Get a summary of all screen times.
  Map<String, Duration> getScreenTimeSummary() {
    return Map.from(_screenTimeMap);
  }
}

/// A widget that automatically tracks screen time when the screen is active.
class ScreenTimeWidget extends StatefulWidget {
  final String screenName;
  final Widget child;

  const ScreenTimeWidget({
    required this.screenName,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  _ScreenTimeWidgetState createState() => _ScreenTimeWidgetState();
}

class _ScreenTimeWidgetState extends State<ScreenTimeWidget> {
  @override
  void initState() {
    super.initState();
    ScreenTimeTracker().startTracking(widget.screenName);
  }

  @override
  void dispose() {
    ScreenTimeTracker().stopTracking(widget.screenName);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

/// A widget that displays a summary of all screen times.
class ScreenTimeSummaryWidget extends StatelessWidget {
  final TextStyle? textStyle;

  const ScreenTimeSummaryWidget({this.textStyle, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenTimeSummary = ScreenTimeTracker().getScreenTimeSummary();

    return ListView(
      children: screenTimeSummary.entries.map((entry) {
        final screenName = entry.key;
        final duration = entry.value;

        return ListTile(
          title: Text(
            screenName,
            style: textStyle ?? const TextStyle(fontSize: 16),
          ),
          subtitle: Text(
            "Time spent: ${duration.inMinutes}m ${duration.inSeconds % 60}s",
            style: textStyle ?? const TextStyle(fontSize: 14),
          ),
        );
      }).toList(),
    );
  }
}
