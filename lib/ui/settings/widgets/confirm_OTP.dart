import 'dart:async';

import 'package:flutter/material.dart';
import 'package:petnity/res/app_constants.dart';

class ConfirmOTP extends StatefulWidget {
  @override
  _ConfirmOTPState createState() => _ConfirmOTPState();
  final Widget route;
  final String type;
  ConfirmOTP({required this.route, required this.type});
}

class _ConfirmOTPState extends State<ConfirmOTP> {
  List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());
  List<TextEditingController> textControllers =
      List.generate(4, (index) => TextEditingController());

  int _secondsRemaining = 30;
  late Timer _timer;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_secondsRemaining == 0) {
          timer.cancel();
        } else {
          setState(() {
            _secondsRemaining--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();

    focusNodes[0].requestFocus();
  }

  @override
  void dispose() {
    _timer.cancel();
    for (var controller in textControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: screenSize(context).height * .3,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Confirm OTP',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Confirm OTP sent to the ${widget.type} registered with this card',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < 4; i++)
                  Container(
                    width: 50,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: TextField(
                        controller: textControllers[i],
                        focusNode: focusNodes[i],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(border: InputBorder.none),
                        onChanged: (value) {
                          if (value.isNotEmpty && i < 3) {
                            focusNodes[i].unfocus();
                            focusNodes[i + 1].requestFocus();
                          }
                          if (value.isNotEmpty && i == 3) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return widget.route;
                            }));
                          }
                        },
                        maxLength: 1,
                        buildCounter: (BuildContext context,
                                {required int currentLength,
                                required bool isFocused,
                                int? maxLength}) =>
                            null,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: screenSize(context).width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Resend ',
                    style: TextStyle(color: Colors.blue),
                  ),
                  Text('in ${_secondsRemaining} seconds'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
