import 'package:chat/screens/profile.dart';
import 'package:chat/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('cratedAt', descending: true)
          .snapshots(),
      builder: (ctx, snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        final docs = snapShot.data?.docs;
        final user = FirebaseAuth.instance.currentUser;
        return ListView.builder(
            reverse: true,
            itemCount: docs?.length,
            itemBuilder: (context, index) => InkWell(
                  onTap: () async {
                    final userData = await FirebaseFirestore.instance
                        .collection('Users')
                        .doc(docs[index]['userId'])
                        .get();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => profile(
                            is_my: docs[index]['userId'] == user.uid,
                            userName: userData['username'],
                            email: userData['email'],
                            userimage: userData['image_url'],
                            phone: userData['phone'])));
                  },
                  child: MessageBubble(
                    docs![index]['text'],
                    docs[index]['username'],
                    docs[index]['userimage'],
                    docs[index]['userId'] == user!.uid,
                    key: ValueKey(docs[index].id),
                  ),
                ));
      },
    );
  }
}
