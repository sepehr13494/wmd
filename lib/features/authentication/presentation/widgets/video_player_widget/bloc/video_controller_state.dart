part of 'video_controller_cubit.dart';

abstract class VideoControllerState {}

class VideoControllerLoaded extends Equatable with VideoControllerState {
  final VideoPlayerController videoPlayerController;
  final ChewieController chewieController;

  VideoControllerLoaded({
    required this.videoPlayerController,
    required this.chewieController,
  });

  @override
  List<Object> get props => [videoPlayerController, chewieController];
}
