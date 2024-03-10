import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthful/View/Components/build_buttons.dart';
import 'package:healthful/View/theme/light_color.dart';
import 'package:healthful/View/widgets/text_field.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  bool passToggle = true;

  @override
  void initState() {
    super.initState();
  }

  File? imageFile;
  String imageUrl = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Text(
            'Edite Profile',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 49,
                        backgroundColor: LightColor.marron,
                        child: CircleAvatar(
                          radius: 45,
                          backgroundImage: imageFile == null ? const AssetImage("assets/doctor.png") : FileImage(imageFile!) as ImageProvider,
                        ),
                      ),
                      Positioned(
                        bottom: 2,
                        right: 3,
                        child: InkWell(
                          onTap: () {
                            _chooseImage();
                          },
                          child: const CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.green,
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const RoundedTextField(
                  hint: 'Enter Name',
                  color: Colors.transparent,
                  borderColor: Colors.transparent,
                  pIcon: Icon(Icons.person),
                ),
                const SizedBox(height: 10),
                const RoundedTextField(
                  hint: 'Email Address',
                  color: Colors.transparent,
                  borderColor: Colors.transparent,
                  pIcon: Icon(Icons.email),
                ),
                const SizedBox(height: 10),
                const RoundedTextField(
                  hint: 'Phone Number',
                  color: Colors.transparent,
                  borderColor: Colors.transparent,
                  pIcon: Icon(Icons.phone),
                ),
                const SizedBox(height: 10),
                RoundedTextField(
                  obscureText: passToggle,
                  hint: 'Password',
                  color: Colors.transparent,
                  borderColor: Colors.transparent,
                  pIcon: const Icon(Icons.lock),
                  sIcon: InkWell(
                    onTap: () {
                      if (passToggle == true) {
                        passToggle = false;
                      } else {
                        passToggle = true;
                      }
                      setState(() {});
                    },
                    child: passToggle ? const Icon(CupertinoIcons.eye_slash_fill) : const Icon(CupertinoIcons.eye_fill),
                  ),
                ),
                const SizedBox(height: 10),
                RoundedTextField(
                  obscureText: passToggle,
                  hint: 'Confirm Password',
                  color: Colors.transparent,
                  borderColor: Colors.transparent,
                  pIcon: const Icon(Icons.lock),
                  sIcon: InkWell(
                    onTap: () {
                      if (passToggle == true) {
                        passToggle = false;
                      } else {
                        passToggle = true;
                      }
                      setState(() {});
                    },
                    child: passToggle ? const Icon(CupertinoIcons.eye_slash_fill) : const Icon(CupertinoIcons.eye_fill),
                  ),
                ),
                const SizedBox(height: 20),
                Spacer(),
                SizedBox(
                  height: 60,
                  width: 330,
                  child: buildRegisterButton(() async {}, "Update",
                      textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 20, color: LightColor.white)),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ));
  }

  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      // Get.to(() => ImageScreen(image: imageFile, id: widget.id));
    }
  }

  _getFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  _chooseImage() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 115,
            decoration: const BoxDecoration(
                color: LightColor.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    _getFromGallery();
                    Navigator.of(context).pop();
                  },
                  leading: const Icon(
                    Icons.add_a_photo,
                    color: LightColor.white,
                  ),
                  title: const Text('Gallery',
                      style: TextStyle(
                        color: LightColor.black,
                        fontSize: 15.0,
                      )),
                ),
                ListTile(
                  onTap: () {
                    _getFromCamera();
                    Navigator.of(context).pop();
                  },
                  leading: const Icon(
                    Icons.camera,
                    color: LightColor.white,
                  ),
                  title: const Text('Camera',
                      style: TextStyle(
                        color: LightColor.black,
                        fontSize: 15.0,
                      )),
                ),
              ],
            ),
          );
        });
  }

  // Future<String> _uploadImageToFirebase() async {
  //   final file = File(imageFile!.path.toString());
  //   final fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //   final firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
  //   final uploadTask = firebaseStorageRef.putFile(file);
  //   final snapshot = await uploadTask.whenComplete(() => null);
  //   final downloadURL = await snapshot.ref.getDownloadURL();
  //   return downloadURL;
  // }
}
