import 'dart:async';

import 'package:book_talk/src/common/utils/error_tracking.dart';
import 'package:book_talk/src/feature/bootstrap/logic/app_bootstrap.dart';

void main() => runZonedGuarded(
    () => AppBootstrap().initializeApp(), ErrorTracking.trackError);
