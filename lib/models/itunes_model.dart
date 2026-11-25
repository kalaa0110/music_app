class ITunesResponse {
  final int? resultCount;
  final List<MusicTrack>? results;

  ITunesResponse({this.resultCount, this.results});

  factory ITunesResponse.fromJson(Map<String, dynamic> json) {
    return ITunesResponse(
      resultCount: json['resultCount'],
      results: json['results'] != null
          ? (json['results'] as List).map((i) => MusicTrack.fromJson(i)).toList()
          : null,
    );
  }
}

class MusicTrack {
  final String? wrapperType;
  final String? kind;
  final int? artistId;
  final int? collectionId;
  final int? trackId;
  final String? artistName;
  final String? collectionName;
  final String? trackName;
  final String? collectionCensoredName;
  final String? trackCensoredName;
  final String? artistViewUrl;
  final String? collectionViewUrl;
  final String? trackViewUrl;
  final String? previewUrl;
  final String? artworkUrl30;
  final String? artworkUrl60;
  final String? artworkUrl100;
  final double? trackPrice;
  final String? releaseDate;
  final String? country;
  final String? currency;
  final String? primaryGenreName;
  final String? longDescription;

  MusicTrack({
    this.wrapperType,
    this.kind,
    this.artistId,
    this.collectionId,
    this.trackId,
    this.artistName,
    this.collectionName,
    this.trackName,
    this.collectionCensoredName,
    this.trackCensoredName,
    this.artistViewUrl,
    this.collectionViewUrl,
    this.trackViewUrl,
    this.previewUrl,
    this.artworkUrl30,
    this.artworkUrl60,
    this.artworkUrl100,
    this.trackPrice,
    this.releaseDate,
    this.country,
    this.currency,
    this.primaryGenreName,
    this.longDescription,
  });

  factory MusicTrack.fromJson(Map<String, dynamic> json) {
    return MusicTrack(
      wrapperType: json['wrapperType'],
      kind: json['kind'],
      artistId: json['artistId'],
      collectionId: json['collectionId'],
      trackId: json['trackId'],
      artistName: json['artistName'],
      collectionName: json['collectionName'],
      trackName: json['trackName'],
      collectionCensoredName: json['collectionCensoredName'],
      trackCensoredName: json['trackCensoredName'],
      artistViewUrl: json['artistViewUrl'],
      collectionViewUrl: json['collectionViewUrl'],
      trackViewUrl: json['trackViewUrl'],
      previewUrl: json['previewUrl'],
      artworkUrl30: json['artworkUrl30'],
      artworkUrl60: json['artworkUrl60'],
      artworkUrl100: json['artworkUrl100'],
      trackPrice: json['trackPrice']?.toDouble(),
      releaseDate: json['releaseDate'],
      country: json['country'],
      currency: json['currency'],
      primaryGenreName: json['primaryGenreName'],
      longDescription: json['longDescription'],
    );
  }
}
