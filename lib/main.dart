import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:housing_society_management/constants.dart';
import 'package:http/http.dart' as http;

import 'package:housing_society_management/controllers/MenuAppController.dart';
// import 'package:housing_society_management/screens/election_screen.dart';
import 'package:housing_society_management/screens/login_screen.dart';
// import 'package:housing_society_management/screens/main/main_screen.dart';
// import 'package:housing_society_management/screens/property_screen.dart';
import 'package:housing_society_management/screens/register_screen.dart';
// import 'package:housing_society_management/screens/society_screen.dart';
import 'package:housing_society_management/screens/user_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  bool isConnected = await checkConnection();

  if (isConnected) {
    print('Connected to API');
  } else {
    print('Connection failed');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Housing Society Management',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      initialRoute: '/home',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        // '/home': (context) => MainScreen(),
        '/home': (context) => UserScreen(),
      },
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuAppController(),
          ),
        ],
        // child: MainScreen(),
        // child: UserScreen(),
        // child: PropertyScreen(),
        // child: ElectionScreen(),
        // child: SocietyScreen(),
      ),
    );
  }
}

Future<bool> checkConnection() async {
  try {
    final response =
        await http.get(Uri.parse('http://localhost:8000/api/users'));

    if (response.statusCode == 200) {
      // Connection successful
      return true;
    } else {
      // Connection failed
      return false;
    }
  } catch (e) {
    // Error occurred
    return false;
  }
}
