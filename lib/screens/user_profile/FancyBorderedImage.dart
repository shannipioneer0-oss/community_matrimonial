import 'dart:io';

import 'package:flutter/material.dart';

class FancyBorderedImage extends StatelessWidget {
  final String? imagePath;
  final String? imageUrl;
  final double borderWidth;
  final double borderRadius;
  final String? isverify;
  final VoidCallback? onEditPressed;

  FancyBorderedImage({
    this.imagePath,
    this.imageUrl,
    this.borderWidth = 2.0,
    this.borderRadius = 12.0,
    this.isverify,
    this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 170,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.pink, // Border color
          width: 2,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Stack(
          children: [

            _buildImage(),
            _buildPinkishOverlay(),
            _buildEditButton(),
            Align(alignment: Alignment.topRight   ,child:Container(padding: EdgeInsets.all(5) , width: 35 , height: 30 , color: Colors.pink.withOpacity(0.8)  ,alignment: Alignment.topRight, child:isverify == "0" ?  Icon(Icons.verified_user_outlined , color: Colors.grey,) : isverify == "1" ? Icon(Icons.verified_user ,color: Colors.white,) : Icon(Icons.close_rounded ,color: Colors.white,)),),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (imagePath != null) {
      return Image.file(
        File(imagePath!),
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      );
    } else if (imageUrl != null) {
      return Image.network(
        imageUrl!,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {

          return Align(alignment: Alignment.center  ,child:Image.asset("assets/images/user_image.png"));

        },
      );
    } else {
      // Placeholder or fallback image if both imagePath and imageUrl are null
      return Container();
    }
  }

  Widget _buildPinkishOverlay() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.grey.withOpacity(0.2),
            Colors.grey.withOpacity(0.2),
            Colors.grey.withOpacity(0.2),
            Colors.pink.withOpacity(0.1),
          ],
        ),
      ),
    );
  }

  Widget _buildEditButton() {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.center,
        child: IconButton(
          icon: Icon(Icons.edit, color: Colors.white),
          onPressed: onEditPressed,
        ),
      ),
    );
  }
}