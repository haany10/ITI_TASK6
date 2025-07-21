import 'package:flutter/material.dart';
import 'package:my_assistant/Posts/post_search_delegate.dart';
import 'posts_screen.dart'; 

class FavoritePostsScreen extends StatefulWidget {
  const FavoritePostsScreen({super.key});

  @override
  State<FavoritePostsScreen> createState() => _FavoritePostsScreenState();
}

class _FavoritePostsScreenState extends State<FavoritePostsScreen> {
  void removeFavorite(post) {
    setState(() {
      favoritePosts.removeWhere((p) => p['id'] == post['id']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Posts"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: PostSearchDelegate(favoritePosts, removeFavorite, (_) => true),
              );
            },
          )
        ],
      ),
      body: favoritePosts.isEmpty
          ? const Center(child: Text("No favorite posts yet."))
          : ListView.builder(
              itemCount: favoritePosts.length,
              itemBuilder: (context, index) {
                var post = favoritePosts[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(post['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(post['body']),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () => removeFavorite(post),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
