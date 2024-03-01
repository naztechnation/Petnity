import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:petnity/handlers/secure_handler.dart';
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

  String _selectedKey = ""; 

  updateSelectedKey(String orderId, String recieverId){

    _selectedKey = returnKey(orderId: orderId, receiverId: recieverId);

     

    setViewState(ViewState.success);

  }

  createChatUser(
      {required String orderId,
      required String receiverId,
      required String type,
      required String senderImage,
      required String senderName}) async {
    String key = returnKey(orderId: orderId, receiverId: receiverId);
    int timeStamp = DateTime.now().millisecondsSinceEpoch;

    dbChatList.child(orderId).child(receiverId).set({
      "orderId": orderId,
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

    dbChatList.child(receiverId).child(orderId).set({
      "orderId": orderId,
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
    String orderId = "",
    String receiverId = "",
  }) async {
    // This is called to update when is recent message is viewed
    await dbChatList.child(orderId).child(receiverId).update({
      "seen": "true",
    });
    await dbChatList.child(receiverId).child(orderId).update({
      "seen": "true",
    });
    setViewState(ViewState.success);

  }

    getUserId() async{

    String userType = await StorageHandler.getUserType();
    String userId = '';
    if(userType == 'user'){
     userId = await StorageHandler.getUserId();

    }else{
     userId = await StorageHandler.getAgentId();

    }

    return userId;
  }

  sendChatMessages(
      {String orderId = "",
      String receiverId = "",
      String isImage = "false",
      String message = "",
      required String senderName}) async {
    // This will be called when messages are to be sent
    String key = returnKey(orderId: orderId, receiverId: receiverId);

    String type = isImage == "true" ? "image" : "text";
    createChatUser(
        orderId: orderId,
        receiverId: receiverId,
        type: type,
        senderImage: '',
        senderName: senderName);

      String userId =  await getUserId();

       

    await dbChatMessage.child(key).push().set({
      "orderId": orderId,
      "receiverId": receiverId,
      "senderId": userId,
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

  String returnKey({String orderId = "", String receiverId = ""}) {
    return  "${orderId}_$receiverId";
  }

  uploadImage(
      {ImageSource source = ImageSource.gallery,
      required String recieverId,
      required String orderId}) async {
    final _firebaseStorage = FirebaseStorage.instance;

    await ImagesPicker(source: source);

     

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
            orderId: orderId,
            receiverId: recieverId,
            isImage: "true",
            message: downloadUrl,
            senderName: '',
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

  ImagesPicker({
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
        compressQuality: 20,
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
  String get selectedKey => _selectedKey;
  String get recieverName => _receiverName;
  String get recieverImage => _receiverImage;

}
