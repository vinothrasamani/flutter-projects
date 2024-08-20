import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble.first({
    super.key,
    required this.message,
    required this.isCurrentUser,
    required this.profileImage,
    required this.username,
  }) : isFirstInSequense = true;

  const ChatBubble.next({
    super.key,
    required this.message,
    required this.isCurrentUser,
  })  : isFirstInSequense = false,
        username = null,
        profileImage = null;

  final bool isFirstInSequense;
  final String? profileImage;
  final String? username;
  final String message;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        if (profileImage != null)
          Positioned(
            top: 15,
            right: isCurrentUser ? 0 : null,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                profileImage!,
              ),
              backgroundColor: theme.appBarTheme.backgroundColor,
              radius: 23,
            ),
          ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 45,
          ),
          child: Row(
            mainAxisAlignment:
                isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: isCurrentUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  if (isFirstInSequense)
                    const SizedBox(
                      height: 18,
                    ),
                  if (username != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 13, right: 13),
                      child: Text(
                        username!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isCurrentUser
                              ? const Color.fromARGB(255, 255, 213, 0)
                              : const Color.fromARGB(255, 157, 255, 0),
                        ),
                      ),
                    ),
                  Container(
                    decoration: BoxDecoration(
                      color: isCurrentUser
                          ? const Color.fromARGB(255, 88, 0, 136)
                          : const Color.fromARGB(255, 146, 0, 80),
                      borderRadius: BorderRadius.only(
                        topLeft: !isCurrentUser && isFirstInSequense
                            ? Radius.zero
                            : const Radius.circular(12),
                        topRight: isCurrentUser && isFirstInSequense
                            ? Radius.zero
                            : const Radius.circular(12),
                        bottomLeft: const Radius.circular(12),
                        bottomRight: const Radius.circular(12),
                      ),
                    ),
                    constraints: const BoxConstraints(maxWidth: 230),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 14,
                    ),
                    margin: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 12,
                    ),
                    child: Text(
                      message,
                      style: const TextStyle(
                        height: 1.3,
                        color: Colors.white,
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
