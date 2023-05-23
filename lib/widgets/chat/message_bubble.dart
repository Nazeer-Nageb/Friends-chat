import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message, this.userName, this.userimage, this.isMe,
      {this.key});
  final Key? key;
  final String message;
  final String userName;
  final String userimage;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: !isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(14),
                  topRight: const Radius.circular(14),
                  bottomLeft: !isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(14),
                  bottomRight: isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(14),
                ),
              ),
              width: 140,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  if(!isMe)
                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: !isMe
                          ? Colors.redAccent
                          : Theme.of(context).accentTextTheme.headline6!.color,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text(message,
                      style: TextStyle(
                        fontSize: 15,                        color: !isMe
                            ? Colors.black
                            : Theme.of(context)
                                .accentTextTheme
                                .headline6!
                                .color,
                      ),
                      textAlign: isMe ? TextAlign.end : TextAlign.start),
                ],
              ),
            )
          ],
        ),
        Positioned(
          top: 0,
          left:  !isMe? 120:null,
          right: isMe ?120 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userimage),
          ),
        )
      ],
    );
  }
}
