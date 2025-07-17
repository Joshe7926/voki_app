import 'package:flutter/material.dart';
import 'driving_mode_screen.dart';
import 'no_drive_mode_screen.dart';

class ModeSelectionScreen extends StatelessWidget {
  const ModeSelectionScreen({super.key});

  void _navigateTo(BuildContext context, String mode) {
    // Aquí irán las rutas según el modo
    if (mode == 'driving') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DrivingModeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const StandardHomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0EAFC), Color(0xFFCFDEF3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '¿Cómo usarás Voki?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () => _navigateTo(context, 'driving'),
                icon: const Icon(Icons.directions_car),
                label: const Text('Modo Conducción'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => _navigateTo(context, 'standard'),
                icon: const Icon(Icons.smartphone),
                label: const Text('Modo No Conducción'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrivingHomeScreen extends StatelessWidget {
  const DrivingHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Bienvenido a Voki (Modo Conducción)',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}

class StandardHomeScreen extends StatelessWidget {
  const StandardHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Bienvenido a Voki (Modo No Conducción)',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
