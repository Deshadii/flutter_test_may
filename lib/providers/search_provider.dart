import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import '../services/search_service.dart';

// -TODO: Implement SearchProvider using ChangeNotifier
// Requirements:
// - Create a class that extends ChangeNotifier
// - Use BehaviorSubject for search query stream
// - Apply rxdart operators (debounceTime, distinct, switchMap)
// - Handle potential errors gracefully
// - Emit states for Loading, Success, Error, and Empty

enum SearchState { initial, loading, success, error, empty }

class SearchProvider extends ChangeNotifier {
  final SearchService _searchService;
  final _searchQueryController = BehaviorSubject<String>();

  // -TODO: Add state variables
  List<String> _results = [];
  SearchState _state = SearchState.initial;
  String _errorMessage = '';

  // Expose getters for UI
  List<String> get results => _results;
  SearchState get state => _state;
  String get errorMessage => _errorMessage;

  // -TODO: Add BehaviorSubject for search queries

  SearchProvider({SearchService? searchService})
    : _searchService = searchService ?? SearchService() {
    _searchQueryController
        .debounceTime(const Duration(milliseconds: 300))
        .distinct()
        .switchMap((query) {
          _state = SearchState.loading;
          notifyListeners();

          return Stream.fromFuture(_searchService.searchProducts(query))
              .map((results) {
                if (results.isEmpty) {
                  _state = SearchState.empty;
                } else {
                  _state = SearchState.success;
                }
                _results = results;
                return results;
              })
              .onErrorReturnWith((error, _) {
                _state = SearchState.error;
                _errorMessage = 'Something went wrong!';
                _results = [];
                return [];
              });
        })
        .listen((_) {
          notifyListeners();
        });

    // -TODO: Initialize search stream with operators
    // - Use debounceTime (300ms)
    // - Use distinct operator
    // - Use switchMap for API calls
    // - Handle errors within stream
  }

  // -TODO: Implement methods to update search query
  void search(String query) {
    _searchQueryController.add(query);
  }  

  // -TODO: Implement clean up for streams
  @override
  void dispose() {
    // -TODO: Clean up any streams
    _searchQueryController.close();
    super.dispose();
  }
}
