import 'package:api_use_ecomm/model/cart_model.dart';
import 'package:api_use_ecomm/screens/Auth/login_screen.dart';
import 'package:api_use_ecomm/screens/Auth/sign_up.dart';
import 'package:api_use_ecomm/screens/Cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:api_use_ecomm/screens/MainScreen/main_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      ChangeNotifierProvider(create: (context) => CartModel(),child: MyApp(),),
       );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce Application',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginScreen(),
      // home: MainScreen(favoriteProducts: []),
      routes: {
        '/cart' : (context) => CartScreen(),
      },// Pass an empty list or initial favorites
    );
  }
}
