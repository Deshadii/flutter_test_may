// TODO: Implement a mock search service
// Requirements:
// - Create a class that simulates fetching data with a delay
// - Implement a searchProducts method that returns a Future<List<String>>
// - Return an empty list for empty queries
// - Simulate a short delay (500ms)

class SearchService {
  // TODO: Implement searchProducts method
    final List<String> _mockProducts = [
    'Apple',
    'Banana',
    'Orange',
    'Pineapple',
    'Mango',
    'Avocado',
    'Grapes',
    'Watermelon',
    'Blueberry',
    'Strawberry',
  ]; 

  Future<List<String>> searchProducts(String query) async {
    await Future.delayed(const Duration(milliseconds: 500)); // 0.5s delay

    // Return empty list if query is empty
    if (query.trim().isEmpty) return [];

    //Filters the mock product list to return matching results
    return _mockProducts
        .where((product) => product.toLowerCase().contains(query.toLowerCase()))
        .toList();

    // TODO: Add mock product search logic with delay
    //throw UnimplementedError('searchProducts has not been implemented');
  }
}
