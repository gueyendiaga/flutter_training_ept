import 'package:flutter/material.dart';
import 'package:flutter_training/core/constants/app_sizes.dart';
import 'package:flutter_training/core/datasource/chatlist.dart';

import '../../home/widgets/custom_search_bar.dart';
import '../widgets/chat_item_widget.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSizes.md),
      child: Column(
        spacing: AppSizes.md,
        children: [
          // Section 1: Search bar
          CustomSearchBar(),
          // Section 2: Chat list
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (BuildContext context, int index) {
                // final chat = chats[index];
                final chat = chats.elementAt(index);
                return ChatItemWidget(chat: chat);
              }
            ),
          )
        ],
      ),
    );
  }
}
