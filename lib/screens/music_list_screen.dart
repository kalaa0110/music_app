import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../core/constants.dart';
import '../models/itunes_model.dart';
import '../viewmodels/music_viewmodel.dart';
import 'music_detail_screen.dart';

class MusicListScreen extends StatelessWidget {
  const MusicListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appTitle),
        elevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
      ),
      body: Consumer<MusicViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.state == MusicState.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.tracks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.music_off,
                    size: screenWidth * 0.2,
                    color: theme.disabledColor,
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'No Music Found',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontSize: screenWidth * 0.06,
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => viewModel.fetchMusic(AppConstants.defaultSearchTerm),
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: size.height * 0.02),
                itemCount: viewModel.tracks.length,
                itemBuilder: (context, index) {
                  final track = viewModel.tracks[index];
                  return _MusicListItem(track: track);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MusicListItem extends StatelessWidget {
  final MusicTrack track;

  const _MusicListItem({required this.track});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;

    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: size.height * 0.01,
      ),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(screenWidth * 0.03),
        leading: Hero(
          tag: 'artwork_${track.trackId}',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(screenWidth * 0.02),
            child: CachedNetworkImage(
              imageUrl: track.artworkUrl100 ?? '',
              width: screenWidth * 0.15,
              height: screenWidth * 0.15,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey[300],
                child: const Icon(Icons.music_note),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        title: Text(
          track.trackName ?? 'Unknown Track',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.04,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.005),
            Text(
              track.artistName ?? 'Unknown Artist',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: screenWidth * 0.035),
            ),
            SizedBox(height: size.height * 0.002),
            Text(
              track.primaryGenreName ?? 'General',
              style: TextStyle(
                fontSize: screenWidth * 0.03,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: screenWidth * 0.04),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MusicDetailScreen(track: track),
            ),
          );
        },
      ),
    );
  }
}
