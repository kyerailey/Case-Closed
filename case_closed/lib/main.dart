import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ------------------------------
// IMPORT YOUR MODELS
// ------------------------------
import 'models/evidence_model.dart'; 

// ------------------------------
// IMPORT YOUR PAGES
// ------------------------------
import 'pages/instructions.dart'; 
import 'death_row/background.dart'; 
import 'death_row/scene.dart';
import 'death_row/warrant.dart';

// ------------------------------
// COLOR PALETTE
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

// ------------------------------
// APP CONFIGURATION & ROUTES
// ------------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "CASE CLOSED",
      
      // THEME SETUP
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.surface,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: AppColors.accent, 
            fontSize: 20, 
            fontWeight: FontWeight.bold,
          ),
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

      // ROUTES
      initialRoute: '/intro',
      routes: {
        '/intro': (context) => const IntroPage(),
        
        // CASE 1: DEATH ON THE ROW
        '/DeathRow': (context) => const DeathRowBackground(), 
        '/DeathRowScene': (context) => const DeathRowScene(),
        '/Warrant': (context) => const WarrantPage(),

        // INSTRUCTIONS
        '/instructions': (context) => const InstructionsPage(), 
      },
    );
  }
}

// ------------------------------
// INTRO PAGE (MAIN MENU)
// ------------------------------
class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final buttons = [
      'Death on the Row',  
      'The Final Guest List',
      'Cipher Killer',
      'A Killer Among Guests'
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              // 1. DYNAMIC SPACER (Pushes content down, prevents overflow)
              const Spacer(flex: 2),

              // 2. LOGO (Flexible wrapper prevents crash on small screens)
              Flexible(
                flex: 6,
                child: Center(
                  // ADDED PADDING HERE TO NUDGE IT RIGHT
                  child: Padding(
                    padding: const EdgeInsets.only(left: 35.0), 
                    child: Image.asset(
                      'assets/images/icon.png',
                      height: 280, 
                      fit: BoxFit.contain,
                      errorBuilder: (c,e,s) => const Icon(Icons.search, size: 150, color: AppColors.accent),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Solve the unsolvable.',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),

              // 3. MIDDLE SPACER
              const Spacer(flex: 1),

              // 4. CASE BUTTONS
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(buttons.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.surface,
                        elevation: 0,
                      ),
                      onPressed: () async {
                        if (index == 0) { 
                          // CASE 1: DEATH ON THE ROW (Real Logic)
                          final evidenceModel = Provider.of<EvidenceModel>(context, listen: false);
                          await evidenceModel.loadProgress();

                          if (evidenceModel.hasSaveFile) {
                            Navigator.of(context).pushNamed('/DeathRowScene');
                          } else {
                            Navigator.of(context).pushNamed('/DeathRow');
                          }
                        } else {
                          // LOCKED CASES
                          _showLockedCaseDialog(context);
                        }
                      },
                      child: Text(
                        buttons[index], 
                        style: const TextStyle(fontSize: 16, letterSpacing: 0.5),
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 10),

              // 5. HELP BUTTON
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.help_outline, color: AppColors.accent, size: 30),
                  tooltip: "Instructions",
                  onPressed: () => Navigator.of(context).pushNamed('/instructions'),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  // LOCKED CASE POPUP
  void _showLockedCaseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent, 
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A2634), 
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black, width: 5),
                  boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 10, offset: Offset(0, 5))],
                ),
                child: const Text(
                  "The truth hides in the shadows, but not for long.\n\nReturn once the evidence is ready to be revealed.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.accent, fontSize: 18, fontWeight: FontWeight.bold, height: 1.5),
                ),
              ),
              Positioned(
                right: 10, top: 10,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Colors.white, size: 30),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}