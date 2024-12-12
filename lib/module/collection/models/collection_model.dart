import 'package:item_expo/module/collection/models/category_model.dart';

class Collection {
  final int id;
  final String name;
  final int userId;
  final List<Category>? categories;

  Collection({
    required this.id,
    required this.name,
    required this.userId,
    this.categories,
  });

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      id: json['id'],
      name: json['name'],
      userId: json['user_id'],
      categories: json['categories'] != null
          ? List<Category>.from(
              json['categories'].map(
                (category) => Category.fromJson(category),
              ),
            )
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
