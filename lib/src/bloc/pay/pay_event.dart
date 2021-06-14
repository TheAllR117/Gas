part of 'pay_bloc.dart';

@immutable
abstract class PayEvent {}

class OnSelectCard extends PayEvent {
  final TarjetaCredito card;
  OnSelectCard(this.card);
}

class OndisabledCard extends PayEvent {}
