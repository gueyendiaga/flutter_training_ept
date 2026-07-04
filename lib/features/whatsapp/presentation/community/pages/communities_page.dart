import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_training/core/constants/app_sizes.dart';
import 'package:flutter_training/core/widgets/app_button.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/constants/images_assets.dart';

class CommunitiesPage extends StatefulWidget {
  const CommunitiesPage({super.key});

  @override
  State<CommunitiesPage> createState() => _CommunitiesPageState();
}

class _CommunitiesPageState extends State<CommunitiesPage> {

  Uint8List? selectedImage;

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    // Pick an image.
    final XFile? image = await picker.pickImage(source: source);
    final Uint8List? imageBytes = await image?.readAsBytes();
    setState(() {
      selectedImage = imageBytes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          Text('Communities Page'),
          SizedBox(height: AppSizes.md),
          SvgPicture.asset(ImagesAssets.homeIcon, width: AppSizes.lg, height: AppSizes.lg),
          AppButton(
            label: 'Pick an image from gallery',
            onPressed: ()=> pickImage(ImageSource.gallery),
          ),
          SizedBox(height: AppSizes.md),
          AppButton(
            label: 'Pick an image from camera',
            onPressed: ()=> pickImage(ImageSource.camera),
          ),
          if(selectedImage != null) ...[
            Image.memory(selectedImage!)
          ]
        ],
      ),
    );
  }
}
