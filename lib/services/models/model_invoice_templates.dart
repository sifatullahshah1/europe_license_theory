// To parse this JSON data, do
//
//     final modelInvoiceTemplates = modelInvoiceTemplatesFromJson(jsonString);

import 'dart:convert';

ModelInvoiceTemplates modelInvoiceTemplatesFromMap(String str) =>
    ModelInvoiceTemplates.fromJson(json.decode(str));

String modelInvoiceTemplatesToJson(ModelInvoiceTemplates data) =>
    json.encode(data.toJson());

class ModelInvoiceTemplates {
  ModelInvoiceTemplates({
    required this.status,
    required this.message,
    required this.invoiceTemplates,
  });

  int status;
  String message;
  List<InvoiceTemplate> invoiceTemplates;

  factory ModelInvoiceTemplates.fromJson(Map<String, dynamic> json) =>
      ModelInvoiceTemplates(
        status: json["status"],
        message: json["message"],
        invoiceTemplates: List<InvoiceTemplate>.from(
            json["invoice_templates"].map((x) => InvoiceTemplate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "invoice_templates":
            List<dynamic>.from(invoiceTemplates.map((x) => x.toJson())),
      };
}

class InvoiceTemplate {
  InvoiceTemplate({
    this.id,
    this.title,
    this.description,
    this.hasLogo,
    this.hasStamp,
    this.hasSignature,
    this.isPremium,
    this.invoiceTemplateImage,
    this.invoiceProperties,
    this.invoiceFonts,
  });

  int? id;
  String? title;
  String? description;
  bool? hasLogo;
  bool? hasStamp;
  bool? hasSignature;
  bool? isPremium;
  String? invoiceTemplateImage;
  List<Invoice>? invoiceProperties;
  List<Invoice>? invoiceFonts;

  factory InvoiceTemplate.fromJson(Map<String, dynamic> json) =>
      InvoiceTemplate(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        hasLogo: json["has_logo"],
        hasStamp: json["has_stamp"],
        hasSignature: json["has_signature"],
        isPremium: json["is_premium"],
        invoiceTemplateImage: json["invoice_template_image"],
        invoiceProperties: List<Invoice>.from(
            json["invoice_properties"].map((x) => Invoice.fromJson(x))),
        invoiceFonts: List<Invoice>.from(
            json["invoice_fonts"].map((x) => Invoice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "has_logo": hasLogo,
        "has_stamp": hasStamp,
        "has_signature": hasSignature,
        "is_premium": isPremium,
        "invoice_template_image": invoiceTemplateImage,
        "invoice_properties":
            List<dynamic>.from(invoiceProperties!.map((x) => x.toJson())),
        "invoice_fonts":
            List<dynamic>.from(invoiceFonts!.map((x) => x.toJson())),
      };
}

class Invoice {
  Invoice({
    this.id,
    this.invoiceTemplateId,
    this.font_families,
    this.createdAt,
    this.updatedAt,
    this.color_schemes,
  });

  int? id;
  int? invoiceTemplateId;
  String? createdAt;
  String? updatedAt;
  List<ColorsSchemas>? font_families;
  List<ColorsSchemas>? color_schemes;

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        id: json["id"],
        invoiceTemplateId: json["invoice_template_id"],
        font_families: json["font_families"] == null
            ? null
            : List<ColorsSchemas>.from(
                json["font_families"].map((x) => ColorsSchemas.fromJson(x))),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        color_schemes: json["color_schemes"] == null
            ? null
            : List<ColorsSchemas>.from(
                json["color_schemes"].map((x) => ColorsSchemas.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "invoice_template_id": invoiceTemplateId,
        "font_families": font_families == null
            ? null
            : List<dynamic>.from(font_families!.map((x) => x.toJson())),
        "created_at": createdAt,
        "updated_at": updatedAt,
        "color_schemes": color_schemes == null
            ? null
            : List<dynamic>.from(color_schemes!.map((x) => x.toJson())),
      };
}

class ColorsSchemas {
  ColorsSchemas({
    this.key,
    this.value,
  });

  String? key;
  String? value;

  factory ColorsSchemas.fromJson(Map<String, dynamic> json) => ColorsSchemas(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };
}
