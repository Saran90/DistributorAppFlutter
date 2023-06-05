class Manufacture {
  int? id;
  String? name;

  Manufacture({this.id, this.name});

  @override
  String toString() {
    return name??'';
  }
}
