import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

class CustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarWidget({super.key});



  _onSelectedMenuItem(String value) {
    switch (value) {
      case 'new_group':
        // TODO: Implémenter la logique pour créer un nouveau groupe
        print('Nouveau groupe');
        break;
      case 'list_diffusion':
        print('Liste de diffusion');
        break;
      case 'connected_devices':
        print('Appareils connectés');
        break;
      case 'important':
        print('Important');
        break;
      case 'read_all':
        print('Tout lire');
        break;
      case 'settings':
        print('Paramètres');
        break;
      case 'change_account':
        print('Changer de compte');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          'WhatsApp',
          style: TextStyle(
            fontSize: AppSizes.fontSizeXXl,
            fontWeight: FontWeight.bold,
            color: AppColors.primary
          )
        ),
        actions: [
          Icon(Icons.camera_alt_outlined, size: AppSizes.iconMd, color: Colors.black),
          PopupMenuButton(
            onSelected: _onSelectedMenuItem,
            color: Colors.white,
            icon: Icon(Icons.more_vert, size: AppSizes.iconMd, color: Colors.black),
            itemBuilder: (context)=> [
              PopupMenuItem<String>(
                value: 'new_group',
                child: Text('Nouveau groupe'),
              ),
              PopupMenuItem<String>(
                value: 'list_diffusion',
                child: Text('Liste de diffusion'),
              ),
              PopupMenuItem<String>(
                value: 'connected_devices',
                child: Text('Appareils connectés'),
              ),
              PopupMenuItem<String>(
                value: 'important',
                child: Text('Important'),
              ),
              PopupMenuItem<String>(
                value: 'read_all',
                child: Text('Tout lire'),
              ),
              PopupMenuItem<String>(
                value: 'settings',
                child: Text('Paramètres'),
              ),
              PopupMenuItem<String>(
                value: 'change_account',
                child: Text('Changer de compte'),
              )
            ],
          )
        ],
      );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(AppSizes.appBarHeight);
}