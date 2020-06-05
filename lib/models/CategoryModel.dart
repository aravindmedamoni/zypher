
class Category {
  String displayName;
  String categoryImageURL;
  String categoryName;

  Category({this.displayName, this.categoryImageURL, this.categoryName});

  Category.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    categoryImageURL = json['categoryImageURL'];
    categoryName = json['categoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayName'] = this.displayName;
    data['categoryImageURL'] = this.categoryImageURL;
    data['categoryName'] = this.categoryName;
    return data;
  }
}
