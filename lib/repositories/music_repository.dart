import '../models/itunes_model.dart';
import '../services/itunes_service.dart';

abstract class MusicRepository {
  Future<List<MusicTrack>> searchTracks(String term);
}

class MusicRepositoryImpl implements MusicRepository {
  final ITunesService _service;

  MusicRepositoryImpl(this._service);

  @override
  Future<List<MusicTrack>> searchTracks(String term) async {
    final response = await _service.fetchMusic(term);
    return response.results ?? [];
  }
}
