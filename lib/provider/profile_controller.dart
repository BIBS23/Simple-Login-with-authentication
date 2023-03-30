import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileController extends ChangeNotifier {
  List get profbio => _profbio;
  List get profemail => _profemail;
  List get profname => _profname;
  List? get profimage => profileimage;
  String? _mybio;
  String? _name;
  String? _email;
  File? _image;
  final List profileimage = [];
  final List _profname = [];
  final List _profbio = [];
  final List _profemail = [];

  void createProfile(String bio, String email, String name) {
    _mybio = bio;
    _email = email;
    _name = name;
      _profname.insert(0,_name);
      _profbio.insert(0,_mybio);
      _profemail.insert(0,_email);

    notifyListeners();
  }

  Future<void> requestCameraAndStoragePermission() async {
    final statuses = await [
      Permission.camera,
      Permission.storage,
    ].request();
    final cameraStatus = statuses[Permission.camera];
    final storageStatus = statuses[Permission.storage];
    if (cameraStatus != PermissionStatus.granted ||
        storageStatus != PermissionStatus.granted) {
      throw Exception('Camera and Storage permissions are required');
    }
  }

  void pickProfileImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      profileimage.insert(0,_image);
    }
    notifyListeners();
  }
}
