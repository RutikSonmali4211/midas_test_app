// import 'package:firebase_core/firebase_core.dart';
// import 'package:get/get.dart';
// // import 'package:midas/constant/app_lifecycle.dart';
// import 'package:midas/controller/device_token/device_token_controller.dart';
// import 'package:midas/controller/user/user_controller.dart';
// import 'package:midas/screen/loading/loading.dart';
// import 'package:midas/screen/sign_in/sign_in.dart';
// import 'package:midas/storage/local_storage.dart';
// import 'package:device_preview/device_preview.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// UserController userController = Get.put(UserController());
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   // WidgetsBinding.instance.addObserver(AppLifecycleObserver());
//   await LocalStorage.init();
//   String? deviceToken = await DeviceTokenController.getDeviceToken();
//   LocalStorage.setDeviceToken(deviceToken!);
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
//   String? token = LocalStorage.getToken();
//   // runApp(
//   //   DevicePreview(
//   //     enabled: true,
//   //     tools: const [
//   //       ...DevicePreview.defaultTools,
//   //     ],
//   //     builder: (context) => MyApp(token: token),
//   //   ),
//   // );
//   runApp(
//     MyApp(token: token),
//   );
// }

// class MyApp extends StatefulWidget {
//   final token;

//   const MyApp({
//     @required this.token,
//     Key? key,
//   }) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(seconds: 3), () {
//       setState(() {
//         _isLoading = false;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       locale: DevicePreview.locale(context),
//       builder: DevicePreview.appBuilder,
//       debugShowCheckedModeBanner: false,
//       title: 'Simplifin',
//       theme: ThemeData(
//         primaryColor: Colors.white,
//         scaffoldBackgroundColor: Colors.white,
//         textTheme: const TextTheme(),
//       ),
//       home: _isLoading
//           ? const LoadingScreen()
//           // : (widget.token != null &&
//           //         JwtDecoder.isExpired(widget.token) == false)
//               // ? const BottomNevbar()
//               : const SignInScreen(),
//     );
//   }
// }

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simplifin',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
