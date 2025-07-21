import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class DrivingModeScreen extends StatefulWidget {
  const DrivingModeScreen({super.key});

  @override
  State<DrivingModeScreen> createState() => _DrivingModeScreenState();
}

class _DrivingModeScreenState extends State<DrivingModeScreen> {
  late FlutterTts flutterTts;
  late AudioPlayer player;
  late stt.SpeechToText speech;
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    player = AudioPlayer();
    speech = stt.SpeechToText();
    _startSequence();
  }

  Future<void> _startSequence() async {
    if (isProcessing) return;
    isProcessing = true;

    // Paso 1: reproducir bienvenida
    await player.setAsset('assets/audio/bienvenida.mp3');
    await player.play();
    await Future.delayed(player.duration ?? const Duration(seconds: 4));

    // Paso 2: preguntar
    await flutterTts.speak(
        "¿Qué quieres escuchar? Una historia, aprender un idioma o un dato curioso.");
    await Future.delayed(const Duration(seconds: 2));

    // Paso 3: escuchar voz del usuario
    await _escucharYProcesar();

    isProcessing = false;
  }

  Future<void> _escucharYProcesar() async {
    bool available = await speech.initialize();
    if (!available) {
      await flutterTts.speak("No se pudo acceder al micrófono.");
      return;
    }

    await speech.listen(
      onResult: (result) async {
        final texto = result.recognizedWords.toLowerCase();
        print('🔊 Usuario dijo: $texto');

        speech.stop();

        if (texto.contains('historia')) {
          await flutterTts.speak("Perfecto, escuchando una historia.");
          await flutterTts
              .speak("Había una vez una rana que vivía en un zapato...");
        } else if (texto.contains('idioma')) {
          await _flujoIdioma();
        } else if (texto.contains('dato') || texto.contains('curioso')) {
          await flutterTts.speak("Muy bien, aquí tienes un dato curioso.");
          await flutterTts
              .speak("¿Sabías que los pulpos tienen tres corazones?");
        } else {
          await flutterTts.speak(
              "Lo siento, no entendí. Intenta decir historia, idioma o dato curioso.");
        }
      },
      listenFor: const Duration(seconds: 6),
      pauseFor: const Duration(seconds: 3),
      localeId: 'es_ES',
      cancelOnError: true,
      partialResults: false,
    );
  }

  Future<void> _flujoIdioma() async {
    await flutterTts
        .speak("¿Qué idioma te gustaría aprender? Inglés, francés o alemán.");
    await Future.delayed(const Duration(seconds: 2));
    await _escucharIdioma();
  }

  Future<void> _escucharIdioma() async {
    await speech.listen(
      onResult: (result) async {
        final idioma = result.recognizedWords.toLowerCase();
        speech.stop();

        String idiomaElegido;
        if (idioma.contains('inglés')) {
          idiomaElegido = 'inglés';
        } else if (idioma.contains('francés')) {
          idiomaElegido = 'francés';
        } else if (idioma.contains('alemán')) {
          idiomaElegido = 'alemán';
        } else {
          await flutterTts.speak(
              "No entendí el idioma. Por favor intenta nuevamente más tarde.");
          return;
        }

        await flutterTts.speak(
            "¿Qué nivel tienes en $idiomaElegido? Básico, intermedio o avanzado.");
        await Future.delayed(const Duration(seconds: 2));
        await _escucharNivel(idiomaElegido);
      },
      listenFor: const Duration(seconds: 5),
      localeId: 'es_ES',
    );
  }

  Future<void> _escucharNivel(String idioma) async {
    await speech.listen(
      onResult: (result) async {
        final nivel = result.recognizedWords.toLowerCase();
        speech.stop();

        String nivelElegido;
        if (nivel.contains('básico')) {
          nivelElegido = 'básico';
        } else if (nivel.contains('intermedio')) {
          nivelElegido = 'intermedio';
        } else if (nivel.contains('avanzado')) {
          nivelElegido = 'avanzado';
        } else {
          await flutterTts
              .speak("No entendí el nivel. Intenta otra vez más tarde.");
          return;
        }

        await flutterTts
            .speak("Reproduciendo contenido en $idioma, nivel $nivelElegido.");

        // Simulación de contenido
        if (idioma == 'inglés' && nivelElegido == 'básico') {
          await flutterTts
              .speak("Let's learn to say Hello. Repeat after me: Hello!");
        } else if (idioma == 'francés' && nivelElegido == 'intermedio') {
          await flutterTts.speak("En français, on dit: Je m'appelle Marie.");
        } else {
          await flutterTts.speak(
              "Esta es una lección general de $idioma en nivel $nivelElegido.");
        }
      },
      listenFor: const Duration(seconds: 5),
      localeId: 'es_ES',
    );
  }

  @override
  void dispose() {
    flutterTts.stop();
    player.dispose();
    speech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Modo conducción en curso...',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
