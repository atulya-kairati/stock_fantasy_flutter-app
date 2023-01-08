class Stock{
  final String name;
  final double price;

  Stock(this.name, this.price);

  @override
  String toString() {
    return "Stock[name: $name, price: $price]";    
  }
}