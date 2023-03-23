
import 'package:flutter/material.dart';
import 'package:inapp_web_view/screen/provider/inapp_provider.dart';
import 'package:inapp_web_view/screen/view/inapp_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context)=>Inapp_view_provider(),)
  ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context) => inapp_view_screen(),
      },
    ),
  ),
  );
}