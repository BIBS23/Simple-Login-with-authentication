import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../provider/profile_controller.dart';
import 'add_bio.dart';

class CreateProfile extends StatefulWidget {
  final String? bio;
  final String? name;
  final String? email;
  const CreateProfile({
    Key? key,
    this.bio,
    this.name,
    this.email,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<CreateProfile> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('My Profile'),
      ),
      body: Consumer<ProfileController>(builder: (context, prof, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.5,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.blue.shade400,
                            Colors.blue.shade800,
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        top: 50,
                        left: 0,
                        right: 0,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: GestureDetector(
                            onTap: () {
                              prof.requestCameraAndStoragePermission();
        
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        leading: const Icon(Icons.camera_alt),
                                        title: const Text('Take a photo'),
                                        onTap: () {
                                          Navigator.pop(context);
        
                                          prof.pickProfileImage(
                                              ImageSource.camera);
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.image),
                                        title: const Text('Choose from gallery'),
                                        onTap: () {
                                          Navigator.pop(context);
                                          prof.pickProfileImage(
                                              ImageSource.gallery);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage: prof.profileimage.isNotEmpty
                                  ? FileImage(prof.profileimage[0])
                                  : const AssetImage('assets/defaultprof.jpg')
                                      as ImageProvider,
                            ),
                          ),
                        )),
                    Positioned(
                      bottom: 40,
                      right: 0,
                      left: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                              style: ButtonStyle(
                                  minimumSize: const MaterialStatePropertyAll(
                                      Size(150, 50)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AddBioScreen()));
                              },
                              child: const Text('Edit Bio')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                        prof.profname.isNotEmpty
                            ? prof.profname[0].toUpperCase()
                            : '',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 5)),
                    const SizedBox(height: 16),
                    Text(prof.profemail.isNotEmpty ? 'Email' : '',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3)),
                    const SizedBox(height: 16),
                    Text(
                      prof.profemail.isNotEmpty ? prof.profemail[0] : '',
                    ),
                    const SizedBox(height: 16),
                    prof.profbio.isNotEmpty
                        ? const Text('About Me',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 3))
                        : const Text(''),
                    const SizedBox(height: 8),
                    prof.profbio.isNotEmpty
                        ? Text(
                            prof.profbio[0],
                            style: const TextStyle(fontSize: 15),
                          )
                        : const Text(''),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
