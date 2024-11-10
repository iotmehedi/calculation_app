import 'dart:async';

import 'package:calculation_app/core/routes/route_name.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/ad_manager/add_manager.dart';
import 'core/routes/router.dart';
late SharedPreferences prefs;
var internetCheck = true;
late ConnectivityService connectivityService;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
@pragma('vm:entry-point')
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  // Initialize Google Mobile Ads
  // await MobileAds.instance.initialize();
  connectivityService = ConnectivityService();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();

    super.dispose();
  }

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
    });
    // bool isConnected = _connectionStatus != ConnectivityResult.none;
    // ignore: avoid_print
    if(_connectionStatus.first == ConnectivityResult.none){
      internetCheck = false;
      await prefs.setBool("internet", false);
    }else{
      internetCheck = true;
      await prefs.setBool("internet", true);
    }
    print('Connectivity changed: ${_connectionStatus.first}');
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Calc-Xpert',
      initialRoute: Routes.splashScreenRouteName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: RouteGenerator.onRouteGenerate,
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
      // home: const SplashScreen(),
    );
  }
}
class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final ValueNotifier<bool> isConnected = ValueNotifier(false);

  ConnectivityService() {
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      return;
    }

    // if (!mounted) {
    //   return Future.value(null);
    // }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    // bool isConnected = _connectionStatus != ConnectivityResult.none;
    // ignore: avoid_print
bool hasInternet = false;
// bool connectionStatus = false;
//      connectionStatus = result.first != ConnectivityResult.none;
//

    if (result.first != ConnectivityResult.none) {
      // Check if the network has internet access
      hasInternet = await InternetConnection().hasInternetAccess;
    }
isConnected.value = hasInternet;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("internet", hasInternet);
    print('Connectivity changed: ${result.first}');
  }

  void dispose() {
    _connectivitySubscription.cancel();
  }
}



