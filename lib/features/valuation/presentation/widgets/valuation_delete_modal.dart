import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/modal_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/asset_detail/valuation/data/models/get_all_valuation_params.dart';
import 'package:wmd/features/asset_detail/valuation/presentation/manager/valuation_cubit.dart';
import 'package:wmd/features/valuation/presentation/manager/valuation_cubit.dart';
import 'package:wmd/global_functions.dart';
import 'package:wmd/injection_container.dart';

class ValuationDeleteModal extends ModalWidget {
  final String? valuationId;
  final String assetId;
  const ValuationDeleteModal({
    super.key,
    required super.title,
    super.body,
    super.confirmBtn,
    super.cancelBtn,
    required this.valuationId,
    required this.assetId,
  });

  @override
  Widget buildDialogContent(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final responsiveHelper = ResponsiveHelper(context: context);
    final isMobile = responsiveHelper.isMobile;
    final appLocalizations = AppLocalizations.of(context);

    return SingleChildScrollView(
        child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Center(
                child: Column(children: [
              buildModalHeader(context),
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Text(
                      title,
                      style: textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: responsiveHelper.bigger16Gap * 3.5),
                        child: Text(
                          body,
                          style: textTheme.bodyMedium!.copyWith(fontSize: 14),
                          textAlign: TextAlign.center,
                        )),
                    const SizedBox(
                      height: 40,
                    ),
                    buildActionContainer(context),
                  ]))
            ]))));
  }

  ///  Action Buttons Container of Modal
  @override
  Widget buildActionContainer(BuildContext context) {
    return BlocProvider(
        create: (context) => sl<AssetValuationCubit>(),
        child: BlocConsumer<AssetValuationCubit, AssetValuationState>(listener:
            BlocHelper.defaultBlocListener(listener: (context, state) {
          if (state is SuccessState) {
            GlobalFunctions.showSnackBar(context, 'Valuation deleted',
                type: "success");

            context
                .read<ValuationCubit>()
                .getAllValuation(GetAllValuationParams(assetId));
            Navigator.pop(context, true);
          }
        }), builder: (context, state) {
          if (state is DeleteValuationLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context, false),
                  style: OutlinedButton.styleFrom(
                      minimumSize: const Size(100, 50)),
                  child: Text(
                    cancelBtn,
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<AssetValuationCubit>()
                        .deleteValuation(map: {"id": valuationId});
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 50)),
                  child: Text(confirmBtn),
                ),
              ],
            );
          }
        }));
  }
}
