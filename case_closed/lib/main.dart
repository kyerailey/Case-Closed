import 'package:flutter/material.dart';

// ------------------------------
// IMPORT YOUR CASE FILES
// ------------------------------
import 'death_row/scene.dart';
import 'death_row/evidence.dart';
import 'death_row/suspects.dart';

// ------------------------------
// OTHER CASE PAGE (placeholder)
// ------------------------------
class TheRestPage extends StatelessWidget {
  const TheRestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Other Case Page",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}

// ------------------------------
// INSTRUCTIONS PAGE (placeholder)
// ------------------------------
class InstructionsPage extends StatelessWidget {
  const InstructionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Instructions Page",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

// ------------------------------
// ROOT OF THE APP
// ------------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Case Closed",
      theme: ThemeData.dark(),

      // Intro page first
      initialRoute: '/intro',

      routes: {
        // Intro
        '/intro': (context) => const IntroPage(),

        // Death Row case pages
        '/DeathRow': (context) => ScenePage(),
        '/DeathRowEvidence': (context) => EvidencePage(),
        '/DeathRowSuspects': (context) => SuspectsPage(),

        // Other cases
        '/TheRest': (context) => const TheRestPage(),

        // Help
        '/instructions': (context) => const InstructionsPage(),
      },
    );
  }
}

// ------------------------------
// INTRO PAGE — YOUR ORIGINAL CODE
// ------------------------------
class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  static const routeName = '/intro';

  static const String uniqueRoute = '/DeathRow';
  static const String commonRoute = '/TheRest';
  static const String helpRoute = '/instructions';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final buttons = <String>[
      'Death on the Row',  
      'The Final Guest List',
      'Cipher Killer',
      'A Killer Among the Guest',
      'Secrets on Silverlake',
    ];

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0F172A), Color(0xFF0B2447)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 48),
              const FlutterLogo(size: 96),
              const SizedBox(height: 32),

              Text(
                'Case Closed',
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              Text(
                'Organize cases, track progress, and close them faster.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(buttons.length, (index) {
                  final label = buttons[index];
                  final destination =
                      index == 0 ? uniqueRoute : commonRoute;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(destination);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(label, style: const TextStyle(fontSize: 16)),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 8),

              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(commonRoute);
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(color: Colors.white70),
                ),
              ),

              const SizedBox(height: 24),

              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Ink(
                    decoration: const ShapeDecoration(
                      color: Color(0x33FFFFFF),
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.help_outline, color: Colors.white),
                      tooltip: 'Instructions',
                      onPressed: () {
                        Navigator.of(context).pushNamed(helpRoute);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
