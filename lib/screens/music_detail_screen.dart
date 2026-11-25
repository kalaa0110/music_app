import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/itunes_model.dart';
import 'package:intl/intl.dart';

class MusicDetailScreen extends StatelessWidget {
  final MusicTrack track;

  const MusicDetailScreen({super.key, required this.track});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(

      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),

        slivers: [

          SliverAppBar(
            expandedHeight: screenWidth * 1.25 + statusBarHeight,
            pinned: true,
            stretch: true,
            elevation: 0,
            floating: false,
            automaticallyImplyLeading: false,
            primary: true,
            backgroundColor: theme.colorScheme.surface,
            iconTheme: IconThemeData(
              color: theme.colorScheme.onSurface,
            ),
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              centerTitle: false,
              // title: Text(
              //   track.trackName ?? '',
              //   style: TextStyle(
              //     color: theme.colorScheme.onSurface,
              //     fontSize: screenWidth * 0.045,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              titlePadding: EdgeInsetsDirectional.only(
                start: screenWidth * 0.15,
                bottom: screenHeight * 0.02,
              ),

              // background: Padding(
              //   padding: EdgeInsets.only(
              //     top: statusBarHeight + screenWidth * 0.05,
              //     left: screenWidth * 0.05,
              //     right: screenWidth * 0.05,
              //     bottom: screenWidth * 0.05,
              //   ),
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(screenWidth * 0.05),
              //     child: Hero(
              //       tag: 'artwork_${track.trackId}',
              //       child: CachedNetworkImage(
              //         imageUrl: track.artworkUrl100
              //             ?.replaceAll('100x100', '600x600') ??
              //             '',
              //         fit: BoxFit.contain,
              //         alignment: Alignment.center,
              //         placeholder: (context, url) =>
              //         const Center(child: CircularProgressIndicator()),
              //         errorWidget: (context, url, error) =>
              //             Icon(Icons.music_note, size: screenWidth * 0.25),
              //       ),
              //     ),
              //   ),
              // ),

              // background: Padding(
              //   padding:  EdgeInsets.only(
              //     top: statusBarHeight + 20,
              //     left: 16.0,
              //     right: 16.0,
              //     bottom: 16.0,
              //   ),
              //
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(20),
              //
              //     child: Hero(
              //       tag: 'artwork_${track.trackId}',
              //       child: CachedNetworkImage(
              //         imageUrl: track.artworkUrl100
              //             ?.replaceAll('100x100', '600x600') ??
              //             '',
              //         width: double.infinity,
              //         height: double.infinity,
              //         fit: BoxFit.contain,
              //         alignment: Alignment.center,
              //         placeholder: (context, url) =>
              //         const Center(child: CircularProgressIndicator()),
              //         errorWidget: (context, url, error) =>
              //         const Icon(Icons.music_note, size: 100),
              //       ),
              //     ),
              //   ),
              // ),
              background: Padding(
                padding: EdgeInsets.only(
                  top: statusBarHeight + 8,
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Hero(
                    tag: 'artwork_${track.trackId}',
                    child: CachedNetworkImage(
                      imageUrl: track.artworkUrl100
                          ?.replaceAll('100x100', '600x600') ??
                          '',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                      placeholder: (context, url) =>
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.music_note, size: 100),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.015),
                  Text(
                    track.trackName ?? 'Unknown Track',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.07,
                    ),
                  ),
                  Text(
                    track.artistName ?? 'Unknown Artist',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.055,
                    ),
                  ),
                  Divider(height: screenHeight * 0.05),

                  _buildSectionTitle(context, 'Metadata (20+ Fields)'),

                  // IDs & Types
                  _buildInfoRow(context, 'Wrapper Type', track.wrapperType),
                  _buildInfoRow(context, 'Kind', track.kind),
                  _buildInfoRow(context, 'Track ID', track.trackId?.toString()),
                  _buildInfoRow(context, 'Artist ID', track.artistId?.toString()),
                  _buildInfoRow(context, 'Collection ID', track.collectionId?.toString()),

                  // Names & Censorship
                  _buildInfoRow(context, 'Artist Name', track.artistName),
                  _buildInfoRow(context, 'Collection Name', track.collectionName),
                  _buildInfoRow(context, 'Track Name', track.trackName),
                  _buildInfoRow(context, 'Collection Censored', track.collectionCensoredName),
                  _buildInfoRow(context, 'Track Censored', track.trackCensoredName),

                  // URLs & Assets
                  _buildInfoRow(context, 'Artist View URL', track.artistViewUrl, isUrl: true),
                  _buildInfoRow(context, 'Collection View URL', track.collectionViewUrl, isUrl: true),
                  _buildInfoRow(context, 'Track View URL', track.trackViewUrl, isUrl: true),
                  _buildInfoRow(context, 'Preview URL', track.previewUrl, isUrl: true),
                  _buildInfoRow(context, 'Artwork 30', track.artworkUrl30, isUrl: true),
                  _buildInfoRow(context, 'Artwork 60', track.artworkUrl60, isUrl: true),
                  _buildInfoRow(context, 'Artwork 100', track.artworkUrl100, isUrl: true),

                  // Release & Regional
                  _buildInfoRow(context, 'Release Date', _formatDate(track.releaseDate)),
                  _buildInfoRow(context, 'Country', track.country),
                  _buildInfoRow(context, 'Currency', track.currency),
                  _buildInfoRow(context, 'Primary Genre', track.primaryGenreName),
                  _buildInfoRow(context, 'Track Price', track.trackPrice?.toString()),

                  if (track.longDescription != null) ...[
                    SizedBox(height: screenHeight * 0.03),
                    _buildSectionTitle(context, 'Description'),
                    Text(
                      track.longDescription!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  ],

                  SizedBox(height: screenHeight * 0.06),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return 'N/A';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('MMMM dd, yyyy').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.03),
      child: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          color: theme.primaryColor,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          fontSize: screenWidth * 0.038,
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String? value, {bool isUrl = false}) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.015),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: screenWidth * 0.35,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
                fontSize: screenWidth * 0.035,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isUrl ? theme.colorScheme.primary : null,
                decoration: isUrl ? TextDecoration.underline : null,
                fontSize: screenWidth * 0.035,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
