import 'package:wmd/features/assets_overview/charts/presentation/widgets/base_tree_chart_widget.dart';
import 'package:wmd/features/dashboard/dashboard_charts/domain/entities/get_geographic_entity.dart';

import '../../charts/presentation/widgets/base_tree_chart_widget2.dart';

class GeoTreeChartObj extends TreeChartObj {
  final GetGeographicEntity getGeographicEntity;

  GeoTreeChartObj({
    required this.getGeographicEntity,
  }) : super(
          value: getGeographicEntity.amount,
        );

  @override
  List<Object?> get props => [getGeographicEntity];
}
