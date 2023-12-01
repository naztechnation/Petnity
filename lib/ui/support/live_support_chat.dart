import 'package:flutter/material.dart';
import 'package:flutter_tawkto/flutter_tawk.dart';
import 'package:petnity/handlers/secure_handler.dart';
import 'package:petnity/ui/widgets/loading_page.dart';


class LiveSupportPage extends StatefulWidget {
  const LiveSupportPage({Key? key}) : super(key: key);

  @override
  State<LiveSupportPage> createState() => _LiveSupportPageState();
}

class _LiveSupportPageState extends State<LiveSupportPage> {

  String customerName = "";
  String userType = "";
  String email = "";


  getUserDetails() async{

    customerName = await StorageHandler.getUserName();
    
    userType = await StorageHandler.getUserType();
    email = await StorageHandler.getUserEmail();
  }
  

  @override
  void initState() {
    
    getUserDetails();
    super.initState();
  }
  
  
    @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Chat Our Support Team'),
          backgroundColor: const Color(0XFFF7931E),
          elevation: 0,
        ),
        body: Tawk(
          directChatLink: 'https://tawk.to/chat/6569d5ceff45ca7d4785bc3e/1hgimmch6',
          visitor: TawkVisitor(
            name: customerName,
            email: email,
          ),
          onLoad: () {
            print('Hello User!');
          },
          onLinkTap: (String url) {
            print(url);
          },
          placeholder: const Center(
            child: LoadingPage(),
          ),
        ),
      ),
    );
  }
}