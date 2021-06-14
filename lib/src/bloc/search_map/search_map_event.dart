part of 'search_map_bloc.dart';

@immutable
abstract class SearchMapEvent {}

class OnActivateManualDialer extends SearchMapEvent {}

class OnDisableManualDialer extends SearchMapEvent {}
