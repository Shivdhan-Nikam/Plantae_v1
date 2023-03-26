import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:plantae/providers/user_provider.dart';
import 'package:plantae/responsive/mobilescreenlayout.dart';
import 'package:plantae/responsive/responsive_layout_screen.dart';
import 'package:plantae/responsive/webscreenlayout.dart';
import 'package:plantae/screens/login_screen.dart';
import 'package:plantae/screens/sigup_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAoadyd-lAY3PKpUwTwqbVfKS2laPUXq60",
          appId: "1:146797502662:web:1e690bec36bf3a469ff7c7",
          messagingSenderId: "146797502662",
          projectId: "myplantapp-78216",
          storageBucket: "myplantapp-78216.appspot.com"),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => userProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          // home: const Scaffold(
          //   body:
          // ),
          home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return const responsiveLayout(
                      webScreenLayout: WebScreenLayout(),
                      mobileScreenLayout: MoblieScreenLayout(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  }
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  );
                }
                return LogInScreen();
              }),
        ));
  }
}
