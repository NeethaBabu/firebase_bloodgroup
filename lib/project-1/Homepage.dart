import 'package:flutter/material.dart';
import 'package:bloodgroup/project-1/Homepage.dart';
import 'package:bloodgroup/project-1/AddButton.dart';
import 'package:bloodgroup/project-1/update.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');
  void deleteDonor(docId) {
    donor.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BLOOD DONATION"),
        backgroundColor: Colors.redAccent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/AddButton');
        },
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: StreamBuilder(
          stream: donor.orderBy('name').snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot donorSnap = snapshot.data.docs[index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 10,
                            spreadRadius: 15,
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: CircleAvatar(
                                backgroundColor: Colors.redAccent,
                                radius: 30,
                                child: Text(
                                  donorSnap['group'],
                                  style: TextStyle(fontSize: 25),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                donorSnap['name'],
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(donorSnap['phone'].toString()),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/update',
                                      arguments: {
                                        'group': donorSnap['group'].toString(),
                                        'name': donorSnap['name'],
                                        'phone': donorSnap['phone'].toString(),
                                        'id': donorSnap.id,
                                      });
                                },
                                icon: Icon(Icons.edit),
                                iconSize: 30,
                                color: Colors.indigo,
                              ),
                              IconButton(
                                onPressed: () {
                                  deleteDonor(donorSnap.id);
                                },
                                icon: Icon(Icons.delete),
                                iconSize: 30,
                                color: Colors.black54,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          }),
    );
  }
}
