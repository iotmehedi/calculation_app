import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppOpenAdManager {
  AppOpenAd? _appOpenAd;
  bool _isAdAvailable = false;

  // Load App Open Ad
  void loadAd() {
    AppOpenAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/9257395921', // Replace with your Ad Unit ID
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          _appOpenAd?.show();
          _isAdAvailable = true;
          print('App Open Ad Loaded');
        },
        onAdFailedToLoad: (error) {
          print('Failed to load App Open Ad: $error');
        },
      ),
    );
  }

  // Show the App Open Ad
  void showAdIfAvailable() {
    if (_isAdAvailable && _appOpenAd != null) {
      _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          print('App Open Ad Dismissed');
          _appOpenAd = null;
          _isAdAvailable = false;
          loadAd(); // Load the next ad
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          print('Failed to show App Open Ad: $error');
        },
      );
      _appOpenAd!.show();
    } else {
      print('Ad is not ready to be shown.');
    }
  }
  void dispose() {
    _appOpenAd?.dispose();
  }
}
