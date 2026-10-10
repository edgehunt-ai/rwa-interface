import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import 'launch_animation.dart';

@Preview(
  name: 'Surface launch animation',
  group: 'Launch',
  size: Size(390, 844),
)
Widget launchAnimationPreview() => LaunchAnimation(onFinished: () {});
