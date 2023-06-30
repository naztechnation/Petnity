import 'package:flutter/material.dart';

class NotificationIcon extends StatelessWidget {
  final Widget icon;
  final int nun_of_notifications;
  NotificationIcon({required this.icon, required this.nun_of_notifications});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.0,
      height: 37.0,
      margin: EdgeInsets.only(top: 10),
      child: Stack(
        children: [
          icon,
          Positioned(
            right: 0.0,
            top: 0.0,
            child: Container(
              padding: EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              constraints: BoxConstraints(
                minWidth: 16.0,
                minHeight: 16.0,
              ),
              child: Text(
                nun_of_notifications.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
