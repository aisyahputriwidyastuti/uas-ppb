import 'package:aplikasi_uas/models/inventory.dart';
import 'package:aplikasi_uas/providers/firestore_service.dart';
import 'package:aplikasi_uas/views/data_mhs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_uas/views/popular_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  List<String> docIDs = [];

  Future<void> getDocId() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .orderBy('age', descending: false)
        .get();

    for (var document in snapshot.docs) {
      docIDs.add(document.reference.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Halo, ${user.email!}',
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            child: const Icon(Icons.logout, size: 28),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DataMahasiswa(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                height: 60,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(153, 228, 228, 228),
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, size: 20),
                    Container(
                      width: 300,
                      margin: const EdgeInsets.only(left: 15),
                      child: const TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Cari",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const PopularWidget(), // Tambahkan `const` di sini jika widget tidak memiliki data dinamis.
              const SizedBox(height: 20),
              const Text(
                "Data Mahasiswa",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                ),
              ),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('data_mahasiswa')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var dataMahasiswa = snapshot.data!.docs
                        .map((inventory) =>
                            Inventory.fromSnapshot(inventory))
                        .toList();

                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: dataMahasiswa.length,
                      itemBuilder: (context, index) {
                        var id = snapshot.data!.docs[index].id;

                        return ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DataMahasiswa(
                                  inventory: dataMahasiswa[index],
                                  id: id,
                                ),
                              ),
                            );
                          },
                          title: Text(dataMahasiswa[index].nama),
                          subtitle: Text(dataMahasiswa[index].prodi),
                          trailing: IconButton(
                            onPressed: () {
                              FirestoreService.hapusData(id);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
