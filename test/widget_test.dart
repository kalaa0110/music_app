import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:music_app/main.dart';
import 'package:music_app/viewmodels/music_viewmodel.dart';
import 'package:music_app/services/itunes_service.dart';
import 'package:music_app/repositories/music_repository.dart';

void main() {
  testWidgets('Music App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // We replicate the provider setup from main.dart to ensure dependencies are available.
    await tester.pumpWidget(
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

    // Verify that the Explore button exists on the Home Screen.
    expect(find.text('EXPLORE MUSIC'), findsOneWidget);
    
    // Verify that the app title "ITUNES" is displayed.
    expect(find.text('ITUNES'), findsOneWidget);
  });
}
