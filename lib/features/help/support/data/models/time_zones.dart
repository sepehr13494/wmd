import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  // static final timezonesList = json.map((e) => TimeZones.fromJson(e)).toList();
  static getTimezonesListLocalized(AppLocalizations appLocalizations) =>
      _getOffsetByLocale(appLocalizations)
          .entries
          .map((e) => TimeZones(
              name: "${e.key} ${e.value}", offset: e.value, value: e.key))
          .toList();

  static getTimezoneByDevice(AppLocalizations appLocalizations) {
    final e = _getOffsetByLocale(appLocalizations)
        .entries
        .firstWhere((e) => e.value.contains(DateTime.now().timeZoneName));
    return TimeZones(
        name: "${e.key} ${e.value}", offset: e.value, value: e.key);
  }

  static Map<String, String> _getOffsetByLocale(
      AppLocalizations appLocalizations) {
    return {
      appLocalizations.timeZones_Afghanistan_Standard_Time: "GMT+04:30",
      appLocalizations.timeZones_Alaskan_Standard_Time: "GMT-09:00",
      appLocalizations.timeZones_Aleutian_Standard_Time: "GMT-10:00",
      appLocalizations.timeZones_Altai_Standard_Time: "GMT+07:00",
      appLocalizations.timeZones_Arab_Standard_Time: "GMT+03:00",
      appLocalizations.timeZones_Argentina_Standard_Time: "GMT-03:00",
      appLocalizations.timeZones_Astrakhan_Standard_Time: "GMT+04:00",
      appLocalizations.timeZones_Atlantic_Standard_Time: "GMT-04:00",
      appLocalizations.timeZones_AUS_Central_Standard_Time: "GMT+09:30",
      appLocalizations.timeZones_Aus_Central_W_Standard_Time: "GMT+08:45",
      appLocalizations.timeZones_AUS_Eastern_Standard_Time: "GMT+10:00",
      appLocalizations.timeZones_AUS_Eastern_Standard_Time: "GMT-05:00",
      appLocalizations.timeZones_AUS_Eastern_Standard_Time: "GMT-05:00",
      appLocalizations.timeZones_Azerbaijan_Standard_Time: "GMT+04:00",
      appLocalizations.timeZones_Azores_Standard_Time: "GMT-01:00",
      appLocalizations.timeZones_Bahia_Standard_Time: "GMT-03:00",
      appLocalizations.timeZones_Bangladesh_Standard_Time: "GMT+06:00",
      appLocalizations.timeZones_Belarus_Standard_Time: "GMT+03:00",
      appLocalizations.timeZones_Bougainville_Standard_Time: "GMT+11:00",
      appLocalizations.timeZones_Canada_Central_Standard_Time: "GMT-06:00",
      appLocalizations.timeZones_Cape_Verde_Standard_Time: "GMT-01:00",
      appLocalizations.timeZones_Caucasus_Standard_Time: "GMT+04:00",
      appLocalizations.timeZones_Cen_Australia_Standard_Time: "GMT+09:30",
      appLocalizations.timeZones_Central_America_Standard_Time: "GMT-06:00",
      appLocalizations.timeZones_Central_Asia_Standard_Time: "GMT+06:00",
      appLocalizations.timeZones_Central_Brazilian_Standard_Time: "GMT-04:00",
      appLocalizations.timeZones_Central_Europe_Standard_Time: "GMT+01:00",
      appLocalizations.timeZones_Central_Pacific_Standard_Time: "GMT+11:00",
      appLocalizations.timeZones_Central_Pacific_Standard_Time: "GMT-08:00",
      appLocalizations.timeZones_Chatham_Islands_Standard_Time: "GMT+12:45",
      appLocalizations.timeZones_China_Standard_Time: "GMT+08:00",
      appLocalizations.timeZones_Cuba_Standard_Time: "GMT-05:00",
      appLocalizations.timeZones_Dateline_Standard_Time: "GMT-12:00",
      appLocalizations.timeZones_E_Africa_Standard_Time: "GMT+03:00",
      appLocalizations.timeZones_E_Australia_Standard_Time: "GMT+10:00",
      appLocalizations.timeZones_E_Europe_Standard_Time: "GMT+02:00",
      appLocalizations.timeZones_E_South_America_Standard_Time: "GMT-03:00",
      appLocalizations.timeZones_Easter_Island_Standard_Time: "GMT-06:00",
      appLocalizations.timeZones_Eastern_Standard_Time_Mexico: "GMT-05:00",
      appLocalizations.timeZones_Eastern_Standard_Time: "GMT-05:00",
      appLocalizations.timeZones_Egypt_Standard_Time: "GMT+02:00",
      appLocalizations.timeZones_Ekaterinburg_Standard_Time: "GMT+05:00",
      appLocalizations.timeZones_Fiji_Standard_Time: "GMT+12:00",
      appLocalizations.timeZones_FLE_Standard_Time: "GMT+02:00",
      appLocalizations.timeZones_Georgian_Standard_Time: "GMT+04:00",
      appLocalizations.timeZones_GMT_Standard_Time: "GMT+00:00",
      appLocalizations.timeZones_Greenland_Standard_Time: "GMT-03:00",
      appLocalizations.timeZones_GTB_Standard_Time: "GMT+02:00",
      appLocalizations.timeZones_Haiti_Standard_Time: "GMT-05:00",
      appLocalizations.timeZones_Hawaiian_Standard_Time: "GMT-10:00",
      appLocalizations.timeZones_India_Standard_Time: "GMT+05:30",
      appLocalizations.timeZones_Iran_Standard_Time: "GMT+03:30",
      appLocalizations.timeZones_Israel_Standard_Time: "GMT+02:00",
      appLocalizations.timeZones_Jordan_Standard_Time: "GMT+02:00",
      appLocalizations.timeZones_Kaliningrad_Standard_Time: "GMT+02:00",
      appLocalizations.timeZones_Kamchatka_Standard_Time: "GMT+12:00",
      appLocalizations.timeZones_Korea_Standard_Time: "GMT+09:00",
      appLocalizations.timeZones_Libya_Standard_Time: "GMT+02:00",
      appLocalizations.timeZones_Line_Islands_Standard_Time: "GMT+14:00",
      appLocalizations.timeZones_Lord_Howe_Standard_Time: "GMT+10:30",
      appLocalizations.timeZones_Magadan_Standard_Time: "GMT+11:00",
      appLocalizations.timeZones_Magallanes_Standard_Time: "GMT-03:00",
      appLocalizations.timeZones_Marquesas_Standard_Time: "GMT-09:30",
      appLocalizations.timeZones_Mauritius_Standard_Time: "GMT+04:00",
      appLocalizations.timeZones_Mid_Atlantic_Standard_Time: "GMT-04:00",
      appLocalizations.timeZones_Mid_Atlantic_Standard_Time: "GMT-02:00",
      appLocalizations.timeZones_Middle_East_Standard_Time: "GMT+02:00",
      appLocalizations.timeZones_Montevideo_Standard_Time: "GMT-03:00",
      appLocalizations.timeZones_Morocco_Standard_Time: "GMT+00:00",
      appLocalizations.timeZones_Mountain_Standard_Time_Mexico: "GMT-07:00",
      appLocalizations.timeZones_Mountain_Standard_Time: "GMT-07:00",
      appLocalizations.timeZones_Myanmar_Standard_Time: "GMT+06:30",
      appLocalizations.timeZones_N_Central_Asia_Standard_Time: "GMT+06:00",
      appLocalizations.timeZones_N_Central_Asia_Standard_Time: "GMT+07:00",
      appLocalizations.timeZones_Namibia_Standard_Time: "GMT+02:00",
      appLocalizations.timeZones_Nepal_Standard_Time: "GMT+05:45",
      appLocalizations.timeZones_New_Zealand_Standard_Time: "GMT+12:00",
      appLocalizations.timeZones_Newfoundland_Standard_Time: "GMT-03:30",
      appLocalizations.timeZones_Norfolk_Standard_Time: "GMT+11:00",
      appLocalizations.timeZones_North_Asia_East_Standard_Time: "GMT+08:00",
      appLocalizations.timeZones_North_Asia_Standard_Time: "GMT+07:00",
      appLocalizations.timeZones_North_Korea_Standard_Time: "GMT+09:00",
      appLocalizations.timeZones_North_Korea_Standard_Time: "GMT+09:00",
      appLocalizations.timeZones_Omsk_Standard_Time: "GMT+06:00",
      appLocalizations.timeZones_Pacific_SA_Standard_Time: "GMT-04:00",
      appLocalizations.timeZones_Pacific_Standard_Time_Mexico: "GMT-08:00",
      appLocalizations.timeZones_Pacific_Standard_Time: "GMT-08:00",
      appLocalizations.timeZones_Pakistan_Standard_Time: "GMT+05:00",
      appLocalizations.timeZones_Paraguay_Standard_Time: "GMT-04:00",
      appLocalizations.timeZones_Qyzylorda_Standard_Time: "GMT+05:00",
      appLocalizations.timeZones_Romance_Standard_Time: "GMT+01:00",
      appLocalizations.timeZones_Russia_Time_Zone_12: "GMT+12:00",
      appLocalizations.timeZones_Russia_Time_Zone_11: "GMT+11:00",
      appLocalizations.timeZones_Russia_Time_Zone_4: "GMT+04:00",
      appLocalizations.timeZones_Russian_Standard_Time: "GMT+03:00",
      appLocalizations.timeZones_SA_Eastern_Standard_Time: "GMT-05:00",
      appLocalizations.timeZones_SA_Eastern_Standard_Time: "GMT-03:00",
      appLocalizations.timeZones_SA_Pacific_Standard_Time: "GMT-08:00",
      appLocalizations.timeZones_SA_Pacific_Standard_Time: "GMT-05:00",
      appLocalizations.timeZones_SA_Western_Standard_Time: "GMT-04:00",
      appLocalizations.timeZones_Saint_Pierre_Standard_Time: "GMT-03:00",
      appLocalizations.timeZones_Sakhalin_Standard_Time: "GMT+11:00",
      appLocalizations.timeZones_Samoa_Standard_Time: "GMT+13:00",
      appLocalizations.timeZones_Sao_Tome_Standard_Time: "GMT+00:00",
      appLocalizations.timeZones_Saratov_Standard_Time: "GMT+04:00",
      appLocalizations.timeZones_SE_Asia_Standard_Time: "GMT+07:00",
      appLocalizations.timeZones_Singapore_Standard_Time: "GMT+08:00",
      appLocalizations.timeZones_South_Africa_Standard_Time: "GMT+02:00",
      appLocalizations.timeZones_South_Sudan_Standard_Time: "GMT+02:00",
      appLocalizations.timeZones_South_Sudan_Standard_Time: "GMT+02:00",
      appLocalizations.timeZones_Sri_Lanka_Standard_Time: "GMT+05:30",
      appLocalizations.timeZones_Sudan_Standard_Time: "GMT+02:00",
      appLocalizations.timeZones_Syria_Standard_Time: "GMT+02:00",
      appLocalizations.timeZones_Taipei_Standard_Time: "GMT+08:00",
      appLocalizations.timeZones_Tasmania_Standard_Time: "GMT+10:00",
      appLocalizations.timeZones_Tocantins_Standard_Time: "GMT-03:00",
      appLocalizations.timeZones_Tokyo_Standard_Time: "GMT+09:00",
      appLocalizations.timeZones_Tomsk_Standard_Time: "GMT+07:00",
      appLocalizations.timeZones_Tonga_Standard_Time: "GMT+13:00",
      appLocalizations.timeZones_Transbaikal_Standard_Time: "GMT+09:00",
      appLocalizations.timeZones_Turkey_Standard_Time: "GMT+03:00",
      appLocalizations.timeZones_Turks_And_Caicos_Standard_Time: "GMT-05:00",
      appLocalizations.timeZones_Ulaanbaatar_Standard_Time: "GMT+08:00",
      appLocalizations.timeZones_US_Eastern_Standard_Time: "GMT-05:00",
      appLocalizations.timeZones_US_Eastern_Standard_Time: "GMT-05:00",
      appLocalizations.timeZones_US_Mountain_Standard_Time: "GMT-07:00",
      appLocalizations.timeZones_US_Mountain_Standard_Time: "GMT-07:00",
      appLocalizations.timeZones_UTC: "GMT+00:00",
      appLocalizations.timeZones_UTC_plus_12: "GMT+00:00",
      appLocalizations.timeZones_UTC_plus_13: "GMT+00:00",
      appLocalizations.timeZones_UTC_02: "GMT+00:00",
      appLocalizations.timeZones_UTC_02: "GMT-02:00",
      appLocalizations.timeZones_UTC_08: "GMT+00:00",
      appLocalizations.timeZones_UTC_08: "GMT-08:00",
      appLocalizations.timeZones_UTC_09: "GMT+00:00",
      appLocalizations.timeZones_UTC_09: "GMT-09:00",
      appLocalizations.timeZones_UTC_11: "GMT+00:00",
      appLocalizations.timeZones_UTC_11: "GMT-11:00",
      appLocalizations.timeZones_Venezuela_Standard_Time: "GMT-04:00",
      appLocalizations.timeZones_Vladivostok_Standard_Time: "GMT+10:00",
      appLocalizations.timeZones_Volgograd_Standard_Time: "GMT+03:00",
      appLocalizations.timeZones_W_Australia_Standard_Time: "GMT+08:00",
      appLocalizations.timeZones_W_Central_Africa_Standard_Time: "GMT+01:00",
      appLocalizations.timeZones_W_Europe_Standard_Time: "GMT+01:00",
      appLocalizations.timeZones_W_Mongolia_Standard_Time: "GMT+07:00",
      appLocalizations.timeZones_West_Asia_Standard_Time: "GMT+05:00",
      appLocalizations.timeZones_West_Bank_Standard_Time: "GMT+02:00",
      appLocalizations.timeZones_West_Pacific_Standard_Time: "GMT-08:00",
      appLocalizations.timeZones_West_Pacific_Standard_Time: "GMT+10:00",
    };
  }
}
