import 'package:flutter/material.dart';
import 'package:my_assistant/screens/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});
  static String routename = "/accName";

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController job = TextEditingController();
  final TextEditingController address = TextEditingController();
  String gender = 'Male';
  
  Future <void> savedata() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', firstName.text);
    await prefs.setString('lastName', lastName.text);
    await prefs.setString('email', email.text);
    await prefs.setString('job', job.text);
    await prefs.setString('address', address.text);
    await prefs.setString('gender', gender);
    prefs.setBool('loggedIn', true);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage() ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Acoount'), centerTitle: true,backgroundColor: Colors.blue.shade100, ),
    body: Padding(padding: EdgeInsets.all(16),
    child: Form(
      key: _formKey,
      child: ListView(
        children: [
          TextFormField(
            controller: firstName,
            decoration: InputDecoration(
              labelText: 'First Name'
            ),
          ),
          TextFormField(
            controller: lastName,
            decoration: InputDecoration(
              labelText: 'Last Name'
            ),
          ),
          TextFormField(
            controller: email,
            decoration: InputDecoration(
              labelText: 'Email'
            ),
          ),
          TextFormField(
            controller: job,
            decoration: InputDecoration(
              labelText: 'Job'
            ),
          ),
          TextFormField(
            controller: address,
            decoration: InputDecoration(
              labelText: 'Address'
            ),
          ),
          DropdownButtonFormField(
          value: gender,
          items:  [
              DropdownMenuItem( value: 'Male' ,child: Text('Male')),
              DropdownMenuItem( value: 'Female' ,child: Text('Female')),
          ],
          
           onChanged: (value){
            setState(() {
              gender = value!;
            });
           }),
           SizedBox(height: 20,),
           ElevatedButton(onPressed: savedata, child: Text('Save Account'))
        ],
      )
      ),
    ),

    );


  }
}