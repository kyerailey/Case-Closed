import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// MODELS
import 'models/evidence_model.dart'; 

// PAGES
import 'death_row/background.dart'; 
import 'death_row/scene.dart';
import 'death_row/warrant.dart';

// ------------------------------
// COLOR PALETTE (Figma)
// ------------------------------
class AppColors {
  static const Color background = Color(0xFF0F202E); // Deep Navy
  static const Color surface = Color(0xFF243B53);    // Lighter Navy
  static const Color accent = Color(0xFFFF6B6B);     // Salmon Red
  static const Color textMain = Color(0xFFF5F7FA);   // Off-white
  static const Color buttonColor = Color(0xFF597D9D);// Steel Blue
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => EvidenceModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Case Closed",
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.surface,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          elevation: 0,
          titleTextStyle: TextStyle(color: AppColors.accent, fontSize: 20, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: AppColors.textMain),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonColor,
            foregroundColor: AppColors.textMain,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
        ),
      ),
      initialRoute: '/intro',
      routes: {
        '/intro': (context) => const IntroPage(),
        '/DeathRow': (context) => const DeathRowBackground(), 
        '/DeathRowScene': (context) => const DeathRowScene(),
        '/Warrant': (context) => const WarrantPage(),
        // Placeholders
        '/TheRest': (context) => const Scaffold(body: Center(child: Text("Coming Soon"))),
        '/instructions': (context) => const Scaffold(body: Center(child: Text("Instructions..."))),
      },
    );
  }
}

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final buttons = ['Death on the Row', 'The Final Guest List', 'Cipher Killer', 'A Killer Among Guests'];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 60),
              // LOGO
              Center(
                child: Image.asset('assets/images/icon.png', height: 150, fit: BoxFit.contain,
                errorBuilder: (c,e,s) => const Icon(Icons.search, size: 100, color: AppColors.accent)),
              ),
              const SizedBox(height: 20),
              const Text('Solve the unsolvable.', style: TextStyle(color: Colors.white54, fontSize: 16, fontStyle: FontStyle.italic)),
              const Spacer(),

              // BUTTONS
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(buttons.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (index == 0) {
                          // CHECK SAVE FILE LOGIC
                          final evidenceModel = Provider.of<EvidenceModel>(context, listen: false);
                          await evidenceModel.loadProgress(); // Load from disk

                          if (evidenceModel.hasSaveFile) {
                            Navigator.of(context).pushNamed('/DeathRowScene'); // Resume
                          } else {
                            Navigator.of(context).pushNamed('/DeathRow'); // Start New
                          }
                        } else {
                          Navigator.of(context).pushNamed('/TheRest');
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.surface),
                      child: Text(buttons[index], style: const TextStyle(fontSize: 16)),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.help_outline, color: AppColors.accent),
                  onPressed: () => Navigator.of(context).pushNamed('/instructions'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}