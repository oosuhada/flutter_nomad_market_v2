import 'package:flutter/material.dart';

import 'data/demo_marketplace_data.dart';
import 'screens/chat_screen.dart';
import 'screens/culture_guide_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/safety_center_screen.dart';
import 'theme/nomad_theme.dart';
import 'v2/v2_glass.dart';

void main() {
  runApp(const NomadMarketApp());
}

class NomadMarketApp extends StatelessWidget {
  const NomadMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nomad Market',
      debugShowCheckedModeBanner: false,
      theme: V2GlassTheme.light(
        seed: NomadTheme.brand,
        background: NomadTheme.canvas,
        ink: NomadTheme.ink,
      ),
      darkTheme: V2GlassTheme.dark(seed: NomadTheme.brand),
      themeMode: ThemeMode.system,
      home: const OnboardingScreen(),
      routes: {
        '/product': (context) =>
            ProductDetailScreen(item: demoMarketplaceItems.first),
        '/chat': (context) => const ChatScreen(),
        '/culture-guide': (context) => const CultureGuideScreen(),
        '/safety-center': (context) => const SafetyCenterScreen(),
      },
    );
  }
}
