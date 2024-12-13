class ItemPictureModel {
  int? id;
  int? itemId;
  String? imageData;

  ItemPictureModel({
    this.id,
    this.itemId,
    this.imageData,
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
