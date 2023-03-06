import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:europe_license_theory/utilities/rest_api_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ServiceLogin {
  static var time_out = const Duration(seconds: 20);
  static var client = http.Client();

// static Future<ModelInvoiceTemplates> GetDevInvoiceTemplate(
//     String p_dir, String localization) async {
//   try {
//     Map<String, String> _header = {
//       'Content-Type': "application/x-www-form-urlencoded",
//       'Accept': 'application/json',
//       'P-dir': p_dir,
//       'X-localization': localization,
//       'app-name': Platform.isAndroid ? 'android' : "IOS",
//     };
//
//     var response = await client
//         .get(Uri.parse(RestApiUtils.dev_invoice_templates), headers: _header)
//         .timeout(time_out);
//
//     RestApiUtils.GetPrintHeaderBody(
//         RestApiUtils.dev_invoice_templates, _header, null, response);
//
//     if (response.statusCode == 200) {
//       final _model = modelInvoiceTemplatesFromMap(response.body);
//       if (_model.status == 200) {
//         return _model;
//       } else {
//         return ModelInvoiceTemplates(
//             status: _model.status,
//             message: _model.message,
//             invoiceTemplates: []);
//       }
//     } else {
//       return ModelInvoiceTemplates(
//           status: response.statusCode,
//           message: RestApiUtils.GetResponse(response.statusCode),
//           invoiceTemplates: []);
//     }
//   } on TimeoutException catch (_) {
//     return ModelInvoiceTemplates(
//         status: 408,
//         message: RestApiUtils.GetResponse(408),
//         invoiceTemplates: []);
//   } on SocketException {
//     return ModelInvoiceTemplates(
//         status: 501,
//         message: RestApiUtils.GetResponse(501),
//         invoiceTemplates: []);
//   } catch (ex) {
//     return ModelInvoiceTemplates(
//         status: 510, message: ex.toString(), invoiceTemplates: []);
//   }
// }

// static Future<ModelInvoiceTemplates> GetDevInvoiceOrignalTemplate(
//     int id, String p_dir, String localization) async {
//   try {
//     Map<String, String> _header = {
//       "Content-Type": 'charset=utf-8',
//       'Accept': 'application/json',
//       'P-dir': p_dir,
//       // "Host": "",
//       'X-localization': localization,
//     };
//
//     var response = await client
//         .get(
//           Uri.parse("${RestApiUtils.dev_invoice_template_original}/${id}"),
//           headers: _header,
//         )
//         .timeout(time_out);
//
//     print("BodyResponse response request ${response.request!.toString()}");
//     print(
//         "BodyResponse response request ${response.request!.headers.toString()}");
//     // print("BodyResponse  response request ${response.statusCode}");
//     // print("BodyResponse  response request ${response.headers}");
//
//     RestApiUtils.GetPrintHeaderBody(
//         "${RestApiUtils.dev_invoice_template_original}/${id}",
//         _header,
//         null,
//         response);
//
//     if (response.statusCode == 200) {
//       return ModelInvoiceTemplates(
//           status: response.statusCode,
//           message: response.body,
//           invoiceTemplates: []);
//     } else {
//       return ModelInvoiceTemplates(
//           status: response.statusCode,
//           message: RestApiUtils.GetResponse(response.statusCode),
//           invoiceTemplates: []);
//     }
//   } on TimeoutException catch (_) {
//     return ModelInvoiceTemplates(
//         status: 408,
//         message: RestApiUtils.GetResponse(408),
//         invoiceTemplates: []);
//   } on SocketException {
//     return ModelInvoiceTemplates(
//         status: 501,
//         message: RestApiUtils.GetResponse(501),
//         invoiceTemplates: []);
//   } catch (ex) {
//     print("modelClass error : ${ex.toString()}");
//
//     return ModelInvoiceTemplates(
//         status: 510, message: ex.toString(), invoiceTemplates: []);
//   }
// }

// static Future<ModelInvoiceTemplates> GetInvoiceTemplate(
//     BuildContext context) async {
//   String XElocalization = await ConstantFunctions.GetXElocalization(context);
//
//   try {
//     Map<String, String> _header = {
//       'Content-Type': "application/x-www-form-urlencoded",
//       'Accept': 'application/json',
//       'P-dir': context.locale.languageCode == "ar" ? "rtl" : 'ltr',
//       'X-localization': '${XElocalization}',
//       'app-name': Platform.isAndroid ? 'android' : "IOS",
//     };
//
//     var response = await client
//         .get(Uri.parse(RestApiUtils.invoice_templates), headers: _header)
//         .timeout(time_out);
//
//     RestApiUtils.GetPrintHeaderBody(
//         RestApiUtils.invoice_templates, _header, null, response);
//
//     if (response.statusCode == 200) {
//       final _model = modelInvoiceTemplatesFromMap(response.body);
//       if (_model.status == 200) {
//         return _model;
//       } else {
//         return ModelInvoiceTemplates(
//             status: _model.status,
//             message: _model.message,
//             invoiceTemplates: []);
//       }
//     } else {
//       return ModelInvoiceTemplates(
//           status: response.statusCode,
//           message: RestApiUtils.GetResponse(response.statusCode),
//           invoiceTemplates: []);
//     }
//   } on TimeoutException catch (_) {
//     return ModelInvoiceTemplates(
//         status: 408,
//         message: RestApiUtils.GetResponse(408),
//         invoiceTemplates: []);
//   } on SocketException {
//     return ModelInvoiceTemplates(
//         status: 501,
//         message: RestApiUtils.GetResponse(501),
//         invoiceTemplates: []);
//   } catch (ex) {
//     return ModelInvoiceTemplates(
//         status: 510, message: ex.toString(), invoiceTemplates: []);
//   }
// }
//
// static Future<ModelInvoiceTemplates> GetInvoiceOrignalTemplate(
//     BuildContext context, ModelInvoice modelInvoice) async {
//   String XElocalization = await ConstantFunctions.GetXElocalization(context);
//   try {
//     Map<String, String> _header = {
//       'Content-Type': "application/x-www-form-urlencoded",
//       'Accept': 'application/json',
//       'P-dir': context.locale.languageCode == "ar" ? "rtl" : 'ltr',
//       'X-localization': '${XElocalization}',
//       'app-name': Platform.isAndroid ? 'android' : "ios",
//     };
//
//     List<Map<String, String>> list_invoice_items = [];
//     List<Map<String, String>> list_invoice_payment = [];
//
//     if (modelInvoice.modelPayment != null) {
//       list_invoice_payment.add(modelInvoice.modelPayment!.toJson());
//       // print("objectobjectobject: 2 ${list_invoice_payment.toString()}");
//     }
//
//     modelInvoice.list_item.forEach((element) {
//       Map<String, String> map = {
//         jsonEncode("name"): jsonEncode("${element.name}"),
//         jsonEncode("description"): jsonEncode("${element.description}"),
//         jsonEncode("quantity"): jsonEncode("${element.quantity.toString()}"),
//         jsonEncode("price"): jsonEncode("${element.price}"),
//         jsonEncode("discount"): jsonEncode("${element.discount.toString()}"),
//         jsonEncode("discount_type"): jsonEncode("${element.discount_type}"),
//         jsonEncode("item_total"): jsonEncode("${element.final_price}"),
//         if (element.tax_rate > 0)
//           jsonEncode("tax"): "${jsonEncode(element.tax_rate.toString())}",
//       };
//       list_invoice_items.add(map);
//     });
//
//     // print("objectobjectobject: 2 ${list_invoice_items.toString()}");
//
//     Map<String, String> map = Map();
//     map["id"] = "${modelInvoice.template_index}";
//     map["invoice_number"] = "${modelInvoice.modelInvoiceInfo.invoice_number}";
//     map["invoice_items"] = list_invoice_items.toString();
//     if (modelInvoice.modelBusiness.logo != null &&
//         modelInvoice.modelBusiness.logo != "") {
//       map["logo"] =
//           "data:image/png;base64,${modelInvoice.modelBusiness.logo}";
//     }
//     if (modelInvoice.modelBusiness.stamp != null &&
//         modelInvoice.modelBusiness.stamp != "") {
//       map["stamp"] =
//           "data:image/png;base64,${modelInvoice.modelBusiness.stamp}";
//     }
//     if (modelInvoice.modelBusiness.signature != null &&
//         modelInvoice.modelBusiness.signature != "") {
//       map["signature"] =
//           "data:image/png;base64,${modelInvoice.modelBusiness.signature}";
//     }
//     map["zip_code"] = "";
//     if (modelInvoice.modelBusiness.billingAddress1 != "") {
//       map["address"] = "${modelInvoice.modelBusiness.billingAddress1}";
//     }
//
//     map["city"] = "${modelInvoice.modelBusiness.billingAddress2}";
//     map["country"] = "${modelInvoice.modelBusiness.country}";
//     map["email"] = "${modelInvoice.modelBusiness.email}";
//     map["website"] = "${modelInvoice.modelBusiness.website}";
//     map["business_name"] = "${modelInvoice.modelBusiness.business_name}";
//     map["from_name"] = "${modelInvoice.modelBusiness.name}";
//     map["from_designation"] = "${modelInvoice.modelBusiness.designation}";
//     map["contact_no"] = "${modelInvoice.modelBusiness.phone}";
//     map["terms"] = "${modelInvoice.terms}";
//     map["other_notes"] = "${modelInvoice.other_notes}";
//     map["bill_to"] = "${modelInvoice.modelCustomer.name}";
//     map["contact_no_to"] = "${modelInvoice.modelCustomer.phone}";
//     if (modelInvoice.modelCustomer.billingAddress2 != "") {
//       map["ship_to"] = "${modelInvoice.modelCustomer.billingAddress2}";
//     }
//     if (modelInvoice.modelCustomer.billingAddress1 != "") {
//       map["bill_to_address"] =
//           "${modelInvoice.modelCustomer.billingAddress1}";
//     }
//     map["dated"] = "${modelInvoice.modelInvoiceInfo.current_date}";
//     map["due_date"] = "${modelInvoice.modelInvoiceInfo.due_date}";
//     map["currency_symbol"] =
//         "${modelInvoice.modelSetting.modelCountry.currency_symbol}";
//     map["total_amount"] = "${modelInvoice.payment_total.toStringAsFixed(2)}";
//     if (modelInvoice.modelDiscount.discount > 0) {
//       map["discount"] = "${modelInvoice.modelDiscount.discount}";
//     }
//     if (modelInvoice.modelTax.tax_rate > 0) {
//       map["tax"] = "${modelInvoice.modelTax.tax_rate}";
//       map["tax_amount"] = "${modelInvoice.tax_ontotal.toStringAsFixed(2)}";
//     }
//     map["discount_type"] =
//         modelInvoice.modelDiscount.type == "Fixed" ? "fixed" : "percentage";
//     // map["total"] = "${modelInvoice.total_before_discount.toStringAsFixed(2)}";
//     map["sub_total"] =
//         "${modelInvoice.total_before_discount.toStringAsFixed(2)}";
//     map["tax_label"] = "${modelInvoice.modelTax.tax_lable}";
//     map["grand_total"] = "${modelInvoice.payment_total.toStringAsFixed(2)}";
//     if (modelInvoice.modelPaymentReceived.amount > 0) {
//       map["amount_paid"] = "${modelInvoice.modelPaymentReceived.amount}";
//     }
//
//     map["due_amount"] = "${modelInvoice.payment_due.toStringAsFixed(2)}";
//     map["description"] = "";
//     if (modelInvoice.modelDeliveryCharges.amount > 0) {
//       map["shipment_charges"] = "${modelInvoice.modelDeliveryCharges.amount}";
//     }
//
//     map["is_paid"] = "${modelInvoice.isPaid}";
//     if (list_invoice_payment.length > 0) {
//       map["payment_methods"] = "${jsonEncode(list_invoice_payment)}";
//     }
//     if (modelInvoice.font_id != "" && modelInvoice.font_id != null) {
//       map["font_famlily_id"] = "${modelInvoice.font_id}";
//     }
//     if (modelInvoice.color_id != "" && modelInvoice.color_id != null) {
//       map["color_scheme_id"] = "${modelInvoice.color_id}";
//     }
//     if (modelInvoice.font_size != "" && modelInvoice.font_size != null) {
//       map["font_size"] = "${modelInvoice.font_size}";
//     }
//
//     // print("objectobjectobject: 1 template_index : id ${map["id"]}");
//     // print("objectobjectobject: 1 font_id ${map["font_famlily_id"]}");
//     // print("objectobjectobject: 1 color_id ${map["color_scheme_id"]}");
//     // print("objectobjectobject: 1 font_size ${map["font_size"]}");
//     // print("objectobjectobject: 1 map ${map.toString()}");
//
//     // map["id"] = "${modelInvoice.template_index}";
//
//     var response = await client
//         .post(Uri.parse(RestApiUtils.invoice_template_original),
//             headers: _header, body: map)
//         .timeout(time_out);
//
//     print("reasonPhrase request ${response.request!.url.toString()}");
//     // print("reasonPhrase request ${response.request.toString()}");
//     print("reasonPhrase headers ${response.headers.toString()}");
//     print("reasonPhrase reasonPhrase ${response.reasonPhrase}");
//     print("reasonPhrase request!.headers ${response.request!.headers}");
//
//
//     // RestApiUtils.GetPrintHeaderBody(
//     //     RestApiUtils.invoice_template_original, _header, map, response);
//
//     if (response.statusCode == 200) {
//       return ModelInvoiceTemplates(
//           status: response.statusCode,
//           message: response.body,
//           // message: response.request!.url.toString(),
//           invoiceTemplates: []);
//     } else {
//       return ModelInvoiceTemplates(
//           status: response.statusCode,
//           message: RestApiUtils.GetResponse(response.statusCode),
//           invoiceTemplates: []);
//     }
//   } on TimeoutException catch (_) {
//     return ModelInvoiceTemplates(
//         status: 408,
//         message: RestApiUtils.GetResponse(408),
//         invoiceTemplates: []);
//   } on SocketException {
//     return ModelInvoiceTemplates(
//         status: 501,
//         message: RestApiUtils.GetResponse(501),
//         invoiceTemplates: []);
//   } catch (ex) {
//     print("modelClass error : ${ex.toString()}");
//
//     return ModelInvoiceTemplates(
//         status: 510, message: ex.toString(), invoiceTemplates: []);
//   }
// }
//
//
//
//
//
// static Future<ModelInvoiceTemplates> GetDummyTemplate(
//     BuildContext context, String template_id, String color_scheme_id, String font_family_id, String font_size) async {
//   String XElocalization = await ConstantFunctions.GetXElocalization(context);
//   try {
//     Map<String, String> _header = {
//       'Content-Type': "application/x-www-form-urlencoded",
//       'Accept': 'application/json',
//       'P-dir': context.locale.languageCode == "ar" ? "rtl" : 'ltr',
//       'X-localization': '${XElocalization}',
//       'app-name': Platform.isAndroid ? 'android' : "ios",
//     };
//
//     String color = "";
//     String font_family = "";
//     String size = "";
//
//     if(color_scheme_id != "") {
//       color = "?color_scheme_id=$color_scheme_id";
//     }
//     if(font_family_id != "") {
//       font_family = "&font_family_id=$font_family_id";
//     }
//     if(font_size != "") {
//       size = "&font_size=$font_size";
//     }
//
//     http://cv.sidrafoundation.pk/api/localized-invoice-template-dummy/3?color_scheme_id=3&font_family_id=1&font_size=small
//
//     http://cv.sidrafoundation.pk/api/localized-invoice-template-dummy/3?color_scheme_id=3&font_family_id=1&font_size=small
//     // static final String invoice_template_dummy = "http://cv.sidrafoundation.pk/api/localized-invoice-template-dummy/";
//
//     String urrl = "${RestApiUtils.invoice_template_dummy}${template_id}${color}${font_family}${size}";
//
//     var response = await client
//         .get(Uri.parse(urrl),
//         headers: _header)
//         .timeout(time_out);
//
//     RestApiUtils.GetPrintHeaderBody(
//         urrl, _header, null, response);
//
//     if (response.statusCode == 200) {
//       return ModelInvoiceTemplates(
//           status: response.statusCode,
//           message: response.body,
//           invoiceTemplates: []);
//     } else {
//       return ModelInvoiceTemplates(
//           status: response.statusCode,
//           message: RestApiUtils.GetResponse(response.statusCode),
//           invoiceTemplates: []);
//     }
//   } on TimeoutException catch (_) {
//     return ModelInvoiceTemplates(
//         status: 408,
//         message: RestApiUtils.GetResponse(408),
//         invoiceTemplates: []);
//   } on SocketException {
//     return ModelInvoiceTemplates(
//         status: 501,
//         message: RestApiUtils.GetResponse(501),
//         invoiceTemplates: []);
//   } catch (ex) {
//     print("modelClass error : ${ex.toString()}");
//
//     return ModelInvoiceTemplates(
//         status: 510, message: ex.toString(), invoiceTemplates: []);
//   }
// }

}
