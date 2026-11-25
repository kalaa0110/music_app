import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'viewmodels/music_viewmodel.dart';
import 'services/itunes_service.dart';
import 'repositories/music_repository.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => ITunesService()),
        ProxyProvider<ITunesService, MusicRepository>(
          update: (_, service, __) => MusicRepositoryImpl(service),
        ),
        ChangeNotifierProvider(
          create: (context) => MusicViewModel(
            Provider.of<MusicRepository>(context, listen: false),
          ),
        ),
      ],
      child: const MusicApp(),
    ),
  );
}

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
