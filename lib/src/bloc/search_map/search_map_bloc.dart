import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_map_event.dart';
part 'search_map_state.dart';

class SearchMapBloc extends Bloc<SearchMapEvent, SearchState> {
  SearchMapBloc() : super(SearchState());

  @override
  Stream<SearchState> mapEventToState(
    SearchMapEvent event,
  ) async* {
    if (event is OnActivateManualDialer) {
      yield state.copyWith(manualselection: true);
    } else if (event is OnDisableManualDialer) {
      yield state.copyWith(manualselection: false);
    }
  }
}
