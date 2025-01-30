import 'package:flutter/widgets.dart';
import 'package:once/once.dart';
import 'package:once/src/builder/builder.dart';
import 'package:once/src/const.dart';
import 'package:once/src/runner/runner.dart';

abstract class OnceWidget {
  /// A generic callback that runs on every new version
  static FutureBuilder<Widget?> showOnEveryNewVersion<T>({
    String? key,
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      Once.runOnEveryNewVersion(
        key: key,
        callback: builder,
        debugCallback: debugCallback,
        debugFallback: debugFallback,
      ),
      fallback,
    );
  }

  /// A generic callback that runs on every new build number
  static FutureBuilder<Widget?> showOnEveryNewBuild<T>({
    String? key,
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      Once.runOnEveryNewBuild(
        key: key,
        callback: builder,
        debugCallback: debugCallback,
        debugFallback: debugFallback,
      ),
      fallback,
    );
  }

  /// A generic callback that runs every once
  static FutureBuilder<Widget?> showOnce<T>(
    String key, {
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      Once.runOnce(
        key,
        callback: builder,
        debugCallback: debugCallback,
        debugFallback: debugFallback,
      ),
      fallback,
    );
  }

  /// A generic callback that runs every 12 hours
  static FutureBuilder<Widget?> showEvery12Hours<T>(
    String key, {
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      Once.runEvery12Hours(
        key,
        callback: builder,
        debugCallback: debugCallback,
        debugFallback: debugFallback,
      ),
      fallback,
    );
  }

  /// A generic callback that runs after every hour
  static FutureBuilder<Widget?> showHourly<T>(
    String key, {
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      Once.runHourly(
        key,
        callback: builder,
        debugCallback: debugCallback,
        debugFallback: debugFallback,
      ),
      fallback,
    );
  }

  /// A generic callback that runs on a daily basis
  static FutureBuilder<Widget?> showDaily<T>(
    String key, {
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      Once.runDaily(
        key,
        callback: builder,
        debugCallback: debugCallback,
        debugFallback: debugFallback,
      ),
      fallback,
    );
  }

  /// A generic callback that runs on every new day
  static FutureBuilder<Widget?> showOnNewDay<T>(
    String key, {
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      Once.runOnNewDay(
        key,
        callback: builder,
        debugCallback: debugCallback,
        debugFallback: debugFallback,
      ),
      fallback,
    );
  }

  /// A generic callback that runs every week
  static FutureBuilder<Widget?> showWeekly<T>(
    String key, {
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      OnceRunner.run(
        key: key,
        duration: Const.week,
        callback: builder,
        debugCallback: debugCallback,
        debugFallback: debugFallback,
      ),
      fallback,
    );
  }

  /// A generic callback that runs every new month
  static FutureBuilder<Widget?> showMonthly<T>(
    String key, {
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      OnceRunner.run(
        key: key,
        duration: -1,
        callback: builder,
        debugCallback: debugCallback,
        debugFallback: debugFallback,
      ),
      fallback,
    );
  }

  /// A generic callback that runs every month
  static FutureBuilder<Widget?> showOnNewMonth<T>(
    String key, {
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      OnceRunner.run(
        key: key,
        duration: DateTime.now().month,
        callback: builder,
        debugCallback: debugCallback,
        debugFallback: debugFallback,
      ),
      fallback,
    );
  }

  /// A generic callback that runs yearly
  static FutureBuilder<Widget?> showYearly<T>(
    String key, {
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      OnceRunner.run(
        key: key,
        duration: Const.year,
        callback: builder,
        debugCallback: debugCallback,
        debugFallback: debugFallback,
      ),
      fallback,
    );
  }

  /// A generic callback that runs on a custom basis set by the user
  static FutureBuilder<Widget?> showCustom<T>(
    String key, {
    required Duration duration,
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      OnceRunner.run(
        key: key,
        duration: duration.inMilliseconds,
        callback: builder,
        debugCallback: debugCallback,
        debugFallback: debugFallback,
      ),
      fallback,
    );
  }

  /// Clear OnceBuilder cache for a specific [key]
  static void clear({
    required String key,
  }) {
    OnceRunner.clear(key: key);
  }

  /// Clear OnceBuilder cache for all keys
  static void clearAll() {
    OnceRunner.clearAll();
  }

  // ----------------------------
  // NEW METHOD: showUntilActionDone
  // ----------------------------
  /// Show a widget repeatedly **until** the user calls `markDone()`.
  /// If `markDone()` is never called, the widget keeps showing every time.
  /// Once `markDone()` is called, we record it as completed and won't show again.
  static Widget showUntilActionDone({
    required String key,
    required Widget Function(VoidCallback markDone) builder,
    Widget Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return FutureBuilder<bool>(
      future: OnceRunner.isCompleted(key),
      builder: (context, snapshot) {
        // If still loading or no data, show fallback (or nothing)
        if (!snapshot.hasData) {
          return fallback?.call() ?? const SizedBox.shrink();
        }

        final bool isDone = snapshot.data!;

        if (isDone) {
          // Already completed => show fallback or nothing
          if (debugFallback) {
            debugPrint('[$key] showUntilActionDone Fallback triggered');
          }
          return fallback?.call() ?? const SizedBox.shrink();
        } else {
          // Not completed => show the real widget
          if (debugCallback) {
            debugPrint('[$key] showUntilActionDone Callback triggered');
          }
          return builder(() async {
            // This is the function you call when user finishes the action
            await OnceRunner.markComplete(key);
            // Force rebuild after marking done
            (context as Element).markNeedsBuild();
          });
        }
      },
    );
  }
}
