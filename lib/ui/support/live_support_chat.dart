import 'package:flutter/material.dart';
import 'package:flutter_tawkto/flutter_tawk.dart';
import 'package:petnity/extentions/custom_string_extension.dart';
import 'package:petnity/handlers/secure_handler.dart';
import 'package:petnity/res/app_colors.dart';
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

    setState(() {
      
    });
  }
  

  @override
  void initState() {
    
    getUserDetails();
    super.initState();
  }
  
  
    @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chat Our Support Team', style: TextStyle(fontSize: 16),),
          backgroundColor: AppColors.lightSecondary,
          elevation: 0,
          centerTitle: true,
        ),
        body: Tawk(
          directChatLink: 'https://tawk.to/chat/65d1f07b9131ed19d96e4ae1/1hmu16rns',
          visitor: TawkVisitor(
            name: (userType == 'user') ? customerName.capitalizeFirstOfEach : '${customerName.capitalizeFirstOfEach}(Service Provider)',
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
     
    );
  }
}