import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class PaginationCubit extends Cubit<bool> {
  final int? initPage;
  final ScrollController scrollController;
  final Function(int) function;

  PaginationCubit(this.scrollController, this.function,
      {this.initPage})
      : super(false);

  bool hasMore = true;
  late int page;
  bool loading = false;

  initPagination() {
    page = initPage??1;
    scrollController.addListener(() async {
      if (!loading && hasMore) {
        double maxScroll = scrollController.position.maxScrollExtent;
        double currentScroll = scrollController.position.pixels;
        double delta = 0.0; // or something else..
        if (maxScroll - currentScroll <= delta) {
          loading = true;
          emit(loading);
          page++; // whatever you determine here
          try {
            await function(page);
          } catch (e) {
            page--;
          }
          loading = false;
          emit(loading);
        }
      }
    });
  }
}
