import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/add_asset_header.dart';
import 'package:wmd/features/profile/core/presentation/widgets/contact_information_widget.dart';
import 'package:wmd/features/profile/personal_information/presentation/widgets/personal_imformation_widget.dart';

class ProfilePage extends AppStatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context,TextTheme textTheme, AppLocalizations appLocalizations) {
    final appTheme = Theme.of(context);
    return Scaffold(
       appBar: const AddAssetHeader(
         title: "Settings",
       ),
       body: SingleChildScrollView(
         padding: const EdgeInsets.symmetric(vertical: 32),
         child: Theme(
           data: Theme.of(context).copyWith(
             outlinedButtonTheme: OutlinedButtonThemeData(
               style: appTheme.outlinedButtonTheme.style!.copyWith(
                   minimumSize:
                   MaterialStateProperty.all(const Size(0, 38))),
             ),
           ),
           child: Column(
             children: [
               ContactInformationWidget(),
               const Divider(height: 48),
               PersonalInformationWidget(),
               const Divider(height: 48),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text("Preferred language",style: textTheme.titleMedium),
                   Text("Select your preferred language:",style: textTheme.bodyMedium),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(appLocalizations.localeName,style: textTheme.bodyMedium!.apply(color: textTheme.bodyLarge!.color!),),
                       OutlinedButton(onPressed: (){}, child: Text("Change"))
                     ],
                   ),
                 ].map((e) => Padding(padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),child: e,)).toList(),
               ),
               const Divider(height: 48),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text("Password",style: textTheme.titleMedium),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text("Password",style: textTheme.bodyMedium!.apply(color: textTheme.bodyLarge!.color!),),
                       OutlinedButton(onPressed: (){}, child: Text("Change password"))
                     ],
                   ),
                 ].map((e) => Padding(padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),child: e,)).toList(),
               ),
               const Divider(height: 48),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text("Account",style: textTheme.titleMedium),
                   InkWell(
                     onTap: (){},
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text("Linked account",style: textTheme.bodyMedium!.apply(color: textTheme.bodyLarge!.color!),),
                         Icon(Icons.arrow_forward_ios_rounded,color: appTheme.primaryColor,)
                       ],
                     ),
                   ),
                 ].map((e) => Padding(padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),child: e,)).toList(),
               ),
             ],
           ),
         ),
       )
    );
  }
}
