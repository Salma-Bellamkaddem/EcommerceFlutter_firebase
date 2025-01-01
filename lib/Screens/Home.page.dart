import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: const Text(
          'Home',style: TextStyle(color: Colors.white),
        ),
        ),
        drawer: Drawer(child: ListView(
          padding: EdgeInsets.zero,children: [
            DrawerHeader(decoration: BoxDecoration(color: Color.fromARGB(255, 182, 78, 34)),
            child: Column(
              children: [
                CircleAvatar(backgroundImage:AssetImage("images/av.png") ,
                radius: 35,
                ),
                Text(
              "BELLAMKADDEM SALMA",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
                    user?.email ?? "Guest",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
              ],
            ),
            ),
            ListTile(leading: const Icon(Icons.home),
            title: const Text("Travel App"),
            onTap:(){
              Navigator.pop(context);
            } 
            ),
            const Divider(color: Colors.black,),
            ListTile(leading: const Icon(Icons.location_city),
            title: const Text("Visit city"),
            onTap:(){
              Navigator.pop(context);
            } 
            ),
            const Divider(color: Colors.black,),
            ListTile(leading: const Icon(Icons.account_circle),
            title: const Text("Profil"),
            onTap:(){
              Navigator.pop(context);
            } 
            ),
            const Divider(color: Colors.black,),

            ListTile(leading: const Icon(Icons.settings),
            trailing: const Icon(Icons.arrow_forward),
            title: const Text("Settings"),
            onTap:(){
              Navigator.pop(context);
            } 
            )
          ],
        )),
       body: Center(
        child: Text(
          'Welcome, ${user?.email ?? 'Guest'}',
          style: const TextStyle(fontSize: 24),
        ),
          
        ),
    );
  }
}