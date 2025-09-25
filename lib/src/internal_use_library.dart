library;

/// Dart Packages
import 'dart:js_interop';
import 'dart:js_util' as js_util;
import 'dart:html' as html;

/// Models
import '../models/camera_position.dart';
export '../models/camera_position.dart';
import '../models/polygon_data.dart';
export '../models/polygon_data.dart';

export '../platform/google_map_script.dart';
export '../platform/web_only/web_only.dart';

/// Controllers
export '../src/controller/map_controller.dart';
import '../src/controller/map_controller.dart';
import '../models/lat_lng.dart';

/// Flutter SDK libraries
export 'package:flutter/material.dart';
export 'package:flutter/foundation.dart';

/// Interops
part '../src/internal/interop/drawing_manager.dart';
part '../src/internal/interop/g_map.dart';
part '../src/internal/interop/overlay_complete.dart';
part '../src/internal/interop/polygon.dart';

/// Helper Functions / Utils
part '../src/internal/utils/convert_polygon_path_to_coords_list.dart';
part '../src/internal/utils/draw_buttons.dart';
part '../src/internal/utils/map_init_registration.dart';
part '../src/internal/utils/move_map_to_coords_bound.dart';
part '../src/internal/utils/set_polygon_data.dart';