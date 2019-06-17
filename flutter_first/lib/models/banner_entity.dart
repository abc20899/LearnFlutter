class BannerEntity {
  int code;
  BannerData data;
  String message;

  BannerEntity({this.code, this.data, this.message});

  BannerEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new BannerData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class BannerData {
  int isDelete;
  String name;
  List<BannerDataAdlist> adList;
  int id;

  BannerData({this.isDelete, this.name, this.adList, this.id});

  BannerData.fromJson(Map<String, dynamic> json) {
    isDelete = json['isDelete'];
    name = json['name'];
    if (json['adList'] != null) {
      adList = new List<BannerDataAdlist>();
      (json['adList'] as List).forEach((v) {
        adList.add(new BannerDataAdlist.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isDelete'] = this.isDelete;
    data['name'] = this.name;
    if (this.adList != null) {
      data['adList'] = this.adList.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}

class BannerDataAdlist {
  String img;
  int isDelete;
  String stores;
  String maxVersion;
  int orders;
  int id;
  int beginTime;
  int endTime;
  String title;
  int type;
  String url;
  int adPositionId;

  BannerDataAdlist(
      {this.img,
      this.isDelete,
      this.stores,
      this.maxVersion,
      this.orders,
      this.id,
      this.beginTime,
      this.endTime,
      this.title,
      this.type,
      this.url,
      this.adPositionId});

  BannerDataAdlist.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    isDelete = json['isDelete'];
    stores = json['stores'];
    maxVersion = json['maxVersion'];
    orders = json['orders'];
    id = json['id'];
    beginTime = json['beginTime'];
    endTime = json['endTime'];
    title = json['title'];
    type = json['type'];
    url = json['url'];
    adPositionId = json['adPositionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img'] = this.img;
    data['isDelete'] = this.isDelete;
    data['stores'] = this.stores;
    data['maxVersion'] = this.maxVersion;
    data['orders'] = this.orders;
    data['id'] = this.id;
    data['beginTime'] = this.beginTime;
    data['endTime'] = this.endTime;
    data['title'] = this.title;
    data['type'] = this.type;
    data['url'] = this.url;
    data['adPositionId'] = this.adPositionId;
    return data;
  }
}
