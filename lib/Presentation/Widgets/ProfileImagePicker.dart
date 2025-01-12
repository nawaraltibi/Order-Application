import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Color/Color.dart';
import 'package:order_application/App/Const/Host.dart';
import 'package:order_application/Presentation/Controllers/Auth/AuthController.dart';
import 'package:order_application/Presentation/Controllers/Profile/ProfileController.dart';

import '../../App/Utils/GetPath.dart';
import '../../Data/Models/User.dart';
import '../Controllers/User/UserController.dart';
import 'DynamicImage.dart';

class ProfileImagePicker extends StatefulWidget {


  const ProfileImagePicker({Key? key,}) : super(key: key);

  @override
  _ProfileImagePickerState createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File? _image;

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null && result.files.isNotEmpty) {
      PlatformFile _selectedFile = result.files.first;

      if (_selectedFile.path != null) {
        setState(() {
          _image = File(_selectedFile.path!);
        });

        try{
          Get.find<AuthController>().updateProfileImage(_image!);
        }catch(e){}
        try{
          Get.find<ProfileController>().updateProfileImage(_image!);
        }catch(e){}

      }
    } else {
      print('Permission denied');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 65.w,
          backgroundColor: Colors.grey[300],
          child: ClipOval(
            child: _image != null
                ? Image.file(
              _image!,
              fit: BoxFit.cover,
            )
                : Get.find<UserController>().user.value.imageName != null
                ? dynamicImage(imagePath: getUserPath(), box: BoxFit.cover)
                : dynamicImage(
              imagePath: 'http://$host/images/users/user.png',
              box: BoxFit.cover,
            )
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: _pickImage,
            child: Container(
              width: 30.w,
              height: 30.h,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 20.h,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
