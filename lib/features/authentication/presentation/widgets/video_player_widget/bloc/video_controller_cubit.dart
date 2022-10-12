import 'package:bloc/bloc.dart';
import 'package:chewie/chewie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/util/app_localization.dart';

part 'video_controller_state.dart';

class VideoControllerCubit extends Cubit<VideoControllerState> {
  VideoControllerCubit() : super(LoadingState());

  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  initializePlayer(context) async {
    _videoPlayerController = VideoPlayerController.network(BlocProvider.of<
                    LocalizationManager>(context)
                .state
                .languageCode ==
            "ar"
        ? "https://a.storyblok.com/f/127566/x/fad761400a/tfo_mvp_walk-through_arabic_no_logos_1108.mp4"
        : 'https://a.storyblok.com/f/127566/x/4770bdc9ca/tfo-mvp-walk-through-english-no-logo_1108.mp4');
    await _videoPlayerController.initialize().onError((error, stackTrace) {
      emit(ErrorState(
          failure: const AppFailure(
              message:
                  "something wrong playing video,\nplease try again later")));
      return;
    });
    _createChewieController();
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: false,
      // showControls: false,
      looping: false,
      hideControlsTimer: const Duration(seconds: 1),
      errorBuilder: (context, errorMessage) => const Center(
          child:
              Text("something wrong playing video,\nplease try again later")),
    );
    emit(VideoControllerLoaded(
        videoPlayerController: _videoPlayerController,
        chewieController: _chewieController!));
  }

  @override
  Future<void> close() {
    _chewieController?.dispose();
    _videoPlayerController.dispose();
    return super.close();
  }

  void pause() {
    if (_chewieController != null) {
      _chewieController!.pause();
    }
  }
}
