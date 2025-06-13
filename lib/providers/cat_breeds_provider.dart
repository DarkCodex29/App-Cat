import 'package:flutter/foundation.dart';
import '../models/cat_breed.dart';
import '../models/api_result.dart';
import '../services/cat_api_service.dart';
import '../widgets/skeleton_loader.dart';

enum LoadingState { initialLoading, success, error, loadingMore }

class CatBreedsProvider with ChangeNotifier {
  final ICatApiService _apiService;

  List<CatBreed> _breeds = [];
  LoadingState _loadingState = LoadingState.initialLoading;
  String _errorMessage = '';
  bool _showSkeleton = true;
  bool _isLoadingMore = false;
  bool _hasMoreItems = true;

  static const int _itemsPerPage = 10;
  int _currentPage = 0;

  CatBreedsProvider(this._apiService);

  List<CatBreed> get breeds => _breeds;
  LoadingState get loadingState => _loadingState;
  String get errorMessage => _errorMessage;
  bool get showSkeleton => _showSkeleton;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMoreItems => _hasMoreItems;

  Future<void> loadCatBreeds() async {
    _loadingState = LoadingState.initialLoading;
    _showSkeleton = true;
    _currentPage = 0;
    _hasMoreItems = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 1500));

    final result = await _apiService.getCatBreeds();

    if (result is ApiSuccess<List<CatBreed>>) {
      final allBreeds = result.data;
      _breeds = allBreeds.take(_itemsPerPage).toList();
      _loadingState = LoadingState.success;
      _showSkeleton = false;
      _hasMoreItems = allBreeds.length > _itemsPerPage;
      _currentPage = 1;
    } else if (result is ApiError<List<CatBreed>>) {
      _errorMessage = result.message;
      _loadingState = LoadingState.error;
      _showSkeleton = false;
    }

    notifyListeners();
  }

  Future<void> loadMoreItems() async {
    if (_isLoadingMore ||
        !_hasMoreItems ||
        _loadingState != LoadingState.success) {
      return;
    }

    _isLoadingMore = true;
    _loadingState = LoadingState.loadingMore;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 800));

    final result = await _apiService.getCatBreeds();

    if (result is ApiSuccess<List<CatBreed>>) {
      final allBreeds = result.data;
      final startIndex = _currentPage * _itemsPerPage;
      final endIndex = startIndex + _itemsPerPage;

      if (startIndex < allBreeds.length) {
        final newItems = allBreeds
            .skip(startIndex)
            .take(_itemsPerPage)
            .toList();
        _breeds.addAll(newItems);
        _currentPage++;
        _hasMoreItems = endIndex < allBreeds.length;
      } else {
        _hasMoreItems = false;
      }

      _loadingState = LoadingState.success;
    } else if (result is ApiError<List<CatBreed>>) {
      _errorMessage = result.message;
      _loadingState = LoadingState.error;
    }

    _isLoadingMore = false;
    notifyListeners();
  }

  List<CatBreedSkeleton> getSkeletonItems() {
    return List.generate(6, (index) => const CatBreedSkeleton());
  }

  @override
  void dispose() {
    if (_apiService is CatApiService) {
      (_apiService).dispose();
    }
    super.dispose();
  }
}
