import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pagination_cubit.dart';
import '../widgets/loading_widget.dart';

class PaginationWidget extends StatelessWidget {
  final Widget child;
  final ScrollController scrollController;
  final Function(int page) function;
  final Axis direction;
  final int initPage;
  final bool hasMore;
  final bool showLoading;
  final int page;

  const PaginationWidget(
      {Key? key,
      required this.child,
      required this.scrollController,
      required this.function,
      this.direction = Axis.vertical,
      this.initPage = 1,
      this.hasMore = true,
      this.showLoading = false,
      required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PaginationCubit(scrollController, function, initPage: initPage)
            ..initPagination(),
      child: Builder(builder: (context) {
        context.read<PaginationCubit>().hasMore = hasMore;
        context.read<PaginationCubit>().page = page;
        return Stack(
          alignment: direction == Axis.vertical
              ? AlignmentDirectional.bottomCenter
              : AlignmentDirectional.centerEnd,
          children: [
            child,
            BlocBuilder<PaginationCubit, bool>(
              builder: (context, state) {
                return (!state || !showLoading)
                    ? Container()
                    : const SizedBox(
                        height: 30,
                        width: 30,
                        child: LoadingWidget(),
                      );
              },
            )
          ],
        );
      }),
    );
  }
}
