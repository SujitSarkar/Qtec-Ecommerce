import 'dart:convert';

ProductDetailsModel productDetailsModelFromJson(String str) => ProductDetailsModel.fromJson(json.decode(str));

class ProductDetailsModel {
  ProductDetailsModel({
    this.status,
    this.statusCode,
    this.data,
    this.error,
  });

  String? status;
  dynamic statusCode;
  Data? data;
  String? error;

  factory ProductDetailsModel.fromJson(Map<String?, dynamic> json) => ProductDetailsModel(
    status: json["status"],
    statusCode: json["statusCode"],
    data: Data.fromJson(json["data"]),
    error: json["error"],
  );
}

class Data {
  Data({
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
  String? image;
  Charge? charge;
  List<ProductImage>? images;
  String? slug;
  String? productName;
  String? model;
  String? commissionType;
  String? amount;
  String? tag;
  String? description;
  String? note;
  String? embaddedVideoLink;
  dynamic maximumOrder;
  dynamic stock;
  bool? isBackOrder;
  String? specification;
  String? warranty;
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
  String? seller;
  dynamic combo;
  String? createdBy;
  dynamic updatedBy;
  List<int>? category;
  List<dynamic>? relatedProduct;
  List<dynamic>? filterValue;

  factory Data.fromJson(Map<String?, dynamic> json) => Data(
    id: json["id"],
    brand: Brand.fromJson(json["brand"]),
    image: json["image"],
    charge: Charge.fromJson(json["charge"]),
    images: List<ProductImage>.from(json["images"].map((x) => ProductImage.fromJson(x))),
    slug: json["slug"],
    productName: json["product_name"],
    model: json["model"],
    commissionType: json["commission_type"],
    amount: json["amount"],
    tag: json["tag"],
    description: json["description"],
    note: json["note"],
    embaddedVideoLink: json["embadded_video_link"],
    maximumOrder: json["maximum_order"],
    stock: json["stock"],
    isBackOrder: json["is_back_order"],
    specification: json["specification"],
    warranty: json["warranty"],
    preOrder: json["pre_order"],
    productReview: json["product_review"],
    isSeller: json["is_seller"],
    isPhone: json["is_phone"],
    willShowEmi: json["will_show_emi"],
    badge: json["badge"],
    isActive: json["is_active"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    language: json["language"],
    seller: json["seller"],
    combo: json["combo"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    category: List<int>.from(json["category"].map((x) => x)),
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

  String? name;
  String? image;
  dynamic headerImage;
  String? slug;

  factory Brand.fromJson(Map<String?, dynamic> json) => Brand(
    name: json["name"],
    image: json["image"],
    headerImage: json["header_image"],
    slug: json["slug"],
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

  factory Charge.fromJson(Map<String?, dynamic> json) => Charge(
    bookingPrice: json["booking_price"],
    currentCharge: json["current_charge"],
    discountCharge: json["discount_charge"],
    sellingPrice: json["selling_price"],
    profit: json["profit"],
    isEvent: json["is_event"],
    eventId: json["event_id"],
    highlight: json["highlight"],
    highlightId: json["highlight_id"],
    groupping: json["groupping"],
    grouppingId: json["groupping_id"],
    campaignSectionId: json["campaign_section_id"],
    campaignSection: json["campaign_section"],
    message: json["message"],
  );
}

class ProductImage {
  ProductImage({
    this.id,
    this.image,
    this.isPrimary,
    this.product,
  });

  dynamic id;
  String? image;
  bool? isPrimary;
  dynamic product;

  factory ProductImage.fromJson(Map<String?, dynamic> json) => ProductImage(
    id: json["id"],
    image: json["image"],
    isPrimary: json["is_primary"],
    product: json["product"],
  );
}
