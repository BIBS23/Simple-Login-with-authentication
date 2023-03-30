import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

class AccessStorage extends ChangeNotifier {
  File? get image => _image;
  List get myposts => _mypost;
  List get captions => _caption;
  final List _mypost = [];
  final List _caption = [];
  File? _image;
  bool isactive = false;
  final bool _imageSelected = true;

  Future<void> accessMyStorage() async {
    final access = await [Permission.camera, Permission.storage].request();
    final camerastatus = access[Permission.camera];
    final storagestatus = access[Permission.storage];

    if (camerastatus != PermissionStatus.granted ||
        storagestatus != PermissionStatus.granted) {
      throw Exception('Give Access');
    }
    notifyListeners();
  }

  void pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      notifyListeners();
    }
  }

  void addImageToPost(String caption) {
    if (_imageSelected == true) {
      _mypost.add(_image);
      _caption.add(caption);
      notifyListeners();
    }
  }

  void pickVideo(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      notifyListeners();
    }
  }
}
