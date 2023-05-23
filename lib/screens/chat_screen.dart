import 'dart:math';
import 'package:chat/widgets/chat/messages.dart';
import 'package:chat/widgets/chat/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("on message:");
      log("on message: $message".length);
      final snackBar =
          SnackBar(content: Text(message.notification?.title ?? ""));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
    // Run code required to handle interacted messages in an async function
    // as initState() must not be async
    // setupInteractedMessage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text(
          'Friends Chat',
          style: TextStyle(
            fontSize: 18,
            color: Colors.yellowAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          DropdownButton(
              underline: Container(),
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  // ignore: sort_child_properties_last
                  child: Row(
                    children: const [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.yellowAccent,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Logout')
                    ],
                  ),
                  value: 'Logout',
                )
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'Logout') {
                  FirebaseAuth.instance.signOut();
                }
              })
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: Stack(
              children: [
                Image.asset(
                  'images/seam.jpg',
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: double.infinity,
                ),
                Messages()
              ],
            )),
            NewMessages()
          ],
        ),
      ),
    );
  }
}
