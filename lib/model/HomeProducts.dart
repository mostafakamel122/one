class HomeProducts {
  int? itemId;
  int? itemCat;
  String? itemName;
  String? itemDesc;
  String? itemImg;
  int? itemPrice;
  int? itemDiscount;
  int? itemCountView;
  double? itemLat;
  double? itemLong;
  int? isAuctions;
  double? auctionsPrice;
  String? auctionsEndTime;
  String? itemTime;
  int? likes_count;

  HomeProducts(
      {this.itemId,
      this.itemCat,
      this.itemName,
      this.itemDesc,
      this.itemImg,
      this.itemPrice,
      this.itemDiscount,
      this.itemCountView,
      this.itemLat,
      this.itemLong,
      this.isAuctions,
      this.auctionsPrice,
      this.auctionsEndTime,
      this.itemTime,
      this.likes_count});

  HomeProducts.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    itemCat = json['item_cat'];
    itemName = json['item_name'];
    itemDesc = json['item_desc'];
    itemImg = json['item_img'];
    itemPrice = json['item_price'];
    itemDiscount = json['item_discount'];
    itemCountView = json['item_countView'];
    itemLat = json['item_lat'];
    itemLong = json['item_long'];
    isAuctions = json['isAuctions'];
    auctionsPrice = json['AuctionsPrice'];
    auctionsEndTime = json['AuctionsEndTime'];
    itemTime = json['item_time'];
    likes_count = json['likes_count'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['item_cat'] = this.itemCat;
    data['item_name'] = this.itemName;
    data['item_desc'] = this.itemDesc;
    data['item_img'] = this.itemImg;
    data['item_price'] = this.itemPrice;
    data['item_discount'] = this.itemDiscount;
    data['item_countView'] = this.itemCountView;
    data['item_lat'] = this.itemLat;
    data['item_long'] = this.itemLong;
    data['isAuctions'] = this.isAuctions;
    data['AuctionsPrice'] = this.auctionsPrice;
    data['AuctionsEndTime'] = this.auctionsEndTime;
    data['item_time'] = this.itemTime;
    return data;
  }
}
