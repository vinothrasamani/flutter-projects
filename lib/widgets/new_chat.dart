import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewChat extends StatefulWidget {
  const NewChat({super.key});

  @override
  State<NewChat> createState() {
    return _NewChatState();
  }
}

class _NewChatState extends State<NewChat> {
  final _messageController = TextEditingController();

  void _sendMessage() async {
    final enteredMsg = _messageController.text;
    if (enteredMsg.trim().isEmpty) {
      debugPrint('failed');
      return;
    }
    FocusScope.of(context).unfocus();
    _messageController.clear();

    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    FirebaseFirestore.instance.collection('chat').add({
      'message': enteredMsg,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData.data()!['username'],
      'profileImage': userData.data()!['imgeurl'],
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide:
          BorderSide(color: Theme.of(context).appBarTheme.backgroundColor!),
      borderRadius: BorderRadius.circular(30),
    );

    return Padding(
      padding: const EdgeInsets.only(
        top: 0,
        left: 8,
        right: 5,
        bottom: 15,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              controller: _messageController,
              style: const TextStyle(color: Colors.white),
              enableSuggestions: true,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                hintText: "Enter your message...",
                hintStyle: const TextStyle(color: Colors.white60),
                enabledBorder: border,
                focusedBorder: border,
                errorBorder: border,
                focusedErrorBorder: border,
              ),
            ),
          ),
          const SizedBox(
            width: 6,
          ),
          IconButton.filledTonal(
            padding: const EdgeInsets.all(15),
            onPressed: _sendMessage,
            icon: Icon(
              Icons.send_sharp,
              color: Theme.of(context).appBarTheme.backgroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
