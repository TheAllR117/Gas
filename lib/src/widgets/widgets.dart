import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasfast/src/bloc/map/map_bloc.dart';
import 'package:gasfast/src/bloc/my_location/my_location_bloc.dart';
import 'package:gasfast/src/bloc/search_map/search_map_bloc.dart';
import 'package:gasfast/src/helpers/helpers.dart';
import 'package:gasfast/src/models/map/gasoline_prices_response.dart';
import 'package:gasfast/src/models/map/search_result.dart';
import 'package:gasfast/src/search/search_destination.dart';
import 'package:gasfast/src/services/traffic_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:polyline/polyline.dart' as Poly;
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart'
    as Poly;
import 'package:skeleton_animation/skeleton_animation.dart';

part 'btn_location.dart';
part 'btn_my_rount.dart';
part 'btn_follow_location.dart';
part 'searchbar.dart';
part 'appbar_buttons.dart';
part 'manual_marker_map.dart';
part 'btn_stations.dart';
part 'card_prices_destination.dart';
