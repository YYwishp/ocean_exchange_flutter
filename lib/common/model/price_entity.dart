class PriceEntity{

  String id;

  String rate;

  PriceEntity(this.id,this.rate);

  @override
  String toString() {
    return 'PriceEntity{id: $id, rate: $rate}';
  }
}