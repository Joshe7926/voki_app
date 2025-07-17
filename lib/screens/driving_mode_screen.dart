import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';

class DrivingModeScreen extends StatefulWidget {
  const DrivingModeScreen({super.key});

  @override
  State<DrivingModeScreen> createState() => _DrivingModeScreenState();
}

class _DrivingModeScreenState extends State<DrivingModeScreen> {
  late FlutterTts flutterTts;
  late AudioPlayer player;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    player = AudioPlayer();
    _startInteraction();
  }

  Future<void> _startInteraction() async {
    await flutterTts.speak(
      "Bienvenido a Voki. Este es el modo conducción. Reproduciendo una historia.",
    );

    // Espera antes de reproducir
    await Future.delayed(const Duration(seconds: 4));

    await player.setAsset('assets/audios/historia1.mp3');
    await player.play();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Modo conducción activo',
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
