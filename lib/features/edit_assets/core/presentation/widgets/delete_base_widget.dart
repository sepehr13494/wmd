import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteAssetBaseWidget extends AppStatelessWidget {
  final String name;
  final Function() onTap;
  const DeleteAssetBaseWidget({Key? key, required this.name, required this.onTap}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Padding(
      padding: const EdgeInsets.only(left: 16,right:16,top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Edit $name details",style: textTheme.titleLarge,),
          const SizedBox(height: 12),
          Text("Remove the asset altogether?",style: textTheme.bodyMedium,),
          InkWell(
            onTap: onTap,
            child: Text("Delete asset",style: textTheme.bodyMedium!.toLinkStyle(context),),
          ),
        ],
      ),
    );
  }
}
