import 'package:flutter/material.dart';
import 'package:hod/screens/homepage.dart';
import 'package:audio_service/audio_service.dart';
import 'package:get_it/get_it.dart';
import 'services/service_locator.dart';
import 'services/audio_handler.dart';

void main() async {
  getIt.registerSingleton<AudioHandler>(await initAudioService());

  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'House of Deliverance',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'House of Deliverance'),
    );
  }
}
