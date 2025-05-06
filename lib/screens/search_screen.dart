import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/search_provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchProvider>(context);

    // -TODO: Implement the search screen UI
    // Requirements:
    // - Create a TextField for user input
    // - Display search results in a ListView
    // - Show loading indicator while waiting for results
    // - Display a message if no results or errors
    // - Connect to the SearchProvider for state

    return Scaffold(
      appBar: AppBar(title: const Text('Product Search')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // -TODO: Implement the search TextField
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search Products',
                border: OutlineInputBorder(),
              ),
              onChanged: provider.search,
            ),

            const SizedBox(height: 20),

            // -TODO: Implement the results ListView with appropriate states
            // - Loading state
            // - Error state
            // - Empty state
            // - Success state with results
            Expanded(
              child: Builder(
                builder: (_) {
                  switch (provider.state) {
                    case SearchState.loading:
                      return const Center(child: CircularProgressIndicator());

                    case SearchState.error:
                      return Center(child: Text(provider.errorMessage));

                    case SearchState.empty:
                      return const Center(child: Text('No products found.'));

                    case SearchState.success:
                      return ListView.builder(
                        itemCount: provider.results.length,
                        itemBuilder: (context, index) {
                          return ListTile(title: Text(provider.results[index]));
                        },
                      );

                    case SearchState.initial:
                    return const Center(
                      child: Text('Start typing to search products.'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
