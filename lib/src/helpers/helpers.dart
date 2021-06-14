import 'dart:io';

import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gasfast/custom_marker/custom_markers.dart';
import 'package:gasfast/src/models/errors/error_response.dart';
import 'package:gasfast/src/services/auth_service.dart';
import 'package:gasfast/src/services/contact_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'
    show BitmapDescriptor;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

part 'navegar_fadein.dart';
part 'alerts.dart';
part 'custom_image_marker.dart';
part 'widgets_to_marker.dart';
