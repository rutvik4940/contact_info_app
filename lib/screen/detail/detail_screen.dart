import 'dart:io';
import 'package:contact_info/modal/model.dart';
import 'package:contact_info/screen/addcontact/addcontact_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../provider/contact_provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int index = 0;

  String path = "";
  ContactProvider? providerR;
  ContactProvider? providerW;
  TextEditingController txtname = TextEditingController();
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtnubmber = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    index = ModalRoute.of(context)!.settings.arguments as int;
    providerR = context.read<ContactProvider>();
    providerW = context.watch<ContactProvider>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Detail"),
          actions: [
            IconButton(
                onPressed: () {
                  providerR!.deleteContact(index);
                  Navigator.pop(context);
                },
                icon: Icon(Icons.delete)),
            IconButton(
                onPressed: () {
                  editDialog(context, index);
                },
                icon: Icon(Icons.edit)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      FileImage(File("${providerW!.contactList[index].image}")),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton.filled(
                    onPressed: () async {
                      String link =
                          "tel:+91${providerR!.contactList[index].contact}";
                      await launchUrl(Uri.parse(link));
                    },
                    icon: const Icon(Icons.call),
                  ),
                  IconButton.filled(
                    onPressed: () async {},
                    icon: const Icon(Icons.message),
                  ),
                  IconButton.filled(
                    onPressed: () {},
                    icon: const Icon(Icons.video_call),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text("${providerW!.contactList[index].name}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              Text("${providerW!.contactList[index].email}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${providerW!.contactList[index].contact}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              IconButton(onPressed: () {
                providerR!.hidelock(index);
              }, icon: Icon(Icons.lock))
            ],
          ),
        ),
      ),
    );
  }

  void editDialog(BuildContext context, int index) {
    txtnubmber.text = providerR!.contactList[index].contact!;
    txtemail.text = providerR!.contactList[index].email!;
    txtname.text = providerR!.contactList[index].name!;
    providerR!.edit(providerR!.contactList[index].image!);
    showDialog(
        context: context,
        builder: (context) {
          return Form(
            key: key,
            child: SingleChildScrollView(
              child: AlertDialog(
                  title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Stack(alignment: Alignment.center, children: [
                      providerW!.addImage!.isEmpty
                          ? const CircleAvatar(
                              radius: 50,
                            )
                          : CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  FileImage(File(providerW!.addImage!)),
                            ),
                      Align(
                          alignment: const Alignment(0.3, 0.3),
                          child: IconButton(
                            onPressed: () async {
                              ImagePicker picker = ImagePicker();
                              XFile? image = await picker.pickImage(
                                  source: ImageSource.camera);
                              providerR!.editI(image!.path);
                            },
                            icon: const Icon(
                              Icons.add_a_photo_rounded,
                              color: Colors.blueAccent,
                              weight: 50,
                            ),
                          )),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: txtname,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "name is required";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: "Enter Name",
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: txtnubmber,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "mobile no. is required";
                            } else if (value!.length != 10) {
                              return "Enter the valid number";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: "Enter Mobile Number",
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: txtemail,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email is required ";
                            } else if (!RegExp(
                                    "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$")
                                .hasMatch(value)) {
                              return "enter the valid email";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: "Enter Email id",
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (key.currentState!.validate()) {
                                DataModel c3 = DataModel(
                                    name: txtname.text,
                                    contact: txtnubmber.text,
                                    image: providerR!.addImage,
                                    email: txtemail.text);
                                providerR!.updateContact(index: index, c2: c3);
                                txtname.clear();
                                txtnubmber.clear();
                                txtemail.clear();
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              "update",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )),
            ),
          );
        });
  }
}
