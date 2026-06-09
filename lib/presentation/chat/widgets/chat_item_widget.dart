import 'package:flutter/material.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/models/chat_model.dart';

class ChatItemWidget extends StatelessWidget {
  final ChatModel chat;
  final GestureTapCallback? onTap;

  const ChatItemWidget({super.key, required this.chat, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        backgroundImage: NetworkImage(chat.photoUrl),
      ),
      // leading: CircleAvatar(
      //   backgroundColor: Colors.blue,
      //   child: CustomTextWidget(text: chat.name.substring(0, 2).toUpperCase()),
      // ),
      title: Text(chat.name.length > 12 ? '${chat.name.substring(0, 12)}...' : chat.name,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: AppSizes.fontSizeLg
      )
      ),
      subtitle: Text(chat.message),
      trailing: Text(chat.date),
      
      onTap: onTap
    );
  }
}