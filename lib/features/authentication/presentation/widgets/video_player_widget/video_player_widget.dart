import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/widgets/overlay.dart';
import 'package:wmd/core/util/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/authentication/presentation/widgets/video_player_widget/bloc/video_controller_cubit.dart';

class WelcomeVideoPlayerWidget extends AppStatelessWidget {
  const WelcomeVideoPlayerWidget({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return IconButton(
      onPressed: () {
        Navigator.of(context)
            .push(
          OverlayModal(
            childComponent: BlocProvider(
              create: (context) =>
                  VideoControllerCubit()..initializePlayer(context),
              child: Builder(builder: (context) {
                return BlocBuilder<VideoControllerCubit, VideoControllerState>(
                  builder: (context, state) {
                    return Center(
                      child: state is VideoControllerLoaded
                          ? Chewie(
                              controller: state.chewieController,
                            )
                          : state is ErrorState
                              ? Text(state.failure.message)
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    CircularProgressIndicator(),
                                    SizedBox(height: 20),
                                    Text('Loading'),
                                  ],
                                ),
                    );
                  },
                );
              }),
            ),
          ),
        )
            .then((value) {
          context.read<VideoControllerCubit>().pause();
        });
      },
      icon: const Icon(
        Icons.play_arrow_rounded,
        size: 50,
        color: Colors.white,
      ),
    );
  }
}
