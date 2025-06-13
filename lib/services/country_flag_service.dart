import 'dart:convert';
import 'package:http/http.dart' as http;

class CountryFlagService {
  static const String _baseUrl = 'https://restcountries.com/v3.1';
  static final Map<String, String> _flagCache = {};

  static Future<String?> getFlagUrl(String countryName) async {
    if (countryName.isEmpty) return null;
    
    final normalizedName = _normalizeCountryName(countryName);
    
    if (_flagCache.containsKey(normalizedName)) {
      return _flagCache[normalizedName];
    }

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/name/$normalizedName?fields=flags'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> countries = json.decode(response.body);
        if (countries.isNotEmpty) {
          final flagUrl = countries[0]['flags']['png'] as String?;
          if (flagUrl != null) {
            _flagCache[normalizedName] = flagUrl;
            return flagUrl;
          }
        }
      }
    } catch (e) {
      print('Error fetching flag for $countryName: $e');
    }

    return null;
  }

  static String _normalizeCountryName(String countryName) {
    final Map<String, String> countryMappings = {
      'United States': 'United States of America',
      'US': 'United States of America',
      'USA': 'United States of America',
      'UK': 'United Kingdom',
      'Britain': 'United Kingdom',
      'England': 'United Kingdom',
      'Burma': 'Myanmar',
      'Persia': 'Iran',
      'Russia': 'Russian Federation',
    };

    return countryMappings[countryName] ?? countryName;
  }

  static void clearCache() {
    _flagCache.clear();
  }
} 