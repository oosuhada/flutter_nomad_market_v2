// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_nomad_market_v2/screens/chat_screen.dart';
import 'package:flutter_nomad_market_v2/screens/community_screen.dart';
import 'package:flutter_nomad_market_v2/screens/culture_guide_screen.dart';
import 'package:flutter_nomad_market_v2/screens/home_screen.dart';
import 'package:flutter_nomad_market_v2/screens/product_detail_screen.dart';
import 'package:flutter_nomad_market_v2/screens/safety_center_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nomad Market',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[50],
        textTheme: GoogleFonts.notoSansTextTheme(),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/product': (context) => const ProductDetailScreen(),
        '/chat': (context) => const ChatScreen(),
        '/community': (context) => const CommunityScreen(),
        '/culture-guide': (context) => const CultureGuideScreen(),
        '/safety-center': (context) => const SafetyCenterScreen(),
      },
    );
  }
}
