class BandCategory {
  final int id;
  final String name;
  final String image;

  BandCategory(this.id, this.name, this.image);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BandCategory &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

}