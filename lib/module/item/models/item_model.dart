import 'package:item_expo/module/item/models/item_picture_model.dart';

class ItemModel {
  int? id;
  int? collectionId;
  String? title;
  String? subtitle;
  String? author;
  DateTime? acquisitionDate;
  int? condition;
  String? size;
  int? sizeType;
  int? amount;
  List<ItemPictureModel>? pictures;

  ItemModel({
    this.id,
    this.collectionId,
    this.title,
    this.subtitle,
    this.author,
    this.acquisitionDate,
    this.condition,
    this.size,
    this.sizeType,
    this.amount,
    this.pictures,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      collectionId: json['collection_id'],
      title: json['title'],
      subtitle: json['subtitle'],
      author: json['author'],
      acquisitionDate: DateTime.parse(json['acquisition_date']),
      condition: json['condition'],
      size: json['size'],
      sizeType: json['size_type'],
      amount: json['amount'],
      pictures: json['pictures'] != null
          ? List<ItemPictureModel>.from(
              json['pictures'].map((picture) => ItemPictureModel.fromJson(picture)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'collection_id': collectionId,
      'title': title,
      'subtitle': subtitle,
      'author': author,
      'acquisition_date': acquisitionDate?.toIso8601String(),
      'condition': condition,
      'size': size,
      'size_type': sizeType,
      'amount': amount,
      'pictures': pictures?.map((picture) => picture.toJson()).toList(),
    };
  }
}
