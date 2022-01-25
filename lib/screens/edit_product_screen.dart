import 'package:flutter/material.dart';

class EditProuductScreen extends StatefulWidget {
  const EditProuductScreen({Key? key}) : super(key: key);

  static const routName = "/edit-product";

  @override
  _EditProuductScreenState createState() => _EditProuductScreenState();
}

class _EditProuductScreenState extends State<EditProuductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Mahsulotni qo'shish"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Form(
          child: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
        ),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nomi',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
