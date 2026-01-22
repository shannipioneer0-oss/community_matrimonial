import 'package:flutter/material.dart';

class ImageOverlayPainter extends CustomPainter {
  final ImageProvider backgroundImage;
  final ImageProvider overlayImage;

  ImageOverlayPainter({required this.backgroundImage, required this.overlayImage});

  @override
  void paint(Canvas canvas, Size size) {
    // Draw the background image
    Paint backgroundPaint = Paint();
    backgroundPaint.color = Colors.transparent; // Set the background color if needed
    canvas.drawRect(Rect.fromPoints(Offset.zero, Offset(size.width, size.height)), backgroundPaint);

    // Draw the overlay image only in the colored portion
    Paint maskPaint = Paint();
    maskPaint.blendMode = BlendMode.srcIn;

    Paint imagePaint = Paint();

    // Draw the background image
    backgroundImage.resolve(ImageConfiguration()).addListener(
      ImageStreamListener((info, _) {
        Rect imageRect = Rect.fromPoints(Offset.zero, Offset(size.width, size.height));
        canvas.drawImageRect(info.image, imageRect, imageRect, imagePaint);

        // Draw the overlay image
        overlayImage.resolve(ImageConfiguration()).addListener(
          ImageStreamListener((overlayInfo, __) {
            Rect overlayRect = Rect.fromPoints(Offset.zero, Offset(size.width, size.height));
            canvas.drawImageRect(overlayInfo.image, overlayRect, overlayRect, maskPaint);
          }),
        );
      }),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}