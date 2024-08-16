import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanchalak/models/index.dart';
import 'package:sanchalak/route_logger.dart';
import 'package:sanchalak/routes.dart';
import 'package:sanchalak/screens/index.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? lastRoute = prefs.getString('lastRoute') ?? Routes.splashScreen;

  runApp(MainApp(initialRoute: lastRoute));
}

class MainApp extends StatelessWidget {
  final String initialRoute;

  const MainApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RouteLogger routes = new RouteLogger();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthModel()),
        ChangeNotifierProvider(create: (_) => UserModel()),
      ],
      child: MaterialApp(
        title: 'Sanchalak',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorObservers: [routes],
        initialRoute: Routes.splashScreen,
        routes: {
          Routes.login: (context) => const LoginScreen(),
          Routes.home: (context) =>  HomeScreen(),
          Routes.splashScreen: (context) => const SplashScreen(),
          Routes.signUp: (context) => const SignUpScreen(),
          //signUp
        },
      ),
    );
  }
}
