# README.md

## Screen Time Tracker

A Flutter package that tracks the time spent on different screens in your application. This package provides a simple way to monitor user engagement by tracking how long they spend on each screen.

### Features

- **Singleton Class**: The `ScreenTimeTracker` class is implemented as a singleton to ensure a single instance is used throughout the application.
- **Debug Mode**: Easily enable or disable debug logging to track screen time updates.
- **Automatic Tracking**: Use the `ScreenTimeWidget` to automatically start and stop tracking when a screen is active.
- **Summary Widget**: Display a summary of time spent on each screen using the `ScreenTimeSummaryWidget`.

### Installation

To use this package, add it to your `pubspec.yaml` file:

```yaml
dependencies:
  screen_time_tracker: ^1.0.0
```

### Usage

1. **Import the package**:

```dart
import 'package:screen_time_tracker/screen_time_tracker.dart';
```

2. **Wrap your screen with ScreenTimeWidget**:

```dart
ScreenTimeWidget(
  screenName: 'Home Screen',
  child: YourHomeScreenWidget(),
)
```

3. **Display the summary**:

```dart
ScreenTimeSummaryWidget();
```

### Methods

- `enableDebugMode()`: Enable debug mode to log screen time updates.
- `disableDebugMode()`: Disable debug mode.
- `startTracking(String screenName)`: Start tracking time for the specified screen.
- `stopTracking(String screenName)`: Stop tracking time for the specified screen.
- `getTimeSpentOnScreen(String screenName)`: Get the time spent on a specific screen.
- `resetScreenTime()`: Reset the screen time data.
- `getScreenTimeSummary()`: Get a summary of all screen times.

### Example

Here is a simple example of how to use the `ScreenTimeTracker` in your Flutter application:

```dart
import 'package:flutter/material.dart';
import 'package:screen_time_tracker/screen_time_tracker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScreenTimeWidget(
        screenName: 'Home Screen',
        child: Scaffold(
          appBar: AppBar(title: Text('Screen Time Tracker')),
          body: Center(child: Text('Welcome to the Home Screen!')),
        ),
      ),
    );
  }
}
```

### Author

This package was built by [Agniva Maiti](https://github.com/AgnivaMaiti).
