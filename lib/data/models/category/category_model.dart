class CategoryModel {
  String? sId;
  String? title;
  String? description;
  String? updatedOn;
  int? iV;

  CategoryModel(
      {this.sId, this.title, this.description, this.updatedOn, this.iV});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    updatedOn = json['updatedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['updatedOn'] = this.updatedOn;
    return data;
  }
}
