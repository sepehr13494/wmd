import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class OverlayModal extends ModalRoute<void> {
  late Widget childComponent;
  late ChewieController? chewieController;
  late VideoPlayerController? videoPlayerController;
  OverlayModal({
    required this.childComponent,
    required this.chewieController,
    required this.videoPlayerController,
  });

  @override
  Duration get transitionDuration => const Duration(milliseconds: 100);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => '';

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  @override
  void dispose() {
    if (chewieController != null) {
      chewieController!.pause();
    }
    super.dispose();
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1.7,
        child: Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[
            childComponent,
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
