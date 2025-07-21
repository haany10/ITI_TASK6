import 'package:flutter/material.dart';

class PostSearchDelegate extends SearchDelegate {
  final List posts;
  final Function toggleFavorite;
  final Function isFavorite;

  PostSearchDelegate(this.posts, this.toggleFavorite, this.isFavorite);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) => buildSuggestions(context);

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = posts.where((post) =>
        post['title'].toString().toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        var post = results[index];
        return Card(
          margin: const EdgeInsets.all(10),
          child: ListTile(
            title: Text(post['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(post['body']),
            trailing: IconButton(
              icon: Icon(
                isFavorite(post) ? Icons.favorite : Icons.favorite_border,
                color: isFavorite(post) ? Colors.red : null,
              ),
              onPressed: () => toggleFavorite(post),
            ),
          ),
        );
      },
    );
  }
}