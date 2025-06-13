import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cat_breed.dart';
import '../models/api_result.dart';

abstract class ICatApiService {
  Future<ApiResult<List<CatBreed>>> getCatBreeds();
}

class CatApiService implements ICatApiService {
  static const String _baseUrl = 'https://api.thecatapi.com/v1';
  final http.Client _httpClient;

  CatApiService({http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client();

  @override
  Future<ApiResult<List<CatBreed>>> getCatBreeds() async {
    try {
      final response = await _httpClient.get(
        Uri.parse('$_baseUrl/breeds?attach_image=1'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        final breeds = jsonList.map((json) => CatBreed.fromJson(json)).toList();
        return ApiSuccess(breeds);
      } else {
        return ApiError('Error al cargar las razas: ${response.statusCode}');
      }
    } catch (e) {
      return ApiError(
        'Error de conexión',
        e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  void dispose() {
    _httpClient.close();
  }
}
