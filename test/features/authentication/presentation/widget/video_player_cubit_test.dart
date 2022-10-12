// import 'package:chewie/chewie.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:mockito/annotations.dart';
// import 'package:bloc_test/bloc_test.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:video_player/video_player.dart';
// import 'package:wmd/core/error_and_success/failures.dart';
// import 'package:wmd/core/presentation/bloc/base_cubit.dart';
// import 'package:wmd/features/authentication/presentation/widgets/video_player_widget/bloc/video_controller_cubit.dart';

// import 'video_player_cubit_test.mocks.dart';

// @GenerateMocks([VideoPlayerController, ChewieController],
//     customMocks: [MockSpec<BuildContext>()])
// // @GenerateNiceMocks([MockBuildContext])

// class MockBuildContext1 extends Mock implements BuildContext {}

// void main() {
//   late VideoControllerCubit videoControllerCubit;
//   // late MockChewieController mockChewieController;
//   // late MockVideoPlayerController mockVideoPlayerController;
//   late MockBuildContext1 mockBuildContext;

//   setUp(() {
//     videoControllerCubit = VideoControllerCubit();
//     // mockVideoPlayerController = MockVideoPlayerController();
//     // mockChewieController = MockChewieController();
//     mockBuildContext = MockBuildContext1();
//   });

//   // final tVideoControllerLoaded = VideoControllerLoaded(
//   //     videoPlayerController: mockVideoPlayerController,
//   //     chewieController: mockChewieController);

//   // const tAppFailure = AppFailure(
//   //     message: "something wrong playing video,\nplease try again later");

//   //TODO Correct the test case
//   // blocTest(
//   //   'when video player is loaded successfully it emits VideoControllerLoaded',
//   //   build: () => videoControllerCubit,
//   //   setUp: () {
//   //     // when(videoControllerCubit.initializePlayer(any))
//   //     //     .thenAnswer((realInvocation) async => tVideoControllerLoaded);
//   //   },
//   //   act: (bloc) async =>
//   //       await videoControllerCubit.initializePlayer(mockBuildContext),
//   //   expect: () => [
//   //     isA<LoadingState>(),
//   //     isA<VideoControllerLoaded>(),
//   //   ],
//   //   verify: (_) {},
//   // );

//   // blocTest(
//   //   'when video player got initialize error it emits ErrorState with AppFailure',
//   //   build: () => videoControllerCubit,
//   //   setUp: () {
//   //     when(videoControllerCubit.initializePlayer(any))
//   //         .thenThrow((realInvocation) async => tAppFailure);
//   //   },
//   //   act: (bloc) async =>
//   //       await videoControllerCubit.initializePlayer(mockBuildContext),
//   //   expect: () => [
//   //     isA<LoadingState>(),
//   //     isA<AppFailure>(),
//   //   ],
//   //   verify: (_) {},
//   // );
// }
