class SubCat {
  int? subcategoriesId;
  int? subcategoriesIdCat;
  String? subcategoriesName;
  String? supportcountryTime;

  SubCat(
      {this.subcategoriesId,
      this.subcategoriesIdCat,
      this.subcategoriesName,
      this.supportcountryTime});

  SubCat.fromJson(Map<String, dynamic> json) {
    subcategoriesId = json['subcategories_id'];
    subcategoriesIdCat = json['subcategories_IdCat'];
    subcategoriesName = json['subcategoriesName'];
    supportcountryTime = json['supportcountry_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subcategories_id'] = this.subcategoriesId;
    data['subcategories_IdCat'] = this.subcategoriesIdCat;
    data['subcategoriesName'] = this.subcategoriesName;
    data['supportcountry_time'] = this.supportcountryTime;
    return data;
  }
}
