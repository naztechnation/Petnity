
import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/view_models/account_view_model.dart';

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

  @override
  void initState() {
    super.initState();
    channelName = createChannelName(widget.user1, widget.user2);  
    initAgora();
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
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Petnity'),
        centerTitle: true,
      ),
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
              addScreenSharing: true,
            ),
          ],
        ),
      ),
    );
  }
}
