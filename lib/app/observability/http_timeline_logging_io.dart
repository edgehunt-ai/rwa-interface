import 'dart:io';

import 'package:flutter/foundation.dart';

void enableHttpTimelineLogging() {
  if (kDebugMode) HttpClient.enableTimelineLogging = true;
}
