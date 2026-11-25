import 'package:flutter/material.dart';
import '../models/itunes_model.dart';
import '../repositories/music_repository.dart';

enum MusicState { initial, loading, loaded, error }

class MusicViewModel extends ChangeNotifier {
  final MusicRepository _repository;
  
  MusicViewModel(this._repository);
  
  MusicState _state = MusicState.initial;
  MusicState get state => _state;

  List<MusicTrack> _tracks = [];
  List<MusicTrack> get tracks => _tracks;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> fetchMusic(String term) async {
    _state = MusicState.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      final results = await _repository.searchTracks(term);
      if (results.isNotEmpty) {
        _tracks = results;
        _state = MusicState.loaded;
      } else {
        _errorMessage = 'No results found for "$term".';
        _state = MusicState.error;
      }
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _state = MusicState.error;
    }
    notifyListeners();
  }
}
