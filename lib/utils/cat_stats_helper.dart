import 'package:flutter/material.dart';
import '../models/cat_breed.dart';

class CatStatsHelper {
  static List<Map<String, dynamic>> getPersonalityStats(CatBreed breed) {
    return [
      {
        'label': 'Adaptabilidad',
        'value': breed.adaptability,
        'icon': Icons.psychology,
        'color': Colors.blue,
      },
      {
        'label': 'Afecto',
        'value': breed.affectionLevel,
        'icon': Icons.favorite,
        'color': Colors.red,
      },
      {
        'label': 'Amigable con niños',
        'value': breed.childFriendly,
        'icon': Icons.child_care,
        'color': Colors.orange,
      },
      {
        'label': 'Amigable con perros',
        'value': breed.dogFriendly,
        'icon': Icons.pets,
        'color': Colors.brown,
      },
      {
        'label': 'Nivel de energía',
        'value': breed.energyLevel,
        'icon': Icons.flash_on,
        'color': Colors.yellow[700]!,
      },
      {
        'label': 'Aseo',
        'value': breed.grooming,
        'icon': Icons.brush,
        'color': Colors.purple,
      },
      {
        'label': 'Problemas de salud',
        'value': breed.healthIssues,
        'icon': Icons.health_and_safety,
        'color': Colors.green,
      },
      {
        'label': 'Inteligencia',
        'value': breed.intelligence,
        'icon': Icons.lightbulb,
        'color': Colors.amber,
      },
      {
        'label': 'Pérdida de pelo',
        'value': breed.sheddingLevel,
        'icon': Icons.cleaning_services,
        'color': Colors.grey,
      },
      {
        'label': 'Necesidades sociales',
        'value': breed.socialNeeds,
        'icon': Icons.group,
        'color': Colors.teal,
      },
      {
        'label': 'Amigable con extraños',
        'value': breed.strangerFriendly,
        'icon': Icons.waving_hand,
        'color': Colors.indigo,
      },
      {
        'label': 'Vocalización',
        'value': breed.vocalisation,
        'icon': Icons.record_voice_over,
        'color': Colors.pink,
      },
    ];
  }

  static List<Map<String, dynamic>> getPhysicalTraits(CatBreed breed) {
    final traits = <Map<String, dynamic>>[];

    if (breed.experimental == 1) {
      traits.add({
        'label': 'Experimental',
        'icon': Icons.science,
        'color': Colors.purple,
      });
    }

    if (breed.hairless == 1) {
      traits.add({
        'label': 'Sin pelo',
        'icon': Icons.pets,
        'color': Colors.orange,
      });
    }

    if (breed.natural == 1) {
      traits.add({
        'label': 'Natural',
        'icon': Icons.nature,
        'color': Colors.green,
      });
    }

    if (breed.rare == 1) {
      traits.add({'label': 'Raro', 'icon': Icons.star, 'color': Colors.amber});
    }

    if (breed.rex == 1) {
      traits.add({
        'label': 'Rex',
        'icon': Icons.texture,
        'color': Colors.brown,
      });
    }

    if (breed.suppressedTail == 1) {
      traits.add({
        'label': 'Cola suprimida',
        'icon': Icons.remove,
        'color': Colors.red,
      });
    }

    if (breed.shortLegs == 1) {
      traits.add({
        'label': 'Patas cortas',
        'icon': Icons.height,
        'color': Colors.blue,
      });
    }

    if (breed.hypoallergenic == 1) {
      traits.add({
        'label': 'Hipoalergénico',
        'icon': Icons.health_and_safety,
        'color': Colors.teal,
      });
    }

    return traits;
  }

  static List<Map<String, dynamic>> getUsefulLinks(CatBreed breed) {
    final links = <Map<String, dynamic>>[];

    if (breed.wikipediaUrl?.isNotEmpty == true) {
      links.add({
        'title': 'Wikipedia',
        'url': breed.wikipediaUrl!,
        'icon': Icons.article,
        'color': Colors.blue,
      });
    }

    if (breed.cfaUrl?.isNotEmpty == true) {
      links.add({
        'title': 'Cat Fanciers Association',
        'url': breed.cfaUrl!,
        'icon': Icons.pets,
        'color': Colors.orange,
      });
    }

    if (breed.vetstreetUrl?.isNotEmpty == true) {
      links.add({
        'title': 'Vetstreet',
        'url': breed.vetstreetUrl!,
        'icon': Icons.local_hospital,
        'color': Colors.red,
      });
    }

    if (breed.vcahospitalsUrl?.isNotEmpty == true) {
      links.add({
        'title': 'VCA Hospitals',
        'url': breed.vcahospitalsUrl!,
        'icon': Icons.medical_services,
        'color': Colors.green,
      });
    }

    return links;
  }

  static String formatWeight(Map<String, String>? weight) {
    if (weight == null) return 'No disponible';

    final imperial = weight['imperial'];
    final metric = weight['metric'];

    if (imperial != null && metric != null) {
      return '$metric kg ($imperial lbs)';
    } else if (metric != null) {
      return '$metric kg';
    } else if (imperial != null) {
      return '$imperial lbs';
    }

    return 'No disponible';
  }

  static String formatLifeSpan(String? lifeSpan) {
    if (lifeSpan == null || lifeSpan.isEmpty) {
      return 'No disponible';
    }
    return '$lifeSpan años';
  }

  static String formatOrigin(String? origin) {
    if (origin == null || origin.isEmpty) {
      return 'No disponible';
    }
    return origin;
  }

  static String formatTemperament(String? temperament) {
    if (temperament == null || temperament.isEmpty) {
      return 'No disponible';
    }
    return temperament;
  }

  static List<String> getTemperamentChips(String? temperament) {
    if (temperament == null || temperament.isEmpty) {
      return [];
    }
    return temperament.split(',').map((e) => e.trim()).toList();
  }

  static List<String> getAlternativeNames(String? altNames) {
    if (altNames == null || altNames.isEmpty) {
      return [];
    }
    return altNames.split(',').map((e) => e.trim()).toList();
  }
}
