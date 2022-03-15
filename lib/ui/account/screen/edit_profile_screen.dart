import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import '../../../constants/asset_constants.dart';
import '../../../constants/param_constants.dart';
import '../../../constants/string_constants.dart';
import '../../../provider/user_detail_provider.dart';
import '../../../utils/methods/reusable_methods.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/text_form_field_container.dart';

class EditProfileScreen extends StatefulWidget {
  final String name;

  const EditProfileScreen({Key? key, required this.name}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final _currentUser = FirebaseAuth.instance.currentUser;
  final _fireStoreInstance = FirebaseFirestore.instance;
  bool isUpdate = false;
  final _formKey = GlobalKey<FormState>();
  File? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text(kEditProfile),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Consumer<UserData>(builder: (context, userData, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                file == null
                    ? userData.profileImage.contains("assets/")
                        ? const CircleAvatar(
                            radius: 70.0,
                            backgroundImage: AssetImage(kAvatarImagePath),
                          )
                        : CircleAvatar(
                            radius: 70.0,
                            backgroundImage:
                                NetworkImage(userData.profileImage),
                          )
                    : CircleAvatar(
                        radius: 70.0,
                        backgroundImage: FileImage(file!),
                      ),
                heightSizedBox(height: 30.0),
                _userNameFormField(),
                _pickImageButton(),
                isUpdate
                    ? customCircularIndicator()
                    : _updateButton(userData, context),
              ],
            );
          }),
        ),
      ),
    );
  }

  Form _userNameFormField() => Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: TextFormFieldContainer(
          label: kUsername,
          inputType: TextInputType.text,
          controller: _controller,
          focusNode: _focusNode,
          onSubmit: (value) {},
          validator: validateName,
        ),
      );

  CustomButton _pickImageButton() => CustomButton(
        title: kPickImage,
        onPress: () {
          chooseImage();
        },
      );

  _updateButton(UserData userData, BuildContext context) => CustomButton(
        title: kUpdate,
        onPress: () async {
          await updateProfile();
          final snapshots = await _fireStoreInstance
              .collection("Trainers")
              .doc(_currentUser?.email)
              .get();

          userData.updateProfile(snapshots);
          Navigator.pop(context);
        },
      );

  updateProfile() async {
    String url = "";
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          isUpdate = true;
        });
        if (file != null) {
          url = await uploadImage();
        }
        await _fireStoreInstance
            .collection("Trainers")
            .doc(_currentUser?.email)
            .update({paramUserName: _controller.text, paramProfileImage: url});
        showMessage("Profile update successfully!");
        setState(() {
          isUpdate = false;
        });
      } catch (e) {
        setState(() {
          isUpdate = false;
        });
        showMessage("Failed to update profile");
      }
    }
  }

  chooseImage() async {
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    file = File(xFile!.path);
    setState(() {});
  }

  Future<String> uploadImage() async {
    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref()
        .child("profile")
        .child(_currentUser!.uid + "_" + basename(file!.path))
        .putFile(file!);

    return taskSnapshot.ref.getDownloadURL();
  }
}
