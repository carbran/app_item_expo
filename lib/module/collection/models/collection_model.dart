import 'package:item_expo/module/collection/models/category_model.dart';

class CollectionModel {
  int? id;
  String? name;
  int? userId;
  List<CategoryModel>? categories;

  CollectionModel({
    this.id,
    this.name,
    this.userId,
    this.categories,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      id: json['id'],
      name: json['name'],
      userId: json['user_id'],
      categories: json['categories'] != null
          ? (json['categories'] as List<dynamic>)
              .map((e) => CategoryModel.fromJson(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'user_id': userId,
      'categories': categories?.map((category) => category.toJson()).toList(),
    };
  }
}
