

class VenuDecorationOption {
  final List<String>? tableShape;
  final List<String>? seatingStyle;
  final List<String>? lightingStyle;
  final List<String>? flowerColor;
  final List<String>? flowerType;
  final List<String>? fragrance;

  VenuDecorationOption({
    this.tableShape,
    this.seatingStyle,
    this.lightingStyle,
    this.flowerColor,
    this.flowerType,
    this.fragrance,
  });

  factory VenuDecorationOption.fromJson(Map<String, dynamic> json) {
    return VenuDecorationOption(
      tableShape: json['TableShape'] != null
          ? List<String>.from(json['TableShape'])
          : null,
      seatingStyle: json['SeatingStyle'] != null
          ? List<String>.from(json['SeatingStyle'])
          : null,
      lightingStyle: json['LightingStyle'] != null
          ? List<String>.from(json['LightingStyle'])
          : null,
      flowerColor: json['FlowerColor'] != null
          ? List<String>.from(json['FlowerColor'])
          : null,
      flowerType: json['FlowerType'] != null
          ? List<String>.from(json['FlowerType'])
          : null,
      fragrance: json['Fragrance'] != null
          ? List<String>.from(json['Fragrance'])
          : null,
    );
  }
}

