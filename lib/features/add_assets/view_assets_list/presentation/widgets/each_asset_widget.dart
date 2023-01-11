import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/manager/asset_view_cubit.dart';

class EachAssetModel extends AssetViewState {
  final int id;
  final String image;
  final String title;
  final String description;
  final String pageRoute;

  EachAssetModel({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.pageRoute,
  });

  @override
  List<Object?> get props => [id];
}

class EachAssetWidget extends AppStatelessWidget {
  final EachAssetModel eachAssetModel;
  const EachAssetWidget({Key? key, required this.eachAssetModel})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final borderAsset = context.watch<AssetViewCubit>().state;
    return InkWell(
      onTap: () {
        context.read<AssetViewCubit>().selectAsset(eachAssetModel);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: borderAsset != eachAssetModel
                  ? null
                  : Border.all(color: Theme.of(context).primaryColor)),
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: textTheme.bodySmall!.color!.withOpacity(0.2),
                    shape: BoxShape.circle),
                child: SvgPicture.asset(
                  eachAssetModel.image,
                  width: 20,
                  height: 20,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    Text(
                      eachAssetModel.title,
                      style: textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      eachAssetModel.description,
                      style: textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add,
                    color: Theme.of(context).primaryColor,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
