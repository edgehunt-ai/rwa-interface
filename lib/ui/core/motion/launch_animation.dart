import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart' as rive;

const launchBackgroundColor = Color(0xFFF7F7FA);
const launchForegroundColor = Color(0xFFFF7BE5);
const launchAnimationAsset = 'assets/launch/surface/nobell-surface.riv';
const launchFirstFrameAsset = 'assets/launch/surface/first-frame.svg';
const launchFinalFrameAsset = 'assets/launch/surface/final-frame.svg';

const _launchAnimationDuration = Duration(milliseconds: 4217);

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

class _LaunchAnimationState extends State<LaunchAnimation> {
  rive.File? _file;
  rive.RiveWidgetController? _controller;
  Timer? _completionTimer;
  bool _animationLoaded = false;
  bool _loadRequested = false;
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
    if (!reduceMotion) {
      if (!_loadRequested) {
        _loadRequested = true;
        unawaited(_loadAnimation());
      }
      return;
    }

    _started = true;
    _completionTimer?.cancel();
    _completionTimer = Timer(widget.reducedMotionHold, _finish);
  }

  Future<void> _loadAnimation() async {
    rive.File? file;
    try {
      file = await rive.File.asset(
        launchAnimationAsset,
        riveFactory: rive.Factory.rive,
      );
      if (file == null || !mounted || _reduceMotion) {
        file?.dispose();
        return;
      }

      final controller = rive.RiveWidgetController(
        file,
        artboardSelector: rive.ArtboardSelector.byName('Nobell Launch'),
        stateMachineSelector: rive.StateMachineSelector.byName('LaunchOnce'),
      );
      if (!mounted) {
        controller.dispose();
        file.dispose();
        return;
      }

      _file = file;
      _controller = controller;
      setState(() => _animationLoaded = true);

      _started = true;
      _completionTimer?.cancel();
      _completionTimer = Timer(
        widget.durationOverride ?? _launchAnimationDuration,
        _finish,
      );
    } on Object {
      file?.dispose();
      // Keep the SVG first frame visible until the safety timeout expires.
    }
  }

  void _finish() {
    if (!mounted || _finished) return;
    _finished = true;
    widget.onFinished?.call();
  }

  @override
  void dispose() {
    _completionTimer?.cancel();
    _controller?.dispose();
    _file?.dispose();
    super.dispose();
  }

  Widget _buildAnimatedLaunch() {
    final controller = _controller;
    return Stack(
      fit: StackFit.expand,
      children: [
        if (!_animationLoaded)
          SvgPicture.asset(launchFirstFrameAsset, fit: BoxFit.contain),
        if (controller != null)
          rive.RiveWidget(
            key: launchAnimationKey,
            controller: controller,
            fit: rive.Fit.contain,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => ColoredBox(
    key: launchSurfaceKey,
    color: launchBackgroundColor,
    child: ExcludeSemantics(
      child: _reduceMotion
          ? SvgPicture.asset(launchFinalFrameAsset, fit: BoxFit.contain)
          : _buildAnimatedLaunch(),
    ),
  );
}
