import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
// import 'package:midas/controller/device_token/device_token_controller.dart';
import 'package:midas/screen/loading/loading.dart';
import 'package:midas/screen/sign_in/sign_in.dart';
import 'package:midas/storage/local_storage.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await LocalStorage.init();
  // if (LocalStorage.getDeviceToken() == null) {
  //   String? deviceToken = await DeviceTokenController.getDeviceToken();
  //   LocalStorage.setDeviceToken(deviceToken!);
  // }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  String? token = LocalStorage.getToken();
  // runApp(
  //   DevicePreview(
  //     enabled: true,
  //     tools: const [
  //       ...DevicePreview.defaultTools,
  //     ],
  //     builder: (context) => MyApp(token: token),
  //   ),
  // );
  runApp(
    MyApp(token: token),
  );
}

class MyApp extends StatefulWidget {
  final token;

  const MyApp({
    @required this.token,
    Key? key,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'Simplifin',
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(),
      ),
      home: _isLoading
          ? const LoadingScreen()
          // : (widget.token != null &&
          //         JwtDecoder.isExpired(widget.token) == false)
          // ? const BottomNevbar()
          : const SignInScreen(),
    );
  }
}
