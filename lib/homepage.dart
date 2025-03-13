// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/constans.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<QueryDocumentSnapshot> data = [];

  getData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('categoris').get();
    data.addAll(querySnapshot.docs);
    setState(() {
      
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: MyColors.myYellow,
          onPressed: () {
            Navigator.of(context).pushNamed("addcategory");
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('Firebase Install'),
          actions: [
            IconButton(
                onPressed: () async {
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  googleSignIn.disconnect();
                  await FirebaseAuth.instance.signOut();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("login", (route) => false);
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: GridView.builder(
          itemCount: data.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisExtent: 160),
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Image.asset(
                      "images/fl.png",
                      height: 100,
                    ),
                    Text("${data[index]['name']}")
                  ],
                ),
              ),
            );
          },

          /*FirebaseAuth.instance.currentUser!.emailVerified
            ? const Text("succesfuly verifed")
            : MaterialButton(
              textColor: Colors.white,
              color: Colors.red,
              onPressed: (){
                FirebaseAuth.instance.currentUser!.sendEmailVerification();
            },child: const Text("please verifed Email"),)

            Card(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Image.asset(
                      "images/fl.png",
                      height: 100,
                    ),
                    Text("Favorit")
                  ],
                ),
              ),
            )*/
        ));
  }
}
