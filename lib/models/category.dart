
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'category.g.dart';

@JsonSerializable(explicitToJson: true)
class Category extends Equatable{
  final String displayName;
  final String categoryImageURL;
  final String categoryName;
  Category({this.displayName, this.categoryImageURL, this.categoryName});

  factory Category.fromJson(Map<String,dynamic> jsonData) => _$CategoryFromJson(jsonData);

  Map<String,dynamic> toJson() => _$CategoryToJson(this);

  @override
  List<Object> get props => [displayName,categoryImageURL,categoryName];
}
