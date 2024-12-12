class ItemPictureModel {
  final int id;
  final int itemId;
  final String imageData;

  ItemPictureModel({
    required this.id,
    required this.itemId,
    required this.imageData,
  });

  factory ItemPictureModel.fromJson(Map<String, dynamic> json) {
    return ItemPictureModel(
      id: json['id'],
      itemId: json['item_id'],
      imageData: json['image_data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item_id': itemId,
      'image_data': imageData,
    };
  }
}
