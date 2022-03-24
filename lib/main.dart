import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:user_gym_app/modules/dashboard/dashboard_screen.dart';
import 'package:user_gym_app/utility/common_methods.dart';

import 'controllers/appBinding/app_binding.dart';
import 'fcm_notification_service.dart';
import 'modules/login/login_screen.dart';
import 'modules/splash/splash_screen.dart';

final getPreferences = GetStorage();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  if (kDebugMode) {
    print('Handling a background message ${message.messageId}');
  }
}
Future<void> main() async {
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: () => GetMaterialApp(
            title: 'Gym ERP',
            theme: ThemeData(
              fontFamily: 'Poppins',
              highlightColor: Colors.white,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              canvasColor: Colors.white,
              textTheme: const TextTheme(caption: TextStyle(color: Colors.white)),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            builder: (context, widget) {
              return MediaQuery(
                //Setting font does not change with system font size
                data: MediaQuery.of(context).copyWith(textScaleFactor: 0.9),
                child: widget!,
              );
            },
            initialBinding: AppBinding(),
            debugShowCheckedModeBanner: false,
            home: const MyHomePage()
          // IntroSliders()
        )
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    ///region Push Notification
    FirebaseNotificationService.initializeService();
    localNotification();
    Future.delayed(const Duration(seconds: 2), () {
      if (getIsLogin()) {
        Get.to(() => const DashboardScreen());
      } else {
        Get.to(() => const LoginScreen());
      }
    });
  }

  static FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  localNotification() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = const IOSInitializationSettings();
    var initSettings = InitializationSettings(android: android, iOS: iOS);
    flutterLocalNotificationsPlugin!.initialize(initSettings, onSelectNotification: (String? payload) async {
      // var event = jsonDecode(payload!);
      // notificationTapDialog(type: event["data"]["type"],desc: event["body"],title: event["title"]);
      ///Handle tap here event["id"]
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashScreen(),
    );
  }
}
