import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants.dart';
import '../viewmodels/music_viewmodel.dart';
import 'music_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.network(
              AppConstants.homeBackgroundUrl,
              fit: BoxFit.cover,
            ),
          ),
          // Professional Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.85),
                  ],
                ),
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.music_note_rounded,
                      color: Colors.white,
                      size: screenWidth * 0.25,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      AppConstants.appTitle.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.09,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 4,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      'Discover your favorite artists and tracks',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.1),
                    Consumer<MusicViewModel>(
                      builder: (context, viewModel, child) {
                        return SizedBox(
                          width: double.infinity,
                          height: screenHeight * 0.07,
                          child: ElevatedButton(
                            onPressed: viewModel.state == MusicState.loading
                                ? null
                                : () async {
                                    await viewModel.fetchMusic(AppConstants.defaultSearchTerm);
                                    if (viewModel.state == MusicState.loaded) {
                                      if (context.mounted) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const MusicListScreen(),
                                          ),
                                        );
                                      }
                                    } else if (viewModel.state == MusicState.error) {
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(viewModel.errorMessage),
                                            backgroundColor: Colors.redAccent,
                                            behavior: SnackBarBehavior.floating,
                                            margin: EdgeInsets.all(screenWidth * 0.05),
                                          ),
                                        );
                                      }
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(screenWidth * 0.04),
                              ),
                            ),
                            child: viewModel.state == MusicState.loading
                                ? const CircularProgressIndicator(color: Colors.black)
                                : Text(
                                    'EXPLORE MUSIC',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.045,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
