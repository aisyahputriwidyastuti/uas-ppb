import 'package:aplikasi_uas/models/inventory.dart';
import 'package:aplikasi_uas/providers/firestore_service.dart';
import 'package:flutter/material.dart';

class DataMahasiswa extends StatefulWidget {
  const DataMahasiswa({super.key, this.inventory, this.id});
  
  final Inventory? inventory;
  final String? id;

  @override
  State<DataMahasiswa> createState() => _DataMahasiswaState();
}

class _DataMahasiswaState extends State<DataMahasiswa> {
  late TextEditingController nameController;
  late TextEditingController prodiController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    prodiController = TextEditingController();

    if (widget.inventory != null) {
      nameController.text = widget.inventory!.nama;
      prodiController.text = widget.inventory!.prodi;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    prodiController.dispose();
    super.dispose();
  }

  // Function to show dialog
  void _showDialog(String message) {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Function to save data
  Future<void> _saveData() async {
    try {
      if (widget.inventory != null) {
        await FirestoreService.editData(
          Inventory(
            nama: nameController.text,
            prodi: prodiController.text,
          ),
          widget.id!,
        );
      } else {
        await FirestoreService.addInventory(
          Inventory(
            nama: nameController.text,
            prodi: prodiController.text,
          ),
        );
      }
      
      if (!mounted) return;
      
      Navigator.of(context).pop();
      _showDialog('Data has been saved successfully!');
    } catch (e) {
      if (!mounted) return;
      _showDialog('Error saving data: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Mahasiswa'),
        actions: [
          IconButton(
            onPressed: _saveData,
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Masukkan Nama Mahasiswa',
                label: Text('Nama Mahasiswa'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: prodiController,
              decoration: const InputDecoration(
                hintText: 'Masukkan Prodi Mahasiswa',
                label: Text('Prodi Mahasiswa'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}