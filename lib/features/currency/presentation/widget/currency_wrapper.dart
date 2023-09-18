// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
// import 'package:wmd/features/currency/domain/entities/get_currency_entity.dart';
// import 'package:wmd/features/currency/presentation/manager/currency_cubit.dart';
// import '../../../../core/presentation/bloc/bloc_helpers.dart';

// class CurrencyWrapper extends AppStatelessWidget {
//   final Widget child;
//   const CurrencyWrapper({super.key, required this.child});

//   @override
//   Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
//     return BlocConsumer<CurrencyCubit, CurrencyState>(
//       listener: BlocHelper.defaultBlocListener(listener: (context, state) {}),
//       builder: (context, state) {
//         GetCurrencyConversionEntity? entity;

//         if (state is GetCurrencyConversionLoaded) {
//           entity = state.getCurrencyEntity;
//         }

//         return CurrencyInherited(
//           entity: entity,
//           child: child,
//         );
//       },
//     );
//   }
// }

// class CurrencyInherited extends InheritedWidget {
//   const CurrencyInherited({
//     super.key,
//     required this.entity,
//     required super.child,
//   });

//   final GetCurrencyConversionEntity? entity;

//   static CurrencyInherited of(BuildContext context) {
//     final CurrencyInherited? result =
//         context.dependOnInheritedWidgetOfExactType<CurrencyInherited>();
//     assert(result != null, 'No PrivacyInherited found in context');
//     return result!;
//   }

//   @override
//   bool updateShouldNotify(CurrencyInherited oldWidget) {
//     return entity != null && (entity != oldWidget.entity);
//   }
// }
