// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
    displayName: json['displayName'] as String,
    categoryImageURL: json['categoryImageURL'] as String,
    categoryName: json['categoryName'] as String,
  );
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'displayName': instance.displayName,
      'categoryImageURL': instance.categoryImageURL,
      'categoryName': instance.categoryName,
    };
