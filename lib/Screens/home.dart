import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccestalentz/provider/profile_controller.dart';
import 'package:soccestalentz/provider/storage_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isExpanded = false;
  bool iconColor = false;
  @override
  Widget build(BuildContext context) {
    return Consumer2<ProfileController, AccessStorage>(
        builder: (context, prof, access, child) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Soccer Talentz'),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: prof.profileimage.isNotEmpty
                    ? FileImage(prof.profileimage[0])
                    : const AssetImage('assets/defaultprof.jpg')
                        as ImageProvider,
              ),
            ),
          ),
          body: ListView.builder(
              itemCount: access.myposts.length,
              itemBuilder: ((context, index) {
                return SingleChildScrollView(
                  child: Column(children: [
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 60,
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: access.myposts.isNotEmpty
                              ? CircleAvatar(
                                  radius: 23,
                                  backgroundImage: prof.profileimage.isNotEmpty
                                      ? FileImage(prof.profileimage[0])
                                      : const AssetImage(
                                              'assets/defaultprof.jpg')
                                          as ImageProvider)
                              : null,
                        ),
                        const SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Column(
                              children: [
                                Text(
                                    prof.profname.isNotEmpty
                                        ? prof.profname[0]
                                            .toString()
                                            .toUpperCase()
                                        : '',
                                    style: const TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold)),
                                       const  SizedBox(height: 3),
                                Text(prof.profbio[0].toString().length > 10? '${prof.profbio[0]}...':prof.profbio[0],style: const  TextStyle(
                                  fontSize: 13,fontWeight: FontWeight.w500
                                ),),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 210),
                          child: IconButton(onPressed: (){}, icon: Icon(Icons.more_vert)),
                        ),
                      ]),
                    ),
                    
                    SizedBox(
                      child: Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                access.captions[index],
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                                maxLines: isExpanded ? null : 2,
                              )),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            child: Text(access.captions[index])
                                        .toString()
                                        .split('\n')
                                        .length >
                                    2
                                ? isExpanded
                                    ? const Text('read more')
                                    : const Text('Read less')
                                : const SizedBox(),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: access.myposts[index] != null
                            ? Image.file(access.myposts[index])
                            : const SizedBox(),
                      ),
                      onDoubleTap: () {
                        setState(() {
                          iconColor = !iconColor;
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                        child: Row(
                      children: [
                        const SizedBox(width: 30),
                        Icon(
                          Icons.thumb_up_alt_rounded,
                          color: iconColor ? Colors.blue : null,
                        ),
                        const SizedBox(width: 60),
                        const Icon(Icons.comment_rounded),
                        const SizedBox(width: 60),
                        const Icon(Icons.share_rounded)
                      ],
                    )),
                  ]),
                );
              })));
    });
  }
}
