class IndividualStockStat {
  final String name;
  final double delta;
  final double share;

  IndividualStockStat(this.name, this.delta, this.share);

  @override
  String toString() {
    return "ISS[name: $name, delta: $delta, share: $share]";    
  }
}
