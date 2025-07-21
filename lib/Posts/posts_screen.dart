import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_assistant/Posts/post_search_delegate.dart';



List<Map<String, dynamic>> favoritePosts = [];

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List posts = [];
  bool isLoading = true;
   Future <void> getPosts() async {
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    if(response.statusCode == 200){
      setState(() {
        posts = jsonDecode(response.body);
        isLoading = false;
      });
    }

   }

     @override
  void initState() {
    super.initState();
    getPosts();
  }

  void tooglePosts (post){
    setState(() {
      if(favoritePosts.any((p) => p['id'] == post ['id']))
      {
        favoritePosts.removeWhere( (p)=> p['id'] == post['id']);
      }
      else{
        favoritePosts.add(post);
      }
    });


  }

  bool isFav(post){
    return favoritePosts.any((p) => p['id'] == post['id']);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts' ), centerTitle: true,
        actions: [
          IconButton(onPressed: 
          (){
            showSearch(context: context, delegate: PostSearchDelegate(posts , tooglePosts , isFav));
          }
          , icon: Icon(Icons.search))
        ],
        

      ),
      body: isLoading? 
      Center(
        child: CircularProgressIndicator(),
      ): 
      ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context , index){
          var post = posts[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: 
            ListTile(
              title: Text(post['title'], style: const TextStyle(fontWeight: FontWeight.bold) ),
              subtitle: Text(post['body'], ),
              trailing: IconButton(onPressed: ()=> tooglePosts(post), 
              icon: isFav(post)? Icon(Icons.favorite_border): Icon(Icons.favorite),
              color: isFav(post)? Colors.red : null ,
              ),
            ),

          );
        }
        )
    );
  }
}