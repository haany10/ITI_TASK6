import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../globals.dart';   

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<Map<String, String>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'First Name': prefs.getString('firstName') ?? '',
      'Last Name': prefs.getString('lastName') ?? '',
      'Email': prefs.getString('email') ?? '',
      'Job Title': prefs.getString('job') ?? '',
      'Address': prefs.getString('address') ?? '',
      'Gender': prefs.getString('gender') ?? '',
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: getUserData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return AnimatedOpacity(
          duration: const Duration(seconds: 1),
          opacity: 1,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                
                const Text('Profile Information',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                ...snapshot.data!.entries.map(
                  (entry) => ListTile(title: Text('${entry.key}: ${entry.value}')),
                ),

                const SizedBox(height: 20),
                const Divider(),

                
                const Text('Completed Tasks',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),

                
                if (completedTasks.isEmpty)
                  const Text('No completed tasks yet.'),

                
                ...completedTasks.map(
                  (task) => ListTile(
                    leading: const Icon(Icons.check, color: Colors.green),
                    title: Text(
                      task,
                      style: const TextStyle(decoration: TextDecoration.lineThrough),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
