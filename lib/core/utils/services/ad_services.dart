import 'package:calculation_app/main.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  // Singleton Pattern for AdService
  static final AdService _instance = AdService._internal();
  factory AdService() {
    return _instance;
  }
  AdService._internal();

  // Banner Ad Instance
  BannerAd? _bannerAd;
  bool _isBannerAdLoaded = false;

  // Inline Adaptive Banner Ad Instance
  BannerAd? _inlineAdaptiveAd;
  bool _isInlineAdaptiveAdLoaded = false;

  // Initialize Mobile Ads SDK
  Future<void> initialize() async {
    await MobileAds.instance.initialize();
  }

  // Method to load a simple Banner Ad
  void loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', // Test ad unit ID
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          _isBannerAdLoaded = true;

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

  // Method to load an Inline Adaptive Banner Ad
  void loadInlineAdaptiveAd({required BuildContext context}) async {
    // Await the future to get the AdSize
    final AnchoredAdaptiveBannerAdSize? adaptiveSize = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
      MediaQuery.of(context).size.width.toInt(),
    );

    if (adaptiveSize == null) {
      print('Error: Failed to get Adaptive AdSize');
      return;
    }

    _inlineAdaptiveAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', // Test ad unit ID
      size: adaptiveSize, // Now using the awaited adaptiveSize
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          _isInlineAdaptiveAdLoaded = true;
          print('Inline Adaptive Banner Ad loaded');
        },
        onAdFailedToLoad: (ad, error) {
          print('Inline Adaptive Banner Ad failed to load: $error');
          ad.dispose();
        },
      ),
    );

    _inlineAdaptiveAd!.load();
  }


  // Method to get Banner Ad Widget
  Widget getBannerAdWidget() {
    if (_isBannerAdLoaded && _bannerAd != null) {
      return Container(
        width:  MediaQuery.of(navigatorKey.currentContext!).size.width,
        height:50,
        child: AdWidget(ad: _bannerAd!),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  // Method to get Inline Adaptive Banner Ad Widget
  Widget getInlineAdaptiveAdWidget() {
    if (_isInlineAdaptiveAdLoaded && _inlineAdaptiveAd != null) {
      return Container(
        width: MediaQuery.of(navigatorKey.currentContext!).size.width,
        height: 600,
        child: AdWidget(ad: _inlineAdaptiveAd!),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  // Dispose of Ads
  void disposeAds() {
    _bannerAd?.dispose();
    _inlineAdaptiveAd?.dispose();
  }
}
