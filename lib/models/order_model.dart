// ignore_for_file: non_constant_identifier_names

// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  String? id;
  List? data;
  // Timestamp? timestamp;
  OrderModel({
    required this.id,
    required this.data,
    // required this.timestamp,
  });
  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
