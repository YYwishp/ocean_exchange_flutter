// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../funds_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FundsEntity _$FundsEntityFromJson(Map<String, dynamic> json) {
  return FundsEntity(
    accounts: (json['accounts'] as List<dynamic>?)
        ?.map((e) => Account.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$FundsEntityToJson(FundsEntity instance) =>
    <String, dynamic>{
      'accounts': instance.accounts,
    };

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account(
    currency: json['currency'] as String?,
    type: json['type'] as String?,
    deposit: json['deposit'] as String?,
    withdraw: json['withdraw'] as String?,
    exchange: json['exchange'] as String?,
    balance: json['balance'] as String?,
    btcEquivalentBalance: json['btc_equivalent_balance'] as String?,
    locked: json['locked'] as String?,
    isCombinationAddress: json['is_combination_address'] as bool?,
    markets: (json['markets'] as List<dynamic>?)
        ?.map((e) => Market.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'currency': instance.currency,
      'type': instance.type,
      'deposit': instance.deposit,
      'withdraw': instance.withdraw,
      'exchange': instance.exchange,
      'balance': instance.balance,
      'btc_equivalent_balance': instance.btcEquivalentBalance,
      'locked': instance.locked,
      'is_combination_address': instance.isCombinationAddress,
      'markets': instance.markets,
    };

Market _$MarketFromJson(Map<String, dynamic> json) {
  return Market(
    displayName: json['display_name'] as String?,
    baseUnit: json['base_unit'] as String?,
    quoteUnit: json['quote_unit'] as String?,
  );
}

Map<String, dynamic> _$MarketToJson(Market instance) => <String, dynamic>{
      'display_name': instance.displayName,
      'base_unit': instance.baseUnit,
      'quote_unit': instance.quoteUnit,
    };
