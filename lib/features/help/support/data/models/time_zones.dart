import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

class TimeZones {
  final String name;
  final String offset;
  final String value;

  TimeZones({required this.name, required this.offset, required this.value});

  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() => {
        "value": value,
        "offset": offset,
        "name": name,
      };

  factory TimeZones.fromJson(Map<String, dynamic> json) => TimeZones(
        value: json["value"],
        offset: json["offset"],
        name: json["value"] + " " + json["offset"],
      );

  // // static final timezonesList = json.map((e) => TimeZones.fromJson(e)).toList();
  // static getTimezonesListLocalized(AppLocalizations appLocalizations) =>
  //     _getOffsetByLocale(appLocalizations)
  //         .entries
  //         .map((e) => TimeZones(
  //             name: "${e.key} ${e.value}", offset: e.value, value: e.value))
  //         .toList();

  static TimeZones? getTimezoneByDevice(AppLocalizations appLocalizations) {
    final list = DateTime.now().timeZoneOffset.toString().split(':');
    final minutes = DateTime.now().timeZoneOffset.inMinutes;
    String s = minutes >= 0 ? '+' : '-';
    int h = minutes.toDouble() ~/ 60;
    String hS = h < 10 ? '0$h' : 'h';
    int m = minutes - h * 60;
    final zone = "GMT$s$hS:${list[1]}";

    final results =
        getTimeZones(appLocalizations).where((e) => e.name.contains(zone));
    // .where((e) => e.value.contains(DateTime.now().timeZoneName));
    if (results.isNotEmpty) {
      final e = results.first;
      return e;
    } else {
      return null;
    }
  }

  static List<TimeZones> getTimeZones(AppLocalizations appLocalizations) {
    final lnEn = AppLocalizationsEn();
    return [
      TimeZones(
          name:
              "${appLocalizations.timeZones_Afghanistan_Standard_Time} GMT+04:30",
          offset: "GMT+04:30",
          value: lnEn.timeZones_Afghanistan_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Alaskan_Standard_Time} GMT-09:00",
          offset: "GMT-09:00",
          value: lnEn.timeZones_Alaskan_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Aleutian_Standard_Time} GMT-10:00",
          offset: "GMT-10:00",
          value: lnEn.timeZones_Aleutian_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Altai_Standard_Time} GMT+07:00",
          offset: "GMT+07:00",
          value: lnEn.timeZones_Altai_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Arab_Standard_Time} GMT+03:00",
          offset: "GMT+03:00",
          value: lnEn.timeZones_Arab_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Argentina_Standard_Time} GMT-03:00",
          offset: "GMT-03:00",
          value: lnEn.timeZones_Argentina_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Astrakhan_Standard_Time} GMT+04:00",
          offset: "GMT+04:00",
          value: lnEn.timeZones_Astrakhan_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Atlantic_Standard_Time} GMT-04:00",
          offset: "GMT-04:00",
          value: lnEn.timeZones_Atlantic_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_AUS_Central_Standard_Time} GMT+09:30",
          offset: "GMT+09:30",
          value: lnEn.timeZones_AUS_Central_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Aus_Central_W_Standard_Time} GMT+08:45",
          offset: "GMT+08:45",
          value: lnEn.timeZones_Aus_Central_W_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_AUS_Eastern_Standard_Time} GMT+10:00",
          offset: "GMT+10:00",
          value: lnEn.timeZones_AUS_Eastern_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_AUS_Eastern_Standard_Time} GMT-05:00",
          offset: "GMT-05:00",
          value: lnEn.timeZones_AUS_Eastern_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_AUS_Eastern_Standard_Time} GMT-05:00",
          offset: "GMT-05:00",
          value: lnEn.timeZones_AUS_Eastern_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Azerbaijan_Standard_Time} GMT+04:00",
          offset: "GMT+04:00",
          value: lnEn.timeZones_Azerbaijan_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Azores_Standard_Time} GMT-01:00",
          offset: "GMT-01:00",
          value: lnEn.timeZones_Azores_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Bahia_Standard_Time} GMT-03:00",
          offset: "GMT-03:00",
          value: lnEn.timeZones_Bahia_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Bangladesh_Standard_Time} GMT+06:00",
          offset: "GMT+06:00",
          value: lnEn.timeZones_Bangladesh_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Belarus_Standard_Time} GMT+03:00",
          offset: "GMT+03:00",
          value: lnEn.timeZones_Belarus_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Bougainville_Standard_Time} GMT+11:00",
          offset: "GMT+11:00",
          value: lnEn.timeZones_Bougainville_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Canada_Central_Standard_Time} GMT-06:00",
          offset: "GMT-06:00",
          value: lnEn.timeZones_Canada_Central_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Cape_Verde_Standard_Time} GMT-01:00",
          offset: "GMT-01:00",
          value: lnEn.timeZones_Cape_Verde_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Caucasus_Standard_Time} GMT+04:00",
          offset: "GMT+04:00",
          value: lnEn.timeZones_Caucasus_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Cen_Australia_Standard_Time} GMT+09:30",
          offset: "GMT+09:30",
          value: lnEn.timeZones_Cen_Australia_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Central_America_Standard_Time} GMT-06:00",
          offset: "GMT-06:00",
          value: lnEn.timeZones_Central_America_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Central_Asia_Standard_Time} GMT+06:00",
          offset: "GMT+06:00",
          value: lnEn.timeZones_Central_Asia_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Central_Brazilian_Standard_Time} GMT-04:00",
          offset: "GMT-04:00",
          value: lnEn.timeZones_Central_Brazilian_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Central_Europe_Standard_Time} GMT+01:00",
          offset: "GMT+01:00",
          value: lnEn.timeZones_Central_Europe_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Central_Pacific_Standard_Time} GMT+11:00",
          offset: "GMT+11:00",
          value: lnEn.timeZones_Central_Pacific_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Central_Pacific_Standard_Time} GMT-08:00",
          offset: "GMT-08:00",
          value: lnEn.timeZones_Central_Pacific_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Chatham_Islands_Standard_Time} GMT+12:45",
          offset: "GMT+12:45",
          value: lnEn.timeZones_Chatham_Islands_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_China_Standard_Time} GMT+08:00",
          offset: "GMT+08:00",
          value: lnEn.timeZones_China_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Cuba_Standard_Time} GMT-05:00",
          offset: "GMT-05:00",
          value: lnEn.timeZones_Cuba_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Dateline_Standard_Time} GMT-12:00",
          offset: "GMT-12:00",
          value: lnEn.timeZones_Dateline_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_E_Africa_Standard_Time} GMT+03:00",
          offset: "GMT+03:00",
          value: lnEn.timeZones_E_Africa_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_E_Australia_Standard_Time} GMT+10:00",
          offset: "GMT+10:00",
          value: lnEn.timeZones_E_Australia_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_E_Europe_Standard_Time} GMT+02:00",
          offset: "GMT+02:00",
          value: lnEn.timeZones_E_Europe_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_E_South_America_Standard_Time} GMT-03:00",
          offset: "GMT-03:00",
          value: lnEn.timeZones_E_South_America_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Easter_Island_Standard_Time} GMT-06:00",
          offset: "GMT-06:00",
          value: lnEn.timeZones_Easter_Island_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Eastern_Standard_Time_Mexico} GMT-05:00",
          offset: "GMT-05:00",
          value: lnEn.timeZones_Eastern_Standard_Time_Mexico),
      TimeZones(
          name: "${appLocalizations.timeZones_Eastern_Standard_Time} GMT-05:00",
          offset: "GMT-05:00",
          value: lnEn.timeZones_Eastern_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Egypt_Standard_Time} GMT+02:00",
          offset: "GMT+02:00",
          value: lnEn.timeZones_Egypt_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Ekaterinburg_Standard_Time} GMT+05:00",
          offset: "GMT+05:00",
          value: lnEn.timeZones_Ekaterinburg_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Fiji_Standard_Time} GMT+12:00",
          offset: "GMT+12:00",
          value: lnEn.timeZones_Fiji_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_FLE_Standard_Time} GMT+02:00",
          offset: "GMT+02:00",
          value: lnEn.timeZones_FLE_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Georgian_Standard_Time} GMT+04:00",
          offset: "GMT+04:00",
          value: lnEn.timeZones_Georgian_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_GMT_Standard_Time} GMT+00:00",
          offset: "GMT+00:00",
          value: lnEn.timeZones_GMT_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Greenland_Standard_Time} GMT-03:00",
          offset: "GMT-03:00",
          value: lnEn.timeZones_Greenland_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_GTB_Standard_Time} GMT+02:00",
          offset: "GMT+02:00",
          value: lnEn.timeZones_GTB_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Haiti_Standard_Time} GMT-05:00",
          offset: "GMT-05:00",
          value: lnEn.timeZones_Haiti_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Hawaiian_Standard_Time} GMT-10:00",
          offset: "GMT-10:00",
          value: lnEn.timeZones_Hawaiian_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_India_Standard_Time} GMT+05:30",
          offset: "GMT+05:30",
          value: lnEn.timeZones_India_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Iran_Standard_Time} GMT+03:30",
          offset: "GMT+03:30",
          value: lnEn.timeZones_Iran_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Israel_Standard_Time} GMT+02:00",
          offset: "GMT+02:00",
          value: lnEn.timeZones_Israel_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Jordan_Standard_Time} GMT+02:00",
          offset: "GMT+02:00",
          value: lnEn.timeZones_Jordan_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Kaliningrad_Standard_Time} GMT+02:00",
          offset: "GMT+02:00",
          value: lnEn.timeZones_Kaliningrad_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Kamchatka_Standard_Time} GMT+12:00",
          offset: "GMT+12:00",
          value: lnEn.timeZones_Kamchatka_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Korea_Standard_Time} GMT+09:00",
          offset: "GMT+09:00",
          value: lnEn.timeZones_Korea_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Libya_Standard_Time} GMT+02:00",
          offset: "GMT+02:00",
          value: lnEn.timeZones_Libya_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Line_Islands_Standard_Time} GMT+14:00",
          offset: "GMT+14:00",
          value: lnEn.timeZones_Line_Islands_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Lord_Howe_Standard_Time} GMT+10:30",
          offset: "GMT+10:30",
          value: lnEn.timeZones_Lord_Howe_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Magadan_Standard_Time} GMT+11:00",
          offset: "GMT+11:00",
          value: lnEn.timeZones_Magadan_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Magallanes_Standard_Time} GMT-03:00",
          offset: "GMT-03:00",
          value: lnEn.timeZones_Magallanes_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Marquesas_Standard_Time} GMT-09:30",
          offset: "GMT-09:30",
          value: lnEn.timeZones_Marquesas_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Mauritius_Standard_Time} GMT+04:00",
          offset: "GMT+04:00",
          value: lnEn.timeZones_Mauritius_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Mid_Atlantic_Standard_Time} GMT-04:00",
          offset: "GMT-04:00",
          value: lnEn.timeZones_Mid_Atlantic_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Mid_Atlantic_Standard_Time} GMT-02:00",
          offset: "GMT-02:00",
          value: lnEn.timeZones_Mid_Atlantic_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Middle_East_Standard_Time} GMT+02:00",
          offset: "GMT+02:00",
          value: lnEn.timeZones_Middle_East_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Montevideo_Standard_Time} GMT-03:00",
          offset: "GMT-03:00",
          value: lnEn.timeZones_Montevideo_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Morocco_Standard_Time} GMT+00:00",
          offset: "GMT+00:00",
          value: lnEn.timeZones_Morocco_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Mountain_Standard_Time_Mexico} GMT-07:00",
          offset: "GMT-07:00",
          value: lnEn.timeZones_Mountain_Standard_Time_Mexico),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Mountain_Standard_Time} GMT-07:00",
          offset: "GMT-07:00",
          value: lnEn.timeZones_Mountain_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Myanmar_Standard_Time} GMT+06:30",
          offset: "GMT+06:30",
          value: lnEn.timeZones_Myanmar_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_N_Central_Asia_Standard_Time} GMT+06:00",
          offset: "GMT+06:00",
          value: lnEn.timeZones_N_Central_Asia_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_N_Central_Asia_Standard_Time} GMT+07:00",
          offset: "GMT+07:00",
          value: lnEn.timeZones_N_Central_Asia_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Namibia_Standard_Time} GMT+02:00",
          offset: "GMT+02:00",
          value: lnEn.timeZones_Namibia_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Nepal_Standard_Time} GMT+05:45",
          offset: "GMT+05:45",
          value: lnEn.timeZones_Nepal_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_New_Zealand_Standard_Time} GMT+12:00",
          offset: "GMT+12:00",
          value: lnEn.timeZones_New_Zealand_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Newfoundland_Standard_Time} GMT-03:30",
          offset: "GMT-03:30",
          value: lnEn.timeZones_Newfoundland_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Norfolk_Standard_Time} GMT+11:00",
          offset: "GMT+11:00",
          value: lnEn.timeZones_Norfolk_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_North_Asia_East_Standard_Time} GMT+08:00",
          offset: "GMT+08:00",
          value: lnEn.timeZones_North_Asia_East_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_North_Asia_Standard_Time} GMT+07:00",
          offset: "GMT+07:00",
          value: lnEn.timeZones_North_Asia_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_North_Korea_Standard_Time} GMT+09:00",
          offset: "GMT+09:00",
          value: lnEn.timeZones_North_Korea_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_North_Korea_Standard_Time} GMT+09:00",
          offset: "GMT+09:00",
          value: lnEn.timeZones_North_Korea_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Omsk_Standard_Time} GMT+06:00",
          offset: "GMT+06:00",
          value: lnEn.timeZones_Omsk_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Pacific_SA_Standard_Time} GMT-04:00",
          offset: "GMT-04:00",
          value: lnEn.timeZones_Pacific_SA_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Pacific_Standard_Time_Mexico} GMT-08:00",
          offset: "GMT-08:00",
          value: lnEn.timeZones_Pacific_Standard_Time_Mexico),
      TimeZones(
          name: "${appLocalizations.timeZones_Pacific_Standard_Time} GMT-08:00",
          offset: "GMT-08:00",
          value: lnEn.timeZones_Pacific_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Pakistan_Standard_Time} GMT+05:00",
          offset: "GMT+05:00",
          value: lnEn.timeZones_Pakistan_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Paraguay_Standard_Time} GMT-04:00",
          offset: "GMT-04:00",
          value: lnEn.timeZones_Paraguay_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Qyzylorda_Standard_Time} GMT+05:00",
          offset: "GMT+05:00",
          value: lnEn.timeZones_Qyzylorda_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Romance_Standard_Time} GMT+01:00",
          offset: "GMT+01:00",
          value: lnEn.timeZones_Romance_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Russia_Time_Zone_12} GMT+12:00",
          offset: "GMT+12:00",
          value: lnEn.timeZones_Russia_Time_Zone_12),
      TimeZones(
          name: "${appLocalizations.timeZones_Russia_Time_Zone_11} GMT+11:00",
          offset: "GMT+11:00",
          value: lnEn.timeZones_Russia_Time_Zone_11),
      TimeZones(
          name: "${appLocalizations.timeZones_Russia_Time_Zone_4} GMT+04:00",
          offset: "GMT+04:00",
          value: lnEn.timeZones_Russia_Time_Zone_4),
      TimeZones(
          name: "${appLocalizations.timeZones_Russian_Standard_Time} GMT+03:00",
          offset: "GMT+03:00",
          value: lnEn.timeZones_Russian_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_SA_Eastern_Standard_Time} GMT-05:00",
          offset: "GMT-05:00",
          value: lnEn.timeZones_SA_Eastern_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_SA_Eastern_Standard_Time} GMT-03:00",
          offset: "GMT-03:00",
          value: lnEn.timeZones_SA_Eastern_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_SA_Pacific_Standard_Time} GMT-08:00",
          offset: "GMT-08:00",
          value: lnEn.timeZones_SA_Pacific_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_SA_Pacific_Standard_Time} GMT-05:00",
          offset: "GMT-05:00",
          value: lnEn.timeZones_SA_Pacific_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_SA_Western_Standard_Time} GMT-04:00",
          offset: "GMT-04:00",
          value: lnEn.timeZones_SA_Western_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Saint_Pierre_Standard_Time} GMT-03:00",
          offset: "GMT-03:00",
          value: lnEn.timeZones_Saint_Pierre_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Sakhalin_Standard_Time} GMT+11:00",
          offset: "GMT+11:00",
          value: lnEn.timeZones_Sakhalin_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Samoa_Standard_Time} GMT+13:00",
          offset: "GMT+13:00",
          value: lnEn.timeZones_Samoa_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Sao_Tome_Standard_Time} GMT+00:00",
          offset: "GMT+00:00",
          value: lnEn.timeZones_Sao_Tome_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Saratov_Standard_Time} GMT+04:00",
          offset: "GMT+04:00",
          value: lnEn.timeZones_Saratov_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_SE_Asia_Standard_Time} GMT+07:00",
          offset: "GMT+07:00",
          value: lnEn.timeZones_SE_Asia_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Singapore_Standard_Time} GMT+08:00",
          offset: "GMT+08:00",
          value: lnEn.timeZones_Singapore_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_South_Africa_Standard_Time} GMT+02:00",
          offset: "GMT+02:00",
          value: lnEn.timeZones_South_Africa_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_South_Sudan_Standard_Time} GMT+02:00",
          offset: "GMT+02:00",
          value: lnEn.timeZones_South_Sudan_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_South_Sudan_Standard_Time} GMT+02:00",
          offset: "GMT+02:00",
          value: lnEn.timeZones_South_Sudan_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Sri_Lanka_Standard_Time} GMT+05:30",
          offset: "GMT+05:30",
          value: lnEn.timeZones_Sri_Lanka_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Sudan_Standard_Time} GMT+02:00",
          offset: "GMT+02:00",
          value: lnEn.timeZones_Sudan_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Syria_Standard_Time} GMT+02:00",
          offset: "GMT+02:00",
          value: lnEn.timeZones_Syria_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Taipei_Standard_Time} GMT+08:00",
          offset: "GMT+08:00",
          value: lnEn.timeZones_Taipei_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Tasmania_Standard_Time} GMT+10:00",
          offset: "GMT+10:00",
          value: lnEn.timeZones_Tasmania_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Tocantins_Standard_Time} GMT-03:00",
          offset: "GMT-03:00",
          value: lnEn.timeZones_Tocantins_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Tokyo_Standard_Time} GMT+09:00",
          offset: "GMT+09:00",
          value: lnEn.timeZones_Tokyo_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Tomsk_Standard_Time} GMT+07:00",
          offset: "GMT+07:00",
          value: lnEn.timeZones_Tomsk_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Tonga_Standard_Time} GMT+13:00",
          offset: "GMT+13:00",
          value: lnEn.timeZones_Tonga_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Transbaikal_Standard_Time} GMT+09:00",
          offset: "GMT+09:00",
          value: lnEn.timeZones_Transbaikal_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_Turkey_Standard_Time} GMT+03:00",
          offset: "GMT+03:00",
          value: lnEn.timeZones_Turkey_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Turks_And_Caicos_Standard_Time} GMT-05:00",
          offset: "GMT-05:00",
          value: lnEn.timeZones_Turks_And_Caicos_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Ulaanbaatar_Standard_Time} GMT+08:00",
          offset: "GMT+08:00",
          value: lnEn.timeZones_Ulaanbaatar_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_US_Eastern_Standard_Time} GMT-05:00",
          offset: "GMT-05:00",
          value: lnEn.timeZones_US_Eastern_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_US_Eastern_Standard_Time} GMT-05:00",
          offset: "GMT-05:00",
          value: lnEn.timeZones_US_Eastern_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_US_Mountain_Standard_Time} GMT-07:00",
          offset: "GMT-07:00",
          value: lnEn.timeZones_US_Mountain_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_US_Mountain_Standard_Time} GMT-07:00",
          offset: "GMT-07:00",
          value: lnEn.timeZones_US_Mountain_Standard_Time),
      TimeZones(
          name: "${appLocalizations.timeZones_UTC} GMT+00:00",
          offset: "GMT+00:00",
          value: lnEn.timeZones_UTC),
      TimeZones(
          name: "${appLocalizations.timeZones_UTC_plus_12} GMT+00:00",
          offset: "GMT+00:00",
          value: lnEn.timeZones_UTC_plus_12),
      TimeZones(
          name: "${appLocalizations.timeZones_UTC_plus_13} GMT+00:00",
          offset: "GMT+00:00",
          value: lnEn.timeZones_UTC_plus_13),
      TimeZones(
          name: "${appLocalizations.timeZones_UTC_02} GMT+00:00",
          offset: "GMT+00:00",
          value: lnEn.timeZones_UTC_02),
      TimeZones(
          name: "${appLocalizations.timeZones_UTC_02} GMT-02:00",
          offset: "GMT-02:00",
          value: lnEn.timeZones_UTC_02),
      TimeZones(
          name: "${appLocalizations.timeZones_UTC_08} GMT+00:00",
          offset: "GMT+00:00",
          value: lnEn.timeZones_UTC_08),
      TimeZones(
          name: "${appLocalizations.timeZones_UTC_08} GMT-08:00",
          offset: "GMT-08:00",
          value: lnEn.timeZones_UTC_08),
      TimeZones(
          name: "${appLocalizations.timeZones_UTC_09} GMT+00:00",
          offset: "GMT+00:00",
          value: lnEn.timeZones_UTC_09),
      TimeZones(
          name: "${appLocalizations.timeZones_UTC_09} GMT-09:00",
          offset: "GMT-09:00",
          value: lnEn.timeZones_UTC_09),
      TimeZones(
          name: "${appLocalizations.timeZones_UTC_11} GMT+00:00",
          offset: "GMT+00:00",
          value: lnEn.timeZones_UTC_11),
      TimeZones(
          name: "${appLocalizations.timeZones_UTC_11} GMT-11:00",
          offset: "GMT-11:00",
          value: lnEn.timeZones_UTC_11),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Venezuela_Standard_Time} GMT-04:00",
          offset: "GMT-04:00",
          value: lnEn.timeZones_Venezuela_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Vladivostok_Standard_Time} GMT+10:00",
          offset: "GMT+10:00",
          value: lnEn.timeZones_Vladivostok_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_Volgograd_Standard_Time} GMT+03:00",
          offset: "GMT+03:00",
          value: lnEn.timeZones_Volgograd_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_W_Australia_Standard_Time} GMT+08:00",
          offset: "GMT+08:00",
          value: lnEn.timeZones_W_Australia_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_W_Central_Africa_Standard_Time} GMT+01:00",
          offset: "GMT+01:00",
          value: lnEn.timeZones_W_Central_Africa_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_W_Europe_Standard_Time} GMT+01:00",
          offset: "GMT+01:00",
          value: lnEn.timeZones_W_Europe_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_W_Mongolia_Standard_Time} GMT+07:00",
          offset: "GMT+07:00",
          value: lnEn.timeZones_W_Mongolia_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_West_Asia_Standard_Time} GMT+05:00",
          offset: "GMT+05:00",
          value: lnEn.timeZones_West_Asia_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_West_Bank_Standard_Time} GMT+02:00",
          offset: "GMT+02:00",
          value: lnEn.timeZones_West_Bank_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_West_Pacific_Standard_Time} GMT-08:00",
          offset: "GMT-08:00",
          value: lnEn.timeZones_West_Pacific_Standard_Time),
      TimeZones(
          name:
              "${appLocalizations.timeZones_West_Pacific_Standard_Time} GMT+10:00",
          offset: "GMT+10:00",
          value: lnEn.timeZones_West_Pacific_Standard_Time),
    ];
  }
}
