part of 'pay_bloc.dart';

@immutable
class PayState {
  final double? amountPayable;
  final String? coin;
  final bool? cardActive;
  final TarjetaCredito? card;

  String get montoPayString => '${(this.amountPayable! * 100).floor()}';

  PayState(
      {this.amountPayable = 10000,
      this.coin = 'mxn',
      this.cardActive = false,
      this.card});

  PayState copyWith({
    double? amountPayable,
    String? coin,
    bool? cardActive,
    TarjetaCredito? card,
  }) =>
      PayState(
        amountPayable: amountPayable ?? this.amountPayable,
        coin: coin ?? this.coin,
        cardActive: cardActive ?? this.cardActive,
        card: card ?? this.card,
      );
}
