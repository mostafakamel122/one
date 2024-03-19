class TransactionModel {
  int? walletTransactionId;
  int? from;
  int? to;
  int? basketTicket;
  String? status;
  int? percent;
  int? isCancel;
  String? time;
  String? userName;
  String? userImg;
  String? userPhone;

  TransactionModel(
      {this.walletTransactionId,
      this.from,
      this.to,
      this.basketTicket,
      this.status,
      this.percent,
      this.isCancel,
      this.time,
      this.userName,
      this.userImg,
      this.userPhone});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    walletTransactionId = json['WalletTransaction_id'];
    from = json['from'];
    to = json['to'];
    basketTicket = json['basketTicket'];
    status = json['status'];
    percent = json['percent'];
    isCancel = json['isCancel'];
    time = json['time'];
    userName = json['user_name'];
    userImg = json['user_img'];
    userPhone = json['user_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['WalletTransaction_id'] = this.walletTransactionId;
    data['from'] = this.from;
    data['to'] = this.to;
    data['basketTicket'] = this.basketTicket;
    data['status'] = this.status;
    data['percent'] = this.percent;
    data['isCancel'] = this.isCancel;
    data['time'] = this.time;
    data['user_name'] = this.userName;
    data['user_img'] = this.userImg;
    data['user_phone'] = this.userPhone;
    return data;
  }
}
