import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_movie_app/apis/firebase.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class CustomUserAvatar extends StatefulWidget {
  const CustomUserAvatar({Key? key}) : super(key: key);

  @override
  State<CustomUserAvatar> createState() => _CustomUserAvatarState();
}

class _CustomUserAvatarState extends State<CustomUserAvatar> {
  bool isUserAvatar = false;
  bool isNotSelected = true;
  File? _image; // 변수 선언
  String path = "";
  final ImagePicker picker = ImagePicker();
  // final imgStorage =
  //     FirebaseStorage.instance.refFromURL("gs://gdsc-movie-app.appspot.com");

  Future<void> getImage(ImageSource imageSource, String uid) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        path = pickedFile.path;
        Logger().d(path);
        _image = File(path);
        isNotSelected = true;
      });
      // try {
      //   imgStorage.child("user_img").child(uid).putFile(
      //         File("assets/1575984584817365.jpg"),
      //       );
      // } catch (e) {
      //   Logger().d(e);
      // }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(builder: (context, userState, child) {
      return !isUserAvatar
          ? IconButton(
              tooltip: "add user image",
              onPressed: () {
                getImage(ImageSource.gallery, userState.uid!);
                try {
                  FirebaseStorage.instance
                      .refFromURL(
                          "gs://gdsc-movie-app.appspot.com/user_img/${userState.uid}/KakaoTalk_20231215_175441153.jpg")
                      .getDownloadURL()
                      .then((value) {
                    Logger().d(value);
                    userState.userAvatarUrl = value;
                    setState(() {
                      isNotSelected = true;
                    });
                    Logger().d(userState.userAvatarUrl);
                  });
                } catch (e) {
                  Logger().d(e);
                }
              },
              icon: const Icon(Icons.image_search),
              iconSize: 50,
            )
          : CircleAvatar(
              minRadius: 100,
              foregroundImage:
                  NetworkImage(userState.userAvatarUrl ?? "", scale: 0.6),
            );
    });
  }
}
