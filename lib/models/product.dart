// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class ProductModel {
  final String? id;
  final String? name;
  final int? numberLeft;
  final int? price;
  final List<String>? images;
  final String? description;
  final String? category_name;
  final String? category_id;
  ProductModel(
    this.id,
    this.name,
    this.images,
    this.category_id,
    this.category_name,
    this.description,
    this.numberLeft,
    this.price,
  );
  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}