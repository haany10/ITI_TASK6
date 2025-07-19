import 'package:flutter/material.dart';
import 'package:my_assistant/screens/profile_screen.dart';
import 'package:my_assistant/screens/tasks_screen.dart';
import 'package:my_assistant/screens/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String fullname = '';

  final List <Widget> _screens = [
    HomeTab(),
    TasksScreen(),
    ProfileScreen()
  ];
  
   @override
  void initState() {
    super.initState();
    _loadname();
  }

  Future <void> _loadname() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String first = await prefs.getString('firstName')?? '' ;
    String last = await prefs.getString('lastName')?? '' ;
    setState(() {
      fullname = '$first $last';
    });

  }

  void _onItemSelected(index){
    setState(() {
      _selectedIndex = index;
    });
  }
  
  void _logout () async{
    SharedPreferences prefs  = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>WelcomeScreen()) , (_)=>false );

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Assistant App'), centerTitle: true,),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              title: const Text('Tasks'),
              onTap: () => setState(() => _selectedIndex = 1),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () => setState(() => _selectedIndex = 2),
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: _logout,
            ),
          ],
        ),
      ),
      body: _screens[_selectedIndex] ,
      bottomNavigationBar: BottomNavigationBar(
        
        backgroundColor: Colors.blue.shade700,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.blue.shade200,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemSelected,
        items:
        [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home" , activeIcon: Icon(Icons.home_filled)),
          BottomNavigationBarItem(icon: Icon(Icons.task_outlined), label: "Tasks" , activeIcon: Icon(Icons.task_rounded)),
          BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined), label: "Profile" , activeIcon: Icon(Icons.person_2_rounded) )
        ]
        ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  Future<String> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String first = prefs.getString('firstName') ?? '';
    String last = prefs.getString('lastName') ?? '';
    return '$first $last';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(future: getName(),
    builder: (context , snapshot){
       if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
       return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome, ${snapshot.data}!', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Image.network("https://pbs.twimg.com/profile_images/1937252743254540288/QsSNe1zh_400x400.jpg"),
                ),
              ),
            ],
          ),
        );
    }
    
    );
  }
}