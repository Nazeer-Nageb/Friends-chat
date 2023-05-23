import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class profile extends StatelessWidget {
  final bool is_my;
  final String userName;
  final String email;
  final String userimage;
  final String phone;

  const profile(
      {super.key,
      required this.is_my,
      required this.userName,
      required this.email,
      required this.userimage,
      required this.phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: is_my
            ? const Text(
                'My Profile',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.yellowAccent,
                  fontWeight: FontWeight.bold,
                ),
              )
            : const Text(
                'Your Profile',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.yellowAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
      backgroundColor: Colors.cyan,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 20)),
            CircleAvatar(
              backgroundImage: NetworkImage(userimage),
              radius: 150,
            ),
           
            ListTile(
                  leading: const Icon(
                    Icons.person,
                    color: Colors.lightGreenAccent,
                  ),
                  title: is_my
                      ? const Text(
                          'My Name : ',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : const Text(
                          'Your Name : ',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Text(
                  userName,
                   style: const TextStyle(
                    fontSize: 18,
                     color: Colors.yellowAccent,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
                ),
            
            
             Divider(thickness: 7,),
            ListTile(
              leading: const Icon(
                Icons.email_rounded,
                color: Colors.lightGreenAccent,
              ),
              title: is_my
                  ? const Text(
                      'My Email : ',
                      style: TextStyle(
                       fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const Text(
                      'Your Email : ',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing:  Text(
              email,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.yellowAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            ),
             Divider(thickness: 7,),
            ListTile(
              leading: const Icon(
                Icons.phone,
                color: Colors.lightGreenAccent,
              ),
              title: is_my
                  ? const Text(
                      'My Phone : ',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const Text(
                      'Your Phone : ',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing:  Text(
              phone,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.yellowAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            ),
             Divider(thickness: 7,),
          ],
        ),
      ),
    );
  }
}



 