import 'dart:io';

import 'package:contact_info/screen/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../modal/model.dart';



class AddcontactScreen extends StatefulWidget {
  const AddcontactScreen({super.key});

  @override
  State<AddcontactScreen> createState() => _AddcontactScreenState();
}

TextEditingController txtname = TextEditingController();
TextEditingController txtemail = TextEditingController();
TextEditingController txtnubmber = TextEditingController();
GlobalKey<FormState> key = GlobalKey();
ContactProvider? providerR;
ContactProvider? providerW;
String? path;


class _AddcontactScreenState extends State<AddcontactScreen> {
  @override
  Widget build(BuildContext context) {
    providerR=context.read();
    providerW=context.watch();
    return SafeArea(
      child: Form(
        key: key,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Add Contact"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stepper(
                  currentStep: providerW!.stepindex,
                  onStepContinue: () {
                    providerR!.onStepContinue();

                  },
                  onStepCancel: () {
                    providerR!.onStepCancel();
                  },
                  steps: [
                    Step(
                      title: const Text("Pick Image"),
                      content: Column(
                        children: [
                          providerR!.path==null
                           ?CircleAvatar(
                             radius: 60,
                           )
                          :CircleAvatar(
                            radius: 60,
                            backgroundImage: FileImage(File(providerW!.path!)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  ImagePicker picker = ImagePicker();
                                  XFile? image = await picker.pickImage(
                                      source: ImageSource.camera);
                                  providerR!.addPath(image!.path);
                                },
                                icon: const Icon(Icons.camera_alt),
                              ),
                              IconButton(
                                onPressed: () async {
                                  ImagePicker picker = ImagePicker();
                                  XFile? image = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  providerR!.addPath(image!.path);
                                },
                                icon: const Icon(Icons.photo),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Step(
                      title: const Text("Name"),
                      content: TextFormField(
                        controller: txtname,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please valid name";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "Name",
                        ),
                      ),
                    ),
                    Step(
                      title: const Text("Email"),
                      content: TextFormField(
                        controller: txtemail,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please valid email";
                          } else if (!RegExp(
                                  "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$")
                              .hasMatch(value)) {
                            return "enter the valid email";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "Email",
                        ),
                      ),
                    ),
                    Step(
                      title: const Text("Number"),
                      content: TextFormField(
                        controller: txtnubmber,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please valid number";
                          } else if (value!.length != 10) {
                            return "Enter the valid number";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "Number",
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      DataModel d1 = DataModel(
                        name: txtname.text,
                        email: txtemail.text,
                        contact: txtnubmber.text,
                        image: providerR!.path,
                      );
                      txtname.clear();
                      txtnubmber.clear();
                      txtemail.clear();
                      providerR!.addContact(d1);
                      Navigator.pop(context);
                      providerR!.stepindex=0;
                      providerW!.path="";
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Your data is save"),
                        ),
                      );
                    }
                  },
                  child: Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
