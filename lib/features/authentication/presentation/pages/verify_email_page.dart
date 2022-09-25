import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/util/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/authentication/presentation/widgets/custom_app_bar.dart';

class VerifyEmailPage extends AppStatelessWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Scaffold(
      appBar: CustomAuthAppBar(),
      body: Column(
        children: [
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: textTheme.bodySmall!.color!.withOpacity(0.1),
            ),
            child: Icon(Icons.email,color: Theme.of(context).primaryColor,size: 50,),
          ),
          Text(appLocalizations.sign_up_verify_email_title,style: textTheme.headlineSmall,),
          Text(appLocalizations.sign_up_verify_email_title_description,style: textTheme.bodyMedium!.copyWith(height: 1.3),textAlign: TextAlign.center,),
          const SizedBox(),
          RichText(text: TextSpan(
              style: const TextStyle(height: 1.3),
              children: [
                TextSpan(text: "${appLocalizations.sign_up_didnt_receive_email} ",style: textTheme.bodySmall),
                TextSpan(text: appLocalizations.sign_up_resend,style: textTheme.bodySmall!.toLinkStyle(context)),
              ]
          )),
          const Spacer(),
          const Divider(),
          RichText(text: TextSpan(
              style: const TextStyle(height: 1.3),
              children: [
                TextSpan(text: "${appLocalizations.already_have_account} ",style: textTheme.bodySmall),
                TextSpan(text: appLocalizations.login,style: textTheme.bodySmall!.toLinkStyle(context)),
              ]
          )),
          const SizedBox(height: 24)
        ].map((e) => e is Spacer ? e : Padding(padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 24),child: e,)).toList(),
      ),
    );
  }
}
