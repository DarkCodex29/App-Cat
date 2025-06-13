class CatBreed {
  final String id;
  final String name;
  final String? description;
  final String temperament;
  final String origin;
  final String? countryCode;
  final String? countryCodes;
  final String? lifeSpan;
  final int intelligence;
  final String? imageUrl;
  final String? referenceImageId;
  final int adaptability;
  final int affectionLevel;
  final int childFriendly;
  final int energyLevel;
  final int dogFriendly;
  final int? catFriendly;
  final int grooming;
  final int healthIssues;
  final int socialNeeds;
  final int strangerFriendly;
  final int vocalisation;
  final int sheddingLevel;
  final int? bidability;
  final Map<String, String>? weight;
  final int? indoor;
  final int? lap;
  final int? experimental;
  final int? hairless;
  final int? natural;
  final int? rare;
  final int? rex;
  final int? suppressedTail;
  final int? shortLegs;
  final int? hypoallergenic;
  final String? cfaUrl;
  final String? vetstreetUrl;
  final String? vcahospitalsUrl;
  final String? wikipediaUrl;
  final String? altNames;

  CatBreed({
    required this.id,
    required this.name,
    this.description,
    required this.temperament,
    required this.origin,
    this.countryCode,
    this.countryCodes,
    this.lifeSpan,
    required this.intelligence,
    this.imageUrl,
    this.referenceImageId,
    required this.adaptability,
    required this.affectionLevel,
    required this.childFriendly,
    required this.energyLevel,
    required this.dogFriendly,
    this.catFriendly,
    required this.grooming,
    required this.healthIssues,
    required this.socialNeeds,
    required this.strangerFriendly,
    required this.vocalisation,
    required this.sheddingLevel,
    this.bidability,
    this.weight,
    this.indoor,
    this.lap,
    this.experimental,
    this.hairless,
    this.natural,
    this.rare,
    this.rex,
    this.suppressedTail,
    this.shortLegs,
    this.hypoallergenic,
    this.cfaUrl,
    this.vetstreetUrl,
    this.vcahospitalsUrl,
    this.wikipediaUrl,
    this.altNames,
  });

  factory CatBreed.fromJson(Map<String, dynamic> json) {
    return CatBreed(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      temperament: json['temperament'] ?? '',
      origin: json['origin'] ?? '',
      countryCode: json['country_code'],
      countryCodes: json['country_codes'],
      lifeSpan: json['life_span'],
      intelligence: json['intelligence'] ?? 0,
      imageUrl: json['image']?['url'],
      referenceImageId: json['reference_image_id'],
      adaptability: json['adaptability'] ?? 0,
      affectionLevel: json['affection_level'] ?? 0,
      childFriendly: json['child_friendly'] ?? 0,
      energyLevel: json['energy_level'] ?? 0,
      dogFriendly: json['dog_friendly'] ?? 0,
      catFriendly: json['cat_friendly'],
      grooming: json['grooming'] ?? 0,
      healthIssues: json['health_issues'] ?? 0,
      socialNeeds: json['social_needs'] ?? 0,
      strangerFriendly: json['stranger_friendly'] ?? 0,
      vocalisation: json['vocalisation'] ?? 0,
      sheddingLevel: json['shedding_level'] ?? 0,
      bidability: json['bidability'],
      weight: json['weight'] != null
          ? Map<String, String>.from(json['weight'])
          : null,
      indoor: json['indoor'],
      lap: json['lap'],
      experimental: json['experimental'],
      hairless: json['hairless'],
      natural: json['natural'],
      rare: json['rare'],
      rex: json['rex'],
      suppressedTail: json['suppressed_tail'],
      shortLegs: json['short_legs'],
      hypoallergenic: json['hypoallergenic'],
      cfaUrl: json['cfa_url'],
      vetstreetUrl: json['vetstreet_url'],
      vcahospitalsUrl: json['vcahospitals_url'],
      wikipediaUrl: json['wikipedia_url'],
      altNames: json['alt_names'],
    );
  }

  String get displayImageUrl {
    if (imageUrl != null) return imageUrl!;
    if (referenceImageId != null) {
      return 'https://cdn2.thecatapi.com/images/$referenceImageId.jpg';
    }
    return '';
  }

  bool get isHairless => hairless == 1;
  bool get isRex => rex == 1;
  bool get hasShortLegs => shortLegs == 1;
  bool get hasSuppressedTail => suppressedTail == 1;
  bool get isHypoallergenic => hypoallergenic == 1;
  bool get isRare => rare == 1;
  bool get isNatural => natural == 1;
  bool get isExperimental => experimental == 1;
  bool get isLapCat => lap == 1;
  bool get isIndoorCat => indoor == 1;

  String get weightDisplay {
    if (weight == null) return 'No disponible';
    final imperial = weight!['imperial'];
    final metric = weight!['metric'];
    if (imperial != null && metric != null) {
      return '$metric kg ($imperial lbs)';
    }
    return imperial ?? metric ?? 'No disponible';
  }
}
