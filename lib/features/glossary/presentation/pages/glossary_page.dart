import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/core/presentation/widgets/search_text_field.dart';
import 'package:wmd/features/glossary/domain/entities/get_glossaries_entity.dart';
import 'package:wmd/features/glossary/presentation/manager/glossary_cubit.dart';
import 'package:wmd/injection_container.dart';

class GlossaryPage extends AppStatelessWidget {
  const GlossaryPage({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    const Key noPadding = Key("noPadding");
    return BlocProvider(
      create: (context) => sl<GlossaryCubit>()..getGlossaries(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(title: Text("Glossary")),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Glossary",
                  style: textTheme.titleLarge,
                ),
                Text(
                  "Definition of terms and words found throughout the app",
                  style: textTheme.bodyMedium,
                ),
                SearchTextField(
                    hint: "Search Glossary",
                    function: (val) {
                      context
                          .read<GlossaryCubit>()
                          .searchGlossaries(searchedValue: val ?? "");
                    },
                    delay: 0),
                const SizedBox(),
                BlocConsumer<GlossaryCubit, GlossaryState>(
                  listener: BlocHelper.defaultBlocListener(listener: (context, state) {},),
                  builder: (context, state) {
                    return state is GetGlossariesLoaded ? ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      key: noPadding,
                      shrinkWrap: true,
                      children: List.generate(
                          state.getGlossariesEntities.length, (index) {
                        GetGlossariesEntity getGlossaryEntity =
                            state.getGlossariesEntities[index];
                        return getGlossaryEntity.record.isEmpty
                            ? const SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Container(
                                      width: double.maxFinite,
                                      color: Theme.of(context).cardColor,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        child: Text(
                                          getGlossaryEntity.alphabet,
                                          style: textTheme.titleMedium!.apply(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ),
                                    ),
                                    ListView.separated(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:
                                          getGlossaryEntity.record.length,
                                      separatorBuilder: (context, index) =>
                                          const Divider(thickness: 1),
                                      itemBuilder: (context, index) {
                                        RecordEntity record =
                                            getGlossaryEntity.record[index];
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                              dividerColor: Colors.transparent),
                                          child: ExpansionTile(
                                            expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                            title: Text(
                                              record.term,
                                              style: textTheme.titleMedium,
                                            ),
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional.centerStart,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          vertical: 8.0,
                                                          horizontal: 16),
                                                  child: Text(record.definition),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                  ]);
                      }),
                    ) : const LoadingWidget();
                  },
                )
              ]
                  .map((e) => e.key == noPadding
                      ? e
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: e,
                        ))
                  .toList(),
            ),
          ),
        );
      }),
    );
  }
}