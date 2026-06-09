import 'package:flutter/material.dart';
import 'package:flutter_training/core/constants/app_sizes.dart';

import '../widgets/custom_search_bar.dart';

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
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdQ7ARiGBKr0dbLdoCE7SQC4_26-cbpJoQfc1Wpu0Iiw&s=10',
                fit: BoxFit.fill,
              ),
            ),
            title: const Text('Mamadou Falilou',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: AppSizes.fontSizeLg
            )
            ),
            subtitle: const Text('Hello, how are you?'),
            trailing: const Text('06 juin 2026'),
            
            onTap: () {
              Navigator.pop(context);
            },
          )

        ],
      ),
    );
  }
}