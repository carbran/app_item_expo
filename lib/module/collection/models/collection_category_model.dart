import 'package:item_expo/module/collection/models/category_model.dart';
import 'package:item_expo/module/collection/models/collection_model.dart';

class CollectionCategory {
  int? id;
  int? collectionId;
  int? categoryId;
  CollectionModel? collection;
  CategoryModel? category;

  CollectionCategory({
    required this.id,
    required this.collectionId,
    required this.categoryId,
    this.collection,
    this.category,
  });

  factory CollectionCategory.fromJson(Map<String, dynamic> json) {
    return CollectionCategory(
      id: json['id'],
      collectionId: json['collection_id'],
      categoryId: json['category_id'],
      collection: json['collection'] != null
          ? CollectionModel.fromJson(json['collection'])
          : null,
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'collection_id': collectionId,
      'category_id': categoryId,
      'collection': collection?.toJson(),
      'category': category?.toJson(),
    };
  }
}
