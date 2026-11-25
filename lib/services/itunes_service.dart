import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/itunes_model.dart';

class ITunesService {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  Future<ITunesResponse> fetchMusic(String term) async {
    try {
      final response = await _dio.get(
        'https://itunes.apple.com/search',
        queryParameters: {'term': term},
      );
      
      if (response.statusCode == 200) {
        dynamic data = response.data;
        if (data is String) {
          data = jsonDecode(data);
        }
        return ITunesResponse.fromJson(data);
      } else {
        throw Exception('Server Error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timed out. Please check your internet.');
      }
      throw Exception(e.message ?? 'An unexpected network error occurred');
    }
  }
}
