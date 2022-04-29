import 'dart:convert';

ProductListModel productListModelFromJson(String str) => ProductListModel.fromJson(json.decode(str));


class ProductListModel {
  ProductListModel({
    this.status,
    this.data,
  });

  dynamic status;
  Data? data;

  factory ProductListModel.fromJson(Map<dynamic, dynamic> json) => ProductListModel(
    status: json["status"].toString(),
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  Data({
    this.categories,
    this.products,
  });

  List<dynamic>? categories;
  Products? products;

  factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
    categories: List<dynamic>.from(json["categories"].map((x) => x)),
    products: Products.fromJson(json["products"]),
  );
}

class Products {
  Products({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  dynamic count;
  dynamic next;
  dynamic previous;
  List<Result>? results;

  factory Products.fromJson(Map<dynamic, dynamic> json) => Products(
    count: json["count"].toString(),
    next: json["next"],
    previous: json["previous"].toString(),
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );
}

class Result {
  Result({
    this.id,
    this.brand,
    this.image,
    this.charge,
    this.images,
    this.slug,
    this.productName,
    this.model,
    this.commissionType,
    this.amount,
    this.tag,
    this.description,
    this.note,
    this.embaddedVideoLink,
    this.maximumOrder,
    this.stock,
    this.isBackOrder,
    this.specification,
    this.warranty,
    this.preOrder,
    this.productReview,
    this.isSeller,
    this.isPhone,
    this.willShowEmi,
    this.badge,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.language,
    this.seller,
    this.combo,
    this.createdBy,
    this.updatedBy,
    this.category,
    this.relatedProduct,
    this.filterValue,
  });

  dynamic id;
  Brand? brand;
  dynamic image;
  Charge? charge;
  List<Image>? images;
  dynamic slug;
  dynamic productName;
  dynamic model;
  dynamic commissionType;
  dynamic amount;
  dynamic tag;
  dynamic description;
  dynamic note;
  dynamic embaddedVideoLink;
  dynamic maximumOrder;
  dynamic stock;
  bool? isBackOrder;
  dynamic specification;
  dynamic warranty;
  bool? preOrder;
  dynamic productReview;
  bool? isSeller;
  bool? isPhone;
  bool? willShowEmi;
  dynamic badge;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic language;
  dynamic seller;
  dynamic combo;
  dynamic createdBy;
  dynamic updatedBy;
  List<dynamic>? category;
  List<dynamic>? relatedProduct;
  List<dynamic>? filterValue;

  factory Result.fromJson(Map<dynamic, dynamic> json) => Result(
    id: json["id"].toString(),
    brand: Brand.fromJson(json["brand"]),
    image: json["image"].toString(),
    charge: Charge.fromJson(json["charge"]),
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    slug: json["slug"].toString(),
    productName: json["product_name"].toString(),
    model: json["model"].toString(),
    commissionType: json["commission_type"].toString(),
    amount: json["amount"].toString(),
    tag: json["tag"].toString(),
    description: json["description"].toString(),
    note: json["note"].toString(),
    embaddedVideoLink: json["embadded_video_link"].toString(),
    maximumOrder: json["maximum_order"].toString(),
    stock: json["stock"].toString(),
    isBackOrder: json["is_back_order"],
    specification: json["specification"].toString(),
    warranty: json["warranty"].toString(),
    preOrder: json["pre_order"],
    productReview: json["product_review"].toString(),
    isSeller: json["is_seller"],
    isPhone: json["is_phone"],
    willShowEmi: json["will_show_emi"],
    badge: json["badge"],
    isActive: json["is_active"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    language: json["language"],
    seller: json["seller"].toString(),
    combo: json["combo"],
    createdBy: json["created_by"].toString(),
    updatedBy: json["updated_by"],
    category: List<dynamic>.from(json["category"].map((x) => x)),
    relatedProduct: List<dynamic>.from(json["related_product"].map((x) => x)),
    filterValue: List<dynamic>.from(json["filter_value"].map((x) => x)),
  );
}

class Brand {
  Brand({
    this.name,
    this.image,
    this.headerImage,
    this.slug,
  });

  dynamic name;
  dynamic image;
  dynamic headerImage;
  dynamic slug;

  factory Brand.fromJson(Map<dynamic, dynamic> json) => Brand(
    name: json["name"].toString(),
    image: json["image"].toString(),
    headerImage: json["header_image"],
    slug: json["slug"].toString(),
  );
}

class Charge {
  Charge({
    this.bookingPrice,
    this.currentCharge,
    this.discountCharge,
    this.sellingPrice,
    this.profit,
    this.isEvent,
    this.eventId,
    this.highlight,
    this.highlightId,
    this.groupping,
    this.grouppingId,
    this.campaignSectionId,
    this.campaignSection,
    this.message,
  });

  dynamic bookingPrice;
  dynamic currentCharge;
  dynamic discountCharge;
  dynamic sellingPrice;
  dynamic profit;
  bool? isEvent;
  dynamic eventId;
  bool? highlight;
  dynamic highlightId;
  bool? groupping;
  dynamic grouppingId;
  dynamic campaignSectionId;
  bool? campaignSection;
  dynamic message;

  factory Charge.fromJson(Map<dynamic, dynamic> json) => Charge(
    bookingPrice: json["booking_price"].toString(),
    currentCharge: json["current_charge"].toString(),
    discountCharge: json["discount_charge"],
    sellingPrice: json["selling_price"].toString(),
    profit: json["profit"].toString(),
    isEvent: json["is_event"],
    eventId: json["event_id"],
    highlight: json["highlight"],
    highlightId: json["highlight_id"],
    groupping: json["groupping"],
    grouppingId: json["groupping_id"],
    campaignSectionId: json["campaign_section_id"],
    campaignSection: json["campaign_section"],
    message: json["message"].toString(),
  );
}

class Image {
  Image({
    this.id,
    this.image,
    this.isPrimary,
    this.product,
  });

  dynamic id;
  dynamic image;
  bool? isPrimary;
  dynamic product;

  factory Image.fromJson(Map<dynamic, dynamic> json) => Image(
    id: json["id"].toString(),
    image: json["image"].toString(),
    isPrimary: json["is_primary"],
    product: json["product"].toString(),
  );
  
}
