

import 'package:flutter/material.dart';

import '../../res/app_colors.dart';
import '../../res/app_constants.dart';
import '../widgets/back_button.dart';



class User {
  final String name;
  final String email;
  final String imageUrl;
  final int messageCount;

  User({
    required this.name,
    required this.email,
    required this.imageUrl,
  required this.messageCount,
  });
}

class AllUsersChat extends StatelessWidget {
  final List<User> userList = [
    User(name: 'John Doe', email: 'john.doe@example.com', imageUrl: 'https://example.com/johndoe.jpg', messageCount: 3),
    User(name: 'Jane Smith', email: 'jane.smith@example.com', imageUrl: 'https://example.com/janesmith.jpg', messageCount: 1),
    // Add more users as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
        preferredSize: screenSize(context) * .1,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: AppBar(
            elevation: 0,
            backgroundColor: AppColors.lightBackground,
            leading: backButton(context),
            title: Text(
              'Live Chat Support',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
        ),
      ),
        body: ListView.builder(
          itemCount: userList.length * 2 - 1, // Adjusted item count to include dividers
          itemBuilder: (context, index) {
            if (index.isOdd) {
              return Divider(height: 0,);
            }

            final userIndex = index ~/ 2;
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(userList[userIndex].imageUrl),
              ),
              title: Text(userList[userIndex].name),
              subtitle: Text(userList[userIndex].email),
              trailing: _buildMessageCountBubble(userList[userIndex].messageCount),
            );
          },
        ),
      );
    
  }

    Widget _buildMessageCountBubble(int count) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
      child: Text(
        count.toString(),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

}
