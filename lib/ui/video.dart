
import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:petnity/extentions/custom_string_extension.dart';
import 'package:petnity/res/app_strings.dart';

import '../handlers/secure_handler.dart';
import '../res/app_colors.dart';
import 'widgets/modals.dart';

class VideoCall extends StatefulWidget {
  final String user1;
  final String user2;
  const VideoCall({Key? key, required this.user1, required this.user2}) : super(key: key);

  @override
  State<VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  String createChannelName(String user1, String user2) {
    List<String> sortedNames = [user1, user2]..sort();
    String channelName = sortedNames.join("_");
    return channelName;
  }

   
  String channelName = "";

  late AgoraClient client;

  String userType = '';

  String guestUsername = '';


getUserDetails() async {
    userType = await StorageHandler.getUserType();

    if (userType == 'user') {
        setState(() {
          guestUsername = widget.user1;
        });
    }else{
       setState(() {
          guestUsername = widget.user2;
        });
    }
    }

  @override
  void initState() {
    super.initState();
    channelName = createChannelName(widget.user1, widget.user2).toLowerCase();  
    initAgora();
    getUserDetails();
  }

  void initAgora() async {
    client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: "300ca74228b44a1f92c8927fabf14f07",
        channelName: channelName,  
        username: widget.user1,
      ),
    );

    await client.initialize();
  }

  @override
  void dispose() {
    onBackPress();
    super.dispose();
  }

  Future<bool> onBackPress() async{
    Navigator.pop(context);

    await client.release();

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    Modals.showToast(channelName);

    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        
        body: SafeArea(
          child: Stack(
            children: [
              AgoraVideoViewer(
                client: client,
                layoutType: Layout.floating,
                enableHostControls: true,
              ),
              AgoraVideoButtons(
                client: client,
                addScreenSharing: false,
              ),
              Positioned(
                top: 100,
                left: 30,
                right: 30,
                child: Align(child: Column(
                  children: [
                    Text('Ringing...', style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: AppStrings.montserrat),),
                    const SizedBox(height: 10,),
                    Text(guestUsername.capitalizeFirstOfEach, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
                  ],
                ))),
            ],
          ),
        ),
      ),
    );
  }
}
