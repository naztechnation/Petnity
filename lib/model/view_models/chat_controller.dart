import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:petnity/ui/widgets/modals.dart';

import '../../res/enum.dart';
import 'base_viewmodel.dart';

class MessageController extends BaseViewModel {
  DatabaseReference dbChatList = FirebaseDatabase.instance.ref("ChatListUser");
  DatabaseReference dbChatMessage =
      FirebaseDatabase.instance.ref("UsersChatMessage");
  String messageText = "";
  var scrollCntrl = ScrollController();

  // This is used to create and send chat messages
  String _receiverImage = "";
  String _receiverName = "TestUser";
  String _receiverId = "";
  var chatImageUpload = null;


  updateRecieverDetails({required String receiverImage, required String receiverName,
  required String receiverId,}){

    _receiverName = receiverName;
    _receiverImage = receiverImage;
    _receiverId = receiverId;

    setViewState(ViewState.success);

  }

  // This is used to access a specific chat messages
  var selectedKey = "";

  // This create chat Users for both the sender and the receiver side...
  createChatUser(
      {required String userId,
      required String receiverId,
      required String type,
      required String senderImage,
      required String senderName}) async {
    String key = returnKey(userId: userId, receiverId: receiverId);
    int timeStamp = DateTime.now().millisecondsSinceEpoch;

    dbChatList.child(userId).child(receiverId).set({
      "userId": userId,
      "receiverId": _receiverId,
      "message": messageText,
      "lastMessage": type == "image"
          ? "Image sent ..."
          : messageText.length > 20
              ? "${messageText.substring(0, 20)}..."
              : messageText,
      "timeStamp": -timeStamp,
      "senderImage": senderImage,
      "receiverImage": _receiverImage,
      "senderName": senderName,
      "receiverName": _receiverName,
      "key": key,
      "seen": "false",
      "type": type
    });

    dbChatList.child(receiverId).child(userId).set({
      "userId": userId,
      "receiverId": _receiverId,
      "message": messageText,
      "lastMessage": type == "image"
          ? "Image sent ..."
          : messageText.length > 20
              ? "${messageText.substring(0, 20)}..."
              : messageText,
      "timeStamp": -timeStamp,
      "senderImage": senderImage,
      "receiverImage": _receiverImage,
      "senderName": senderName,
      "receiverName": _receiverName,
      "key": key,
      "seen": "false",
      "type": type
    });

    setViewState(ViewState.success);

  }

  updateChatUser({
    String userId = "",
    String receiverId = "",
  }) async {
    // This is called to update when is recent message is viewed
    await dbChatList.child(userId).child(receiverId).update({
      "seen": "true",
    });
    await dbChatList.child(receiverId).child(userId).update({
      "seen": "true",
    });
    setViewState(ViewState.success);

  }

  sendChatMessages(
      {String userId = "",
      String receiverId = "",
      String isImage = "false",
      String message = "",
      required String senderName}) async {
    // This will be called when messages are to be sent
    String key = returnKey(userId: userId, receiverId: receiverId);

    String type = isImage == "true" ? "image" : "text";
    createChatUser(
        userId: userId,
        receiverId: receiverId,
        type: type,
        senderImage: '',
        senderName: senderName);

    await dbChatMessage.child(key).push().set({
      "userId": userId,
      "receiverId": receiverId,
      "message": message,
      "isSender": "true",
      "senderName": senderName,
      "receiverName": "",
      "isImage": isImage,
      "imageUrl": "",
      "time": DateTime.now().millisecondsSinceEpoch,
    });

    // scrollCntrl.value
    // .animateTo(scrollCntrl.value.positions.last.maxScrollExtent,
    // duration: Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  String returnKey({String userId = "", String receiverId = ""}) {
    return (int.parse(userId) <= int.parse(receiverId))
        ? "${userId}_$receiverId"
        : "${receiverId}_$userId";
  }

  uploadImage(
      {ImageSource source = ImageSource.gallery,
      required String senderName,
      required String senderId}) async {
    final _firebaseStorage = FirebaseStorage.instance;

    await ImagePicker(source: source);

    Modals.showToast(
      "This is the uploaded image.${chatImageUpload.path}",
    );

    if (chatImageUpload != null) {
      String imageTitle = chatImageUpload.path.split("/").last;

      try {
        var snapshot = await _firebaseStorage
            .ref()
            .child("chat_images/$imageTitle")
            .putFile(chatImageUpload);

        if (snapshot != null) {
          var downloadUrl = await snapshot.ref.getDownloadURL();

          // Navigator.pop(context);

          Modals.showToast("Image uploading started");

          sendChatMessages(
            userId: senderId,
            receiverId: _receiverId,
            isImage: "true",
            message: downloadUrl,
            senderName: senderName,
          );
          Modals.showToast("Image uploaded successfully");
        } else {
          // Navigator.pop(context);
        }
      } catch (e) {
        Modals.showToast(e.toString());
      }

      // setState(() {});
    } else {
      // image is null
      Modals.showToast('test: No Image Path Received');
    }
  }

  ImagePicker({
    ImageSource source = ImageSource.gallery,
  }) async {
    // final _firebaseStorage = FirebaseStorage.instance;
    print("This is the problem 1");
    final imagePicker = ImagePicker();
    XFile? image;
    //Check Permissions
    await Permission.photos.request();
    print("This is the problem 2");
    var permissionStatus = await Permission.mediaLibrary.status;

    print("This is the problem 3");

    if (Platform.isAndroid && !permissionStatus.isGranted) {
      print("This is the problem 4");
      return;
    }
    print("This is the problem 5");
    // if (permissionStatus.isGranted) {
    //Select Image
    try {
      image = await imagePicker.pickImage(source: source);
      // .pickImage(source: source);
      print("This is the problem 6");

      final croppedFile = await ImageCropper().cropImage(
        sourcePath: image!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Upload Image',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Upload Image',
          ),
        ],
      );

      print("This is the problem 6");
      var file = File(croppedFile!.path);
       
      print("This is the problem 7");
      if (image != null) {
         
        try {
          chatImageUpload = file;
        } catch (e) {}
      } else {
        
      }
    } catch (exp) {
      print(exp.toString());
    }
    
  }

  String get recieverId => _receiverId;
  String get recieverName => _receiverName;
  String get recieverImage => _receiverImage;

}
