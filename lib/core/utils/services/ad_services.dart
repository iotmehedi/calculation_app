import 'package:calculation_app/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService extends GetxController {
  // Banner Ad Instance
  BannerAd? _bannerAd;
  var isBannerAdLoaded = false.obs;

  // Native Ad Instance
  NativeAd? _nativeAd;
  var isNativeAdLoaded = false.obs;

  // Initialize Mobile Ads SDK
  Future<void> initialize() async {
    await MobileAds.instance.initialize();
  }

  // Method to load a simple Banner Ad
  void loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', // Test ad unit ID
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          isBannerAdLoaded.value = true;
          print('Banner Ad loaded');
        },
        onAdFailedToLoad: (ad, error) {
          print('Banner Ad failed to load: $error');
          ad.dispose();
        },
      ),
    );
    _bannerAd!.load();
  }

  // Method to get Banner Ad Widget
  Widget getBannerAdWidget() {
    return Obx(() {
      if (isBannerAdLoaded.value && _bannerAd != null) {
        return Container(
          width: MediaQuery.of(navigatorKey.currentContext!).size.width,
          height: 50,
          child: AdWidget(ad: _bannerAd!),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }

  // Native Ad load
  void loadNativeAd() {
    _nativeAd = NativeAd(
      adUnitId: 'ca-app-pub-3940256099942544/2247696110', // Test ad unit ID
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          isNativeAdLoaded.value = true;
          print('Native Ad loaded');
        },
        onAdFailedToLoad: (ad, error) {
          print('Native Ad failed to load: $error');
          isNativeAdLoaded.value = false;
          ad.dispose();
        },
      ),
      request: const AdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
        mainBackgroundColor: Colors.purple,
        cornerRadius: 10.0,
        callToActionTextStyle: NativeTemplateTextStyle(
          textColor: Colors.cyan,
          backgroundColor: Colors.red,
          style: NativeTemplateFontStyle.monospace,
          size: 16.0,
        ),
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.red,
          backgroundColor: Colors.cyan,
          style: NativeTemplateFontStyle.italic,
          size: 16.0,
        ),
        secondaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.green,
          backgroundColor: Colors.black,
          style: NativeTemplateFontStyle.bold,
          size: 16.0,
        ),
        tertiaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.brown,
          backgroundColor: Colors.amber,
          style: NativeTemplateFontStyle.normal,
          size: 16.0,
        ),
      ),
    );
    _nativeAd?.load();
  }

  // Method to retrieve the Native Ad Widget
  Widget getNativeAdWidget() {
    return Obx(() {
      if (isNativeAdLoaded.value && _nativeAd != null) {
        return Container(
          width: double.infinity,
          height: 200,
          alignment: Alignment.center,
          child: AdWidget(ad: _nativeAd!),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }

  // Dispose of Ads
  @override
  void onClose() {
    _bannerAd?.dispose();
    _nativeAd?.dispose();
    super.onClose();
  }
}
