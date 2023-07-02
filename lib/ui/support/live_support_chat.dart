import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:petnity/ui/widgets/text_edit_view.dart';

import '../widgets/back_button.dart';

class LiveSupport extends StatefulWidget {
  @override
  State<LiveSupport> createState() => _LiveSupportState();
}

class _LiveSupportState extends State<LiveSupport> {
  TextEditingController bug = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _moveTextFieldAboveKeyboard();
      }
    });
  }

  void _moveTextFieldAboveKeyboard() {
    Future.delayed(Duration(milliseconds: 300), () {
      final currentContext = context;
      if (currentContext != null) {
        final renderObject = currentContext.findRenderObject();
        if (renderObject != null) {
          final keyboardHeight =
              MediaQuery.of(currentContext).viewInsets.bottom;
          final screenHeight = MediaQuery.of(currentContext).size.height;
          final textEntryHeight = renderObject.paintBounds.size.height;

          final scrollController = PrimaryScrollController.of(currentContext);
          if (scrollController != null) {
            scrollController.animateTo(
              screenHeight - keyboardHeight - textEntryHeight,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.lightBackground,
      appBar: PreferredSize(
        preferredSize: screenSize(context) * .1,
        child: Container(
          width: screenSize(context).width,
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              backButton(context),
              Container(
                width: screenSize(context).width * .8,
                child: ListTile(
                  leading: CircleAvatar(
                    child: ImageView.asset(AppImages.catPic),
                  ),
                  title: Text(
                    'Live Support',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Active'),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: screenSize(context).height * .9,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                messageBubble(context, message: 'message', user: true),
                messageBubble(context, message: 'hello', user: false),
                messageBubble(context,
                    message:
                        'How are you doing this fine cold morning? i hope you are doing fine.',
                    user: false),
                messageBubble(context,
                    message:
                        'I am doing just fine mate, thanks for the look out. the only thing disturbing right now is the weather',
                    user: true),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                // height: screenSize(context).height * .12,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: IconButton(
                        icon: Icon(Icons.attach_file),
                        onPressed: () {
                          // Handle attachment icon press
                        },
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: TextEditView(
                          fillColor: Colors.white,
                          borderRadius: 30,
                          controller: bug,
                          suffixIcon: IconButton(
                            icon: Icon(Icons.mic),
                            onPressed: () {
                              // Handle microphone icon press
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: () {
                          // Handle camera icon press
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget messageBubble(context, {required String message, required bool user}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0),
      width: screenSize(context).width,
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment:
            user ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                user ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              !user
                  ? CircleAvatar(
                      child: ImageView.asset(AppImages.catPic),
                    )
                  : Container(),
              SizedBox(width: 10),
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  // margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: user ? Colors.blue : AppColors.lightCanvas,
                    borderRadius: user
                        ? BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            topRight: Radius.circular(12.0),
                            bottomLeft: Radius.circular(12.0),
                            bottomRight: Radius.circular(0.0),
                          )
                        : BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            topRight: Radius.circular(12.0),
                            bottomRight: Radius.circular(12.0),
                            bottomLeft: Radius.circular(0.0),
                          ),
                  ),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: user ? Colors.white : Colors.black,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              user
                  ? CircleAvatar(
                      child: ImageView.asset(AppImages.catPic),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}
