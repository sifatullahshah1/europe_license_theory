import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:invoice/app_theme_work/theme_colors.dart';
import 'package:invoice/app_theme_work/theme_texts.dart';
import 'package:invoice/app_theme_work/widgets_reusing.dart';
import 'package:invoice/app_theme_work/widgets_specific.dart';
import 'package:invoice/subscription/subscription_strings.dart';
import 'package:invoice/utilities/app_assets.dart';
import 'package:invoice/utilities/constant_functions.dart';
import 'package:invoice/utilities/links_utils.dart';
import 'package:invoice/utilities/rest_api_utils.dart';

class ScreenSubscription extends StatefulWidget {
  @override
  _ScreenSubscriptionState createState() => _ScreenSubscriptionState();
}

class _ScreenSubscriptionState extends State<ScreenSubscription> {
  bool is_purchased = false;
  void LoadPurchase() async {
    is_purchased = await ConstantFunctions.getSharePrefModebool("is_purchased");
  }

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  final bool isAndroid = Platform.isAndroid;

  // zayankhan321@gmail.com
  // Zayan@_786

  bool _available = true;
  bool is_product_found = false;
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  List<String> list_purchased = [];

  @override
  void initState() {
    _initialize();
    LoadPurchase();
    super.initState();
  }

  @override
  void dispose() {
    _subscription!.cancel();
    super.dispose();
  }

  void _initialize() async {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        await _inAppPurchase.purchaseStream;
    _purchases = [];
    _available = await _inAppPurchase.isAvailable();

    print("object_sifat before purchase ${purchaseUpdated.length}");

    _subscription = purchaseUpdated.listen(
      (purchaseDetailsList) {
        print("object_sadfasdf ${purchaseDetailsList}");

        _purchases.addAll(purchaseDetailsList);
        _listenToPurchaseUpdated(purchaseDetailsList);
      },
      onDone: () {
        setState(() {});
        _subscription!.cancel();
      },
      onError: (error) {
        _subscription!.cancel();
      },
    );
    print("object_sifat after purchase");
    GetAppProductDetails();
  }

  void GetAppProductDetails() async {
    ProductDetailsResponse response = await _inAppPurchase
        .queryProductDetails(isAndroid ? productids_android : productids_ios);

    response.productDetails.forEach((ProductDetails element) {
      _products.add(element);
      is_product_found = true;
    });

    setState(() {
      _products.sort((a, b) => a.rawPrice.compareTo(b.rawPrice));
    });
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      print("object_sifat ${purchaseDetails.status}");
      print("object_sifat ${purchaseDetails.productID}");
      switch (purchaseDetails.status) {
        case PurchaseStatus.pending:
          break;
        case PurchaseStatus.purchased:
          setState(() {
            is_purchased = true;
            ConstantFunctions.saveSharePrefModebool("is_purchased", true);
          });
          break;
        case PurchaseStatus.restored:
          // Navigator.pop(context);
          setState(() {
            is_purchased = true;
            ConstantFunctions.saveSharePrefModebool("is_purchased", true);
          });
          // WidgetsReusing.getSnakeBar(context, "Purchased restored");
          break;
          // bool valid = await _verifyPurchase(purchaseDetails);
          // if (!valid) {
          //   _handleInvalidPurchase(purchaseDetails);
          // }
          break;
        case PurchaseStatus.error:
          print("HelloError ${PurchaseStatus.error.name}");
          print("HelloError ${purchaseDetails.error!}");
          WidgetsReusing.getSnakeBar(context, "error");
          break;
        default:
          // Navigator.pop(context);
          // WidgetsReusing.getSnakeBar(context, "default");
          break;
      }

      if (purchaseDetails.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(purchaseDetails);
      }
    });
  }

  void _subscribe({required ProductDetails product}) async {
    try {
      RestApiUtils.ShowLoadingDialog(context);
      final PurchaseParam purchaseParam =
          await PurchaseParam(productDetails: product);
      _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
      Navigator.pop(context);
    } catch (e) {
      WidgetsReusing.getSnakeBar(context, "Subscription Error ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final bold_style = ThemeTexts.textStyleTitle2.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 17,
        fontFamily: ThemeTexts.BoldItalic);

    return Scaffold(
      backgroundColor: ThemeColors.background,
      // appBar: AppBar(backgroundColor: ThemeColors.background),
      body: _available
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width * 0.45,
                      decoration: BoxDecoration(
                          // color: Colors.red,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: Image.asset(
                                AppAssets.top_image,
                              ).image)),
                    ),
                    Positioned(
                      left: 20,
                      top: MediaQuery.of(context).size.width * 0.25,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: WidgetsSpecific.subscription_close,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(go_premium, style: bold_style),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GetCircle(no_ads),
                      GetCircle(unlimited_template),
                      GetCircle(cancel_anytime),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(choose_a_plan, style: bold_style),
                ),
                Expanded(
                  child: is_product_found
                      ? ListView(
                          padding: EdgeInsets.zero,
                          children: _products
                              .map((e) => Container(
                                    child: _buildProduct(product_item: e),
                                  ))
                              .followedBy([
                            Container(
                                child: Column(
                              children: [
                                SizedBox(height: 10),
                                WidgetsReusing.GetTextButtonWithTransparent(
                                    context, restore_purchase, () async {
                                  RestApiUtils.ShowLoadingDialog(context);
                                  await _inAppPurchase
                                      .restorePurchases()
                                      .then((value) {
                                    Navigator.pop(context);
                                  });

                                  // GestureTapCallback onRestore = () async {
                                  //   await _inAppPurchase.restorePurchases();
                                  //   Navigator.pop(context);
                                  // };
                                  //
                                  // List<String> ssss = ["Restore"];
                                  // List<GestureTapCallback> onTapList = [
                                  //   onRestore
                                  // ];
                                  //
                                  // WidgetsReusing.GetBottomSheetGeneral(context,
                                  //     "Restore Purchases ?", ssss, onTapList,
                                  //     message: "");
                                },
                                    EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 0)),
                                WidgetsReusing.GetTextButtonUnderLine(
                                    context, manage_purchase, () async {
                                  if (Platform.isIOS) {
                                    ConstantFunctions.OpenUrlSite(context,
                                        "https://apps.apple.com/account/subscriptions");
                                  } else {
                                    // will change according to app
                                    ConstantFunctions.OpenUrlSite(context,
                                        'https://play.google.com/store/account/subscriptions?sku=pro.monthly.testsku&package=codematics.easy.receiptmaker.invoicegenerator.salesinvoice');
                                  }
                                },
                                    EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 0)),
                                Platform.isIOS
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: Text(
                                          subscription_info,
                                          textAlign: TextAlign.justify,
                                        ),
                                      )
                                    : SizedBox(),
                                Platform.isIOS
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: InkWell(
                                          onTap: () {
                                            ConstantFunctions.OpenUrlSite(
                                                context,
                                                LinksUtils.subscription_link);
                                          },
                                          child: Text(
                                            term_of_use,
                                            style: ThemeTexts.textStyleTitle
                                                .copyWith(
                                                    color: ThemeColors
                                                        .primaryColor),
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                                SizedBox(height: 20),
                              ],
                            )),
                          ]).toList(),
                        )
                      : Container(
                          alignment: FractionalOffset(0.5, 0.2),
                          child: RestApiUtils.ShowLoadingView(context,
                              isBackgroundWhite: false),
                        ),
                ),
              ],
            )
          : RestApiUtils.ShowEmptyBoxLoadView(
              context,
              path: "",
              title: store_not_available,
            ),
    );
  }

  Widget _buildProduct({required ProductDetails product_item}) {

    print("objectobject _purchases = ${_purchases.length}");

    _purchases.forEach(
      (purchased_item) {
        if (product_item.id == purchased_item.productID &&
                purchased_item.status == PurchaseStatus.purchased ||
            purchased_item.status == PurchaseStatus.restored) {
          ConstantFunctions.saveSharePrefModebool("is_purchased", true);
          is_purchased = true;
          print("objectobject is_purchased = ${is_purchased}");

        }
      },
    );

    final text_style = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: is_purchased ? Colors.white : ThemeColors.primaryColor,
    );

    return InkWell(
      onTap: () {
        if (is_purchased) {
          WidgetsReusing.getSnakeBar(
              context, already_subscribed);
        } else {
          _subscribe(product: product_item);
        }
      },
      child: Stack(
        children: [
          Container(
            height: 60,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
              color:
                  is_purchased ? ThemeColors.primaryColor : Colors.transparent,
              border: Border.all(
                color: is_purchased ? Colors.white : ThemeColors.primaryColor,
                width: 1, //width of border
              ),
              borderRadius: BorderRadius.circular(0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text('${GetProductTitle(product_item.id)}',
                              style: text_style.copyWith(
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      GetProductDescription(product_item.id) != ""
                          ? Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                  '${GetProductDescription(product_item.id)}',
                                  style: text_style),
                            )
                          : SizedBox()
                    ],
                  ),
                ),
                is_purchased
                    ? CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.done,
                          color: ThemeColors.primaryColor,
                          size: 15,
                        ),
                      )
                    : Text(BUY, style: text_style),
              ],
            ),
          ),
          GetProductTitle(product_item.id).contains("Annually")
              ? Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    height: 60,
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: SvgPicture.asset(
                      AppAssets.subscription_star,
                      width: 40,
                      height: 40,
                    ),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }

  String GetProductTitle(String product_id) {
    if (product_id == productID_Y || product_id == productID_Y_ios) {
      return annually_title;
    } else if (product_id == productID_Q || product_id == productID_Q_ios) {
      return quarterly_title;
    } else if (product_id == productID_M || product_id == productID_M_ios) {
      return monthly_title;
    } else {
      return weekly_title;
    }
  }

  String GetProductDescription(String product_id) {
    if (product_id == productID_Y || product_id == productID_Y_ios) {
      return annually_description;
    } else if (product_id == productID_Q || product_id == productID_Q_ios) {
      return quarterly_description;
    } else if (product_id == productID_M || product_id == productID_M_ios) {
      return monthly_description;
    } else {
      return weekly_description;
    }
  }

  Widget GetCircle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          WidgetsSpecific.check_circle,
          SizedBox(width: 10),
          Text(
            '$title',
            style: ThemeTexts.textStyleTitle2.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: Colors.black,
                fontFamily: ThemeTexts.Light),
          )
        ],
      ),
    );
  }
}
