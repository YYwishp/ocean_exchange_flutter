import 'package:json_annotation/json_annotation.dart'; 

part 'generate/funds_entity.g.dart';

@JsonSerializable(ignoreUnannotated: false)
class FundsEntity {
  @JsonKey(name: 'accounts')
  List<Account>? accounts;

  FundsEntity({this.accounts});

  factory FundsEntity.fromJson(Map<String, dynamic> json) => _$FundsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FundsEntityToJson(this);
}

@JsonSerializable(ignoreUnannotated: false)
class Account {
  @JsonKey(name: 'currency')
  String? currency;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'deposit')
  String? deposit;
  @JsonKey(name: 'withdraw')
  String? withdraw;
  @JsonKey(name: 'exchange')
  String? exchange;
  @JsonKey(name: 'balance')
  String? balance;
  @JsonKey(name: 'btc_equivalent_balance')
  String? btcEquivalentBalance;
  @JsonKey(name: 'locked')
  String? locked;
  @JsonKey(name: 'is_combination_address')
  bool? isCombinationAddress;
  @JsonKey(name: 'markets')
  List<Market>? markets;

  Account({this.currency, this.type, this.deposit, this.withdraw, this.exchange, this.balance, this.btcEquivalentBalance, this.locked, this.isCombinationAddress, this.markets});

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

@JsonSerializable(ignoreUnannotated: false)
class Market {
  @JsonKey(name: 'display_name')
  String? displayName;
  @JsonKey(name: 'base_unit')
  String? baseUnit;
  @JsonKey(name: 'quote_unit')
  String? quoteUnit;

  Market({this.displayName, this.baseUnit, this.quoteUnit});

  factory Market.fromJson(Map<String, dynamic> json) => _$MarketFromJson(json);

  Map<String, dynamic> toJson() => _$MarketToJson(this);
}

