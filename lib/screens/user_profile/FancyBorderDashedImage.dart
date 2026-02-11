


import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';


class FancyBorderDashedImage extends StatelessWidget {
  final String? imagePath;
  final String? imageUrl;
  final double borderRadius;
  final String? isverify;
  final VoidCallback? onEditPressed;

  FancyBorderDashedImage({
    this.imagePath,
    this.imageUrl,
    this.borderRadius = 12.0,
    this.isverify,
    this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.9, // Adjust the width as needed
      height: 170.0, // Adjust the height as needed
      child: Stack(
        children: [
          _buildImage(),
          _buildDashedBorder(),
          _buildEditButton(),
          Align(alignment: Alignment.topRight   ,child:Container(padding: EdgeInsets.all(5) , width: 35 , height: 30 , color: Colors.pink.withOpacity(0.7)  ,alignment: Alignment.topRight, child: isverify == "0" ?  Icon(Icons.verified_user_outlined , color: Colors.grey,) : isverify == "1" ? Icon(Icons.verified_user ,color: Colors.white,) : Icon(Icons.close_rounded ,color: Colors.white,)),),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (imagePath != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.file(
          File(imagePath!),
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fitHeight,
        ),
      );
    } else if (imageUrl != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.network(
          imageUrl!,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fitHeight,
          errorBuilder: (context, error, stackTrace) {

            return Align(alignment: Alignment.center  ,child:Image.asset("assets/images/user_image.png"));

          },
        ),
      );
    } else {
      // Placeholder or fallback image if both imagePath and imageUrl are null
      return Container();
    }
  }

  Widget _buildDashedBorder() {
    return CustomPaint(
      painter: DashedBorderPainter(borderRadius: borderRadius),
    );
  }

  Widget _buildEditButton() {
    return Positioned(
      top: 8.0,
      right: 8.0,
      child: IconButton(
        icon: Icon(Icons.edit, color: Colors.black),
        onPressed: onEditPressed,
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final double borderRadius;

  DashedBorderPainter({required this.borderRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final Path path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromPoints(Offset(0, 0), Offset(size.width, size.height)),
          Radius.circular(borderRadius),
        ),
      );

    const double dashWidth = 5.0;
    const double dashSpace = 5.0;

    canvas.drawPath(
      dashPath(path, dashArray: [dashWidth, dashSpace]),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

Path dashPath(Path source, {required List<double> dashArray}) {
  final Path path = Path();
  for (final PathMetric metric in source.computeMetrics()) {
    double distance = 0.0;
    bool draw = true;
    while (distance < metric.length) {
      final double length = dashArray[draw ? 0 : 1];
      draw ? path.addPath(metric.extractPath(distance, distance + length), Offset.zero) : path.moveTo(distance, 0.0);
      distance += length;
      draw = !draw;
    }
  }
  return path;
}