import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Signature for when a pointer has remained in contact with the screen at the
/// same location for a long period of time.
typedef void GestureHoldCallback();

/// Signature for when the pointer that previously triggered a
/// [GestureTapDownCallback] will not end up causing a tap.
///
/// See also:
///
///  * [GestureDetector.onTapCancel], which matches this signature.
///  * [TapGestureRecognizer], which uses this signature in one of its callbacks.
typedef void GestureHoldCancelCallback();

/// A widget that detects a holding gesture.
///
/// If this widget has a child, it defers to that child for its sizing behavior.
/// If it does not have a child, it grows to fit the parent instead.
///
/// It defaults to repeating an action every 200ms (customizable), but for now
/// it always waits 200ms to start repeating the [onHold] callback.
///
/// See <http://flutter.io/gestures/> for additional information.
///
/// Material design applications typically react to touches with ink splash
/// effects. The [InkWell] class implements this effect and can be used in place
/// of a [GestureDetector] for handling taps.
///
/// This example makes the counter keep while holding the button:
///
/// ```dart
/// new HoldDetector(
///   onHold: () {
///     setState(() { _counter += 1; });
///   },
///   child: Text("$_counter"),
/// )
/// ```
///
class HoldDetector extends StatelessWidget {
  final GestureTapCallback onTap;
  final GestureHoldCallback onHold;
  final GestureHoldCancelCallback onCancel;
  final Duration holdTimeout;
  final Widget child;

  const HoldDetector({
    Key key,
    this.onTap,
    this.onCancel,
    this.holdTimeout,
    @required this.onHold,
    @required this.child,
  })  : assert(onHold != null),
        assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: {
        TapGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
          () => TapGestureRecognizer(debugOwner: this),
          (instance) => instance..onTap = this.onTap ?? this.onHold,
        ),
        HoldGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<HoldGestureRecognizer>(
          () => HoldGestureRecognizer(
            timeout: this.holdTimeout,
            debugOwner: this,
          ),
          (instance) => instance
            ..onHold = this.onHold
            ..onCancel = this.onCancel,
        )
      },
      child: this.child,
    );
  }
}

final Duration kHoldTimeout = Duration(milliseconds: 150);

/// Recognizes when the user has pressed down at the same location for a long
/// period of time. Its waiting duration defaults to [kHoldTimeout].
class HoldGestureRecognizer extends PrimaryPointerGestureRecognizer {
  /// Creates a long-press gesture recognizer.
  ///
  /// Consider assigning the [onHold] callback after creating this object.
  HoldGestureRecognizer({Duration timeout, Object debugOwner})
      : super(deadline: timeout ?? kHoldTimeout, debugOwner: debugOwner);

  /// Called when a hold is recognized.
  GestureHoldCallback onHold;

  /// Called when the hold is canceled.
  GestureHoldCancelCallback onCancel;

  ///
  Timer _timer;

  @override
  void didExceedDeadline() {
    resolve(GestureDisposition.accepted);
    if (onHold != null) {
      _timer = Timer.periodic(kHoldTimeout, (timer) {
        if (timer.isActive) invokeCallback<void>('onHold', onHold);
      });
    }
  }

  @override
  void handlePrimaryPointer(PointerEvent event) {
    if (event is PointerUpEvent ||
        event is PointerCancelEvent ||
        event is PointerRemovedEvent) {
      if (onCancel != null) invokeCallback<void>('onCancel', onCancel);
      _timer?.cancel();
      resolve(GestureDisposition.rejected);
    }
  }

  @override
  String get debugDescription => 'hold';
}
