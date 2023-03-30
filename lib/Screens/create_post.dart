import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:soccestalentz/provider/profile_controller.dart';
import 'package:soccestalentz/provider/storage_controller.dart';

class ShowModalWidget extends StatelessWidget {
  const ShowModalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: showModal(context),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        return Container();
      },
    );
  }

  static Future<void> showModal(BuildContext context) {
    TextEditingController mycaption = TextEditingController();
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Consumer2<AccessStorage, ProfileController>(
          builder: (context, access, prof, child) {
            TextEditingController caption = TextEditingController();
            return Scaffold(
              primary: true,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.grey.shade200,
                title: const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    'Share post',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                toolbarHeight: 90,
                leading: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    style: const ButtonStyle(),
                    onPressed: () {
                      access.addImageToPost(mycaption.text);

                      Navigator.pop(context);
                    },
                    child: const Text(
                      'post',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const  EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    child: TextField(
                      controller: mycaption,
                      maxLines: 10,
                      decoration: const  InputDecoration(
                        hintText: 'What do you want to talk about?',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      access.pickImage(ImageSource.camera);
                    },
                    child: const ListTile(
                      leading: Icon(Icons.camera_alt),
                      title: Text('Camera'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      access.pickImage(ImageSource.gallery);
                    },
                    child: const ListTile(
                      leading: Icon(Icons.image),
                      title: Text('Gallary'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
