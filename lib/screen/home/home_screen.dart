import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/contact_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController txtname = TextEditingController();
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtnubmber = TextEditingController();
  ContactProvider? providerR;
  ContactProvider? providerW;

  @override
  Widget build(BuildContext context) {
    providerR = context.read<ContactProvider>();
    providerW = context.watch<ContactProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                providerR!.changeThem();
              },
              icon: Icon(
                  providerR!.islight ? Icons.light_mode : Icons.dark_mode)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: providerR!.contactList.length,
            itemBuilder: (context, index) => Column(children: [
                  Row(children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: FileImage(
                          File("${providerW!.contactList[index].image}")),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${providerW!.contactList[index].name}",
                            style: const TextStyle(fontSize: 20)),
                        Text("${providerW!.contactList[index].contact}",
                            style: const TextStyle(fontSize: 15)),
                      ],
                    ),
                  ]),
                ])),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Navigator.pushNamed(context, 'add_data').then((value) {
              setState(() {});
            });
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
