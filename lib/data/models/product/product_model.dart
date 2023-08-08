class ProductModel {
  String? sId;
  String? category;
  int? price;
  List<String>? images;
  String? title;
  String? description;
  String? updatedOn;

  ProductModel(
      {this.sId,
      this.category,
      this.price,
      this.images,
      this.title,
      this.description,
      this.updatedOn});

  ProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    category = json['category'];
    price = json['price'];
    images = json['images'].cast<String>();
    title = json['title'];
    description = json['description'];
    updatedOn = json['updatedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['category'] = category;
    data['price'] = price;
    data['images'] = images;
    data['title'] = title;
    data['description'] = description;
    data['updatedOn'] = updatedOn;
    return data;
  }
}
