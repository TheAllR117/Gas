import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:gasfast/src/models/stripe/credit_card_model.dart';
import 'package:meta/meta.dart';

part 'pay_event.dart';
part 'pay_state.dart';

class PayBloc extends Bloc<PayEvent, PayState> {
  PayBloc() : super(PayState());

  @override
  Stream<PayState> mapEventToState(PayEvent event) async* {
    if (event is OnSelectCard) {
      yield state.copyWith(cardActive: true, card: event.card);
    } else if (event is OndisabledCard) {
      yield state.copyWith(cardActive: false);
    }
  }
}
