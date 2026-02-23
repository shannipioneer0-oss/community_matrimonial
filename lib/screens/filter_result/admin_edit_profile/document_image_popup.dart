import 'package:flutter/material.dart';

void showFullScreenPopup(BuildContext context , imagepath) {
  Navigator.of(context).push(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => FullScreenPopup(imagepath),
    ),
  );
}

class FullScreenPopup extends StatelessWidget {

   final String imagepath;

  FullScreenPopup(this.imagepath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.9),
      body: SafeArea(
        child: Stack(
          children: [
            // Your main content
        Container(child: InteractiveViewer(
        panEnabled: true,        // allow dragging
          scaleEnabled: true,      // allow pinch zoom
          minScale: 0.5,           // zoom out limit
          maxScale: 4.0,           // zoom in limit
          child: Image.network(imagepath , height: MediaQuery.of(context).size.height*0.8,))),
            // Close Button (Top Right)
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}