part of 'asset_view_cubit.dart';

abstract class AssetViewState extends Equatable {}

class CustodianPage extends AssetViewState {
  @override
  List<Object?> get props => [];
}

class AddTabIndex extends AssetViewState {
  final int tabIndex;

  AddTabIndex({required this.tabIndex});

  @override
  List<Object?> get props => [];
}
