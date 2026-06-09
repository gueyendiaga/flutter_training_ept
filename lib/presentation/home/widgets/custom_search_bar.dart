import 'package:flutter/material.dart';
import 'package:flutter_training/core/constants/app_sizes.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: AppSizes.sm),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Demander à META AI ou rechercher',
          prefixIcon: Icon(Icons.search),
          fillColor: Colors.grey[200],
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSizes.radiusXl)),
            borderSide: BorderSide.none
          )
        ),
    
      ),
    );
  }
}