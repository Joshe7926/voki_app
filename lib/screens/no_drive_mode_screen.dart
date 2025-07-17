import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class NoDriveModeScreen extends StatefulWidget {
  const NoDriveModeScreen({super.key});

  @override
  State<NoDriveModeScreen> createState() => _NoDriveModeScreenState();
}

class _NoDriveModeScreenState extends State<NoDriveModeScreen> {
  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playWelcomeAudio();
  }

  Future<void> _playWelcomeAudio() async {
    try {
      await _player.setAsset('assets/audio/bienvenida.mp3');
      await _player.play();
    } catch (e) {
      print('Error al reproducir el audio: $e');
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF7F3FF),
      body: Center(
        child: Text(
          'Bienvenido a Voki (Modo No Conducción)',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
