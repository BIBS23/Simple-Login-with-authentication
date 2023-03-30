import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/profile_controller.dart';

class AddBioScreen extends StatefulWidget {
  const AddBioScreen({Key? key}) : super(key: key);

  @override
  _AddBioScreenState createState() => _AddBioScreenState();
}

class _AddBioScreenState extends State<AddBioScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const  Icon(Icons.close),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
                Provider.of<ProfileController>(context, listen: false)
                    .createProfile(_bioController.text, _emailController.text,
                        _nameController.text);
              },
              icon: const Icon(Icons.check)),
          const SizedBox(width: 20)
        ],
        title: const Text('Edit Bio'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email address',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                maxLength: 100,
                controller: _bioController,
                decoration: const InputDecoration(
                  labelText: 'Bio',
                  hintText: 'Tell us about yourself',
                ),
                maxLines: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
