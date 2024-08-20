import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:vsd_chat/widgets/chat_bubble.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snap.hasData || snap.data!.docs.isEmpty) {
          return const Center(
            child: Text('No messages found!'),
          );
        }
        if (snap.hasError) {
          return const Center(
            child: Text('Something went wrong!'),
          );
        }
        final loadedMsgs = snap.data!.docs;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: ListView.builder(
            reverse: true,
            padding: const EdgeInsets.only(bottom: 20, right: 5, left: 5),
            itemCount: loadedMsgs.length,
            itemBuilder: (ctx, index) {
              final chatItem = loadedMsgs[index].data();
              final nextChat = index + 1 < loadedMsgs.length
                  ? loadedMsgs[index + 1].data()
                  : null;
              final currentChatUserId = chatItem['userId'];
              final nextChatUserId =
                  nextChat != null ? nextChat['userId'] : null;
              final isNextUserIsSame = currentChatUserId == nextChatUserId;

              if (isNextUserIsSame) {
                return ChatBubble.next(
                  message: chatItem['message'],
                  isCurrentUser: currentUser.uid == currentChatUserId,
                );
              } else {
                return ChatBubble.first(
                  message: chatItem['message'],
                  isCurrentUser: currentUser.uid == currentChatUserId,
                  profileImage: chatItem['profileImage'],
                  username: chatItem['username'],
                );
              }
            },
          ),
        );
      },
    );
  }
}
