import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

const launchBackgroundColor = Color(0xFFF7F7FA);
const launchForegroundColor = Color(0xFFFF7BE5);
const launchAnimationAsset = 'assets/launch/surface/foreground.tgs';
const launchFirstFrameAsset = 'assets/launch/surface/first-frame.svg';
const launchFinalFrameAsset = 'assets/launch/surface/final-frame.svg';

const launchSurfaceKey = Key('launch-surface');
const launchAnimationKey = Key('launch-animation');

/// Keeps the application alive beneath a one-shot cold-start animation.
class LaunchAnimationGate extends StatefulWidget {
  const LaunchAnimationGate({
    required this.child,
    super.key,
    this.ready = false,
    this.fadeDuration = const Duration(milliseconds: 240),
    this.animationDurationOverride,
    this.reducedMotionHold = const Duration(milliseconds: 600),
    this.maximumWait = const Duration(seconds: 12),
  });

  final Widget child;
  final bool ready;
  final Duration fadeDuration;
  final Duration? animationDurationOverride;
  final Duration reducedMotionHold;
  final Duration maximumWait;

  @override
  State<LaunchAnimationGate> createState() => _LaunchAnimationGateState();
}

class _LaunchAnimationGateState extends State<LaunchAnimationGate> {
  bool _showLaunch = true;
  bool _launchOpaque = true;
  Timer? _maximumWaitTimer;

  @override
  void initState() {
    super.initState();
    _maximumWaitTimer = Timer(widget.maximumWait, _fadeLaunch);
    if (widget.ready) _scheduleFade();
  }

  @override
  void didUpdateWidget(covariant LaunchAnimationGate oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.ready && widget.ready) _scheduleFade();
  }

  void _scheduleFade() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _fadeLaunch());
  }

  void _fadeLaunch() {
    if (!mounted || !_launchOpaque) return;
    _maximumWaitTimer?.cancel();
    setState(() => _launchOpaque = false);
  }

  @override
  void dispose() {
    _maximumWaitTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
    fit: StackFit.expand,
    children: [
      widget.child,
      if (_showLaunch)
        Positioned.fill(
          child: AnimatedOpacity(
            opacity: _launchOpaque ? 1 : 0,
            duration: widget.fadeDuration,
            curve: Curves.easeOut,
            onEnd: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted && !_launchOpaque) {
                  setState(() => _showLaunch = false);
                }
              });
            },
            child: AbsorbPointer(
              child: LaunchAnimation(
                onFinished: _fadeLaunch,
                durationOverride: widget.animationDurationOverride,
                reducedMotionHold: widget.reducedMotionHold,
              ),
            ),
          ),
        ),
    ],
  );
}

/// The approved 390 x 844 surface launch animation, fitted without distortion.
class LaunchAnimation extends StatefulWidget {
  const LaunchAnimation({
    super.key,
    this.onFinished,
    this.durationOverride,
    this.reducedMotionHold = const Duration(milliseconds: 600),
  });

  final VoidCallback? onFinished;
  final Duration? durationOverride;
  final Duration reducedMotionHold;

  @override
  State<LaunchAnimation> createState() => _LaunchAnimationState();
}

class _LaunchAnimationState extends State<LaunchAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this);
  Timer? _completionTimer;
  bool _compositionLoaded = false;
  bool _started = false;
  bool _finished = false;
  bool _reduceMotion = false;

  @override
  void initState() {
    super.initState();
    // Never leave the application covered if an asset fails to decode.
    _completionTimer = Timer(const Duration(seconds: 8), _finish);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;

    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    _reduceMotion = reduceMotion;
    if (!reduceMotion) return;

    _started = true;
    _completionTimer?.cancel();
    _completionTimer = Timer(widget.reducedMotionHold, _finish);
  }

  void _onCompositionLoaded(LottieComposition composition) {
    if (!mounted || _reduceMotion) return;
    setState(() => _compositionLoaded = true);
    if (_started) return;

    _started = true;
    _completionTimer?.cancel();
    _controller.duration = widget.durationOverride ?? composition.duration;
    unawaited(_controller.forward().whenComplete(_finish));
  }

  void _finish() {
    if (!mounted || _finished) return;
    _finished = true;
    widget.onFinished?.call();
  }

  @override
  void dispose() {
    _completionTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ColoredBox(
    key: launchSurfaceKey,
    color: launchBackgroundColor,
    child: ExcludeSemantics(
      child: _reduceMotion
          ? SvgPicture.asset(launchFinalFrameAsset, fit: BoxFit.contain)
          : Stack(
              fit: StackFit.expand,
              children: [
                if (!_compositionLoaded)
                  SvgPicture.asset(launchFirstFrameAsset, fit: BoxFit.contain),
                Lottie.asset(
                  launchAnimationAsset,
                  key: launchAnimationKey,
                  controller: _controller,
                  fit: BoxFit.contain,
                  repeat: false,
                  frameRate: FrameRate.composition,
                  decoder: LottieComposition.decodeGZip,
                  onLoaded: _onCompositionLoaded,
                ),
              ],
            ),
    ),
  );
}
