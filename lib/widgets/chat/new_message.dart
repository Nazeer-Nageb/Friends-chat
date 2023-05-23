import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({super.key});

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  final _controller = TextEditingController();
  String _enteredMessage = '';
  _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user =  FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'cratedAt': Timestamp.now(),
      'username': userData['username'],
      'userId': user.uid,
      'userimage':userData['image_url']
    });
    _controller.clear();
    setState(() {
      _enteredMessage= '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextFormField(
                autocorrect: true,
                    enableSuggestions: true,
                    textCapitalization: TextCapitalization.sentences,
            controller: _controller,
            decoration: InputDecoration(labelText: 'send a message.......'),
            onChanged: (val) {
              setState(() {
                _enteredMessage = val;
              });
            },
          )),
          InkWell(
              onTap: () =>
                  _enteredMessage.trim().isEmpty ? null : _sendMessage(),
              child: Icon(
                Icons.send,
                color: _controller.text.isEmpty
                    ? Color.fromARGB(255, 90, 88, 88)
                    : Theme.of(context).primaryColor,
              )),
            
        ],
      ),
    );
  }
}
