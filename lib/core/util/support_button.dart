import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';

class SupportButton extends StatelessWidget {
  const SupportButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushNamed(AppRoutes.support),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset("assets/images/add_assets/question.svg"),
      ),
    );
  }
}
