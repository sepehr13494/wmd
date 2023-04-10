void main() {
  for (int i = 0; i < json.length; i++) {
    final key = ln[i];
    for (var e in json) {
      final name = e['label']!.replaceAll('-', '_');

      if (key.contains(name)) {
        print('appLocalizations.$key : "${e['offset']}",');
      }
    }
  }
}

final json = [
  {
    "label": "Afghanistan-Standard-Time",
    "offset": "GMT+04:30",
    "value": "Afghanistan Standard Time"
  },
  {
    "label": "Alaskan-Standard-Time",
    "offset": "GMT-09:00",
    "value": "Alaskan Standard Time"
  },
  {
    "label": "Aleutian-Standard-Time",
    "offset": "GMT-10:00",
    "value": "Aleutian Standard Time"
  },
  {
    "label": "Altai-Standard-Time",
    "offset": "GMT+07:00",
    "value": "Altai Standard Time"
  },
  {
    "label": "Arab-Standard-Time",
    "offset": "GMT+03:00",
    "value": "Arab Standard Time"
  },
  {
    "label": "Argentina-Standard-Time",
    "offset": "GMT-03:00",
    "value": "Argentina Standard Time"
  },
  {
    "label": "Astrakhan-Standard-Time",
    "offset": "GMT+04:00",
    "value": "Astrakhan Standard Time"
  },
  {
    "label": "Atlantic-Standard-Time",
    "offset": "GMT-04:00",
    "value": "Atlantic Standard Time"
  },
  {
    "label": "AUS-Central-Standard-Time",
    "offset": "GMT+09:30",
    "value": "AUS Central Standard Time"
  },
  {
    "label": "Aus-Central-W-Standard-Time",
    "offset": "GMT+08:45",
    "value": "Aus Central W. Standard Time"
  },
  {
    "label": "AUS-Eastern-Standard-Time",
    "offset": "GMT+10:00",
    "value": "AUS Eastern Standard Time"
  },
  {
    "label": "Azerbaijan-Standard-Time",
    "offset": "GMT+04:00",
    "value": "Azerbaijan Standard Time"
  },
  {
    "label": "Azores-Standard-Time",
    "offset": "GMT-01:00",
    "value": "Azores Standard Time"
  },
  {
    "label": "Bahia-Standard-Time",
    "offset": "GMT-03:00",
    "value": "Bahia Standard Time"
  },
  {
    "label": "Bangladesh-Standard-Time",
    "offset": "GMT+06:00",
    "value": "Bangladesh Standard Time"
  },
  {
    "label": "Belarus-Standard-Time",
    "offset": "GMT+03:00",
    "value": "Belarus Standard Time"
  },
  {
    "label": "Bougainville-Standard-Time",
    "offset": "GMT+11:00",
    "value": "Bougainville Standard Time"
  },
  {
    "label": "Canada-Central-Standard-Time",
    "offset": "GMT-06:00",
    "value": "Canada Central Standard Time"
  },
  {
    "label": "Cape-Verde-Standard-Time",
    "offset": "GMT-01:00",
    "value": "Cape Verde Standard Time"
  },
  {
    "label": "Caucasus-Standard-Time",
    "offset": "GMT+04:00",
    "value": "Caucasus Standard Time"
  },
  {
    "label": "Cen-Australia-Standard-Time",
    "offset": "GMT+09:30",
    "value": "Cen. Australia Standard Time"
  },
  {
    "label": "Central-America-Standard-Time",
    "offset": "GMT-06:00",
    "value": "Central America Standard Time"
  },
  {
    "label": "Central-Asia-Standard-Time",
    "offset": "GMT+06:00",
    "value": "Central Asia Standard Time"
  },
  {
    "label": "Central-Brazilian-Standard-Time",
    "offset": "GMT-04:00",
    "value": "Central Brazilian Standard Time"
  },
  {
    "label": "Central-Europe-Standard-Time",
    "offset": "GMT+01:00",
    "value": "Central Europe Standard Time"
  },
  {
    "label": "Central-Pacific-Standard-Time",
    "offset": "GMT+11:00",
    "value": "Central Pacific Standard Time"
  },
  {
    "label": "Central-Standard-Time-(Mexico)",
    "offset": "GMT-06:00",
    "value": "Central Standard Time (Mexico)"
  },
  {
    "label": "Chatham-Islands-Standard-Time",
    "offset": "GMT+12:45",
    "value": "Chatham Islands Standard Time"
  },
  {
    "label": "China-Standard-Time",
    "offset": "GMT+08:00",
    "value": "China Standard Time"
  },
  {
    "label": "Cuba-Standard-Time",
    "offset": "GMT-05:00",
    "value": "Cuba Standard Time"
  },
  {
    "label": "Dateline-Standard-Time",
    "offset": "GMT-12:00",
    "value": "Dateline Standard Time"
  },
  {
    "label": "E-Africa-Standard-Time",
    "offset": "GMT+03:00",
    "value": "E. Africa Standard Time"
  },
  {
    "label": "E-Australia-Standard-Time",
    "offset": "GMT+10:00",
    "value": "E. Australia Standard Time"
  },
  {
    "label": "E-Europe-Standard-Time",
    "offset": "GMT+02:00",
    "value": "E. Europe Standard Time"
  },
  {
    "label": "E-South-America-Standard-Time",
    "offset": "GMT-03:00",
    "value": "E. South America Standard Time"
  },
  {
    "label": "Easter-Island-Standard-Time",
    "offset": "GMT-06:00",
    "value": "Easter Island Standard Time"
  },
  {
    "label": "Eastern-Standard-Time-(Mexico)",
    "offset": "GMT-05:00",
    "value": "Eastern Standard Time (Mexico)"
  },
  {
    "label": "Eastern-Standard-Time",
    "offset": "GMT-05:00",
    "value": "Eastern Standard Time"
  },
  {
    "label": "Egypt-Standard-Time",
    "offset": "GMT+02:00",
    "value": "Egypt Standard Time"
  },
  {
    "label": "Ekaterinburg-Standard-Time",
    "offset": "GMT+05:00",
    "value": "Ekaterinburg Standard Time"
  },
  {
    "label": "Fiji-Standard-Time",
    "offset": "GMT+12:00",
    "value": "Fiji Standard Time"
  },
  {
    "label": "FLE-Standard-Time",
    "offset": "GMT+02:00",
    "value": "FLE Standard Time"
  },
  {
    "label": "Georgian-Standard-Time",
    "offset": "GMT+04:00",
    "value": "Georgian Standard Time"
  },
  {
    "label": "GMT-Standard-Time",
    "offset": "GMT+00:00",
    "value": "GMT Standard Time"
  },
  {
    "label": "Greenland-Standard-Time",
    "offset": "GMT-03:00",
    "value": "Greenland Standard Time"
  },
  {
    "label": "GTB-Standard-Time",
    "offset": "GMT+02:00",
    "value": "GTB Standard Time"
  },
  {
    "label": "Haiti-Standard-Time",
    "offset": "GMT-05:00",
    "value": "Haiti Standard Time"
  },
  {
    "label": "Hawaiian-Standard-Time",
    "offset": "GMT-10:00",
    "value": "Hawaiian Standard Time"
  },
  {
    "label": "India-Standard-Time",
    "offset": "GMT+05:30",
    "value": "India Standard Time"
  },
  {
    "label": "Iran-Standard-Time",
    "offset": "GMT+03:30",
    "value": "Iran Standard Time"
  },
  {
    "label": "Israel-Standard-Time",
    "offset": "GMT+02:00",
    "value": "Israel Standard Time"
  },
  {
    "label": "Jordan-Standard-Time",
    "offset": "GMT+02:00",
    "value": "Jordan Standard Time"
  },
  {
    "label": "Kaliningrad-Standard-Time",
    "offset": "GMT+02:00",
    "value": "Kaliningrad Standard Time"
  },
  {
    "label": "Kamchatka-Standard-Time",
    "offset": "GMT+12:00",
    "value": "Kamchatka Standard Time"
  },
  {
    "label": "Korea-Standard-Time",
    "offset": "GMT+09:00",
    "value": "Korea Standard Time"
  },
  {
    "label": "Libya-Standard-Time",
    "offset": "GMT+02:00",
    "value": "Libya Standard Time"
  },
  {
    "label": "Line-Islands-Standard-Time",
    "offset": "GMT+14:00",
    "value": "Line Islands Standard Time"
  },
  {
    "label": "Lord-Howe-Standard-Time",
    "offset": "GMT+10:30",
    "value": "Lord Howe Standard Time"
  },
  {
    "label": "Magadan-Standard-Time",
    "offset": "GMT+11:00",
    "value": "Magadan Standard Time"
  },
  {
    "label": "Magallanes-Standard-Time",
    "offset": "GMT-03:00",
    "value": "Magallanes Standard Time"
  },
  {
    "label": "Marquesas-Standard-Time",
    "offset": "GMT-09:30",
    "value": "Marquesas Standard Time"
  },
  {
    "label": "Mauritius-Standard-Time",
    "offset": "GMT+04:00",
    "value": "Mauritius Standard Time"
  },
  {
    "label": "Mid-Atlantic-Standard-Time",
    "offset": "GMT-02:00",
    "value": "Mid-Atlantic Standard Time"
  },
  {
    "label": "Middle-East-Standard-Time",
    "offset": "GMT+02:00",
    "value": "Middle East Standard Time"
  },
  {
    "label": "Montevideo-Standard-Time",
    "offset": "GMT-03:00",
    "value": "Montevideo Standard Time"
  },
  {
    "label": "Morocco-Standard-Time",
    "offset": "GMT+00:00",
    "value": "Morocco Standard Time"
  },
  {
    "label": "Mountain-Standard-Time-(Mexico)",
    "offset": "GMT-07:00",
    "value": "Mountain Standard Time (Mexico)"
  },
  {
    "label": "Mountain-Standard-Time",
    "offset": "GMT-07:00",
    "value": "Mountain Standard Time"
  },
  {
    "label": "Myanmar-Standard-Time",
    "offset": "GMT+06:30",
    "value": "Myanmar Standard Time"
  },
  {
    "label": "N-Central-Asia-Standard-Time",
    "offset": "GMT+07:00",
    "value": "N. Central Asia Standard Time"
  },
  {
    "label": "Namibia-Standard-Time",
    "offset": "GMT+02:00",
    "value": "Namibia Standard Time"
  },
  {
    "label": "Nepal-Standard-Time",
    "offset": "GMT+05:45",
    "value": "Nepal Standard Time"
  },
  {
    "label": "New-Zealand-Standard-Time",
    "offset": "GMT+12:00",
    "value": "New Zealand Standard Time"
  },
  {
    "label": "Newfoundland-Standard-Time",
    "offset": "GMT-03:30",
    "value": "Newfoundland Standard Time"
  },
  {
    "label": "Norfolk-Standard-Time",
    "offset": "GMT+11:00",
    "value": "Norfolk Standard Time"
  },
  {
    "label": "North-Asia-East-Standard-Time",
    "offset": "GMT+08:00",
    "value": "North Asia East Standard Time"
  },
  {
    "label": "North-Asia-Standard-Time",
    "offset": "GMT+07:00",
    "value": "North Asia Standard Time"
  },
  {
    "label": "North-Korea-Standard-Time",
    "offset": "GMT+09:00",
    "value": "North Korea Standard Time"
  },
  {
    "label": "Omsk-Standard-Time",
    "offset": "GMT+06:00",
    "value": "Omsk Standard Time"
  },
  {
    "label": "Pacific-SA-Standard-Time",
    "offset": "GMT-04:00",
    "value": "Pacific SA Standard Time"
  },
  {
    "label": "Pacific-Standard-Time-(Mexico)",
    "offset": "GMT-08:00",
    "value": "Pacific Standard Time (Mexico)"
  },
  {
    "label": "Pacific-Standard-Time",
    "offset": "GMT-08:00",
    "value": "Pacific Standard Time"
  },
  {
    "label": "Pakistan-Standard-Time",
    "offset": "GMT+05:00",
    "value": "Pakistan Standard Time"
  },
  {
    "label": "Paraguay-Standard-Time",
    "offset": "GMT-04:00",
    "value": "Paraguay Standard Time"
  },
  {
    "label": "Qyzylorda-Standard-Time",
    "offset": "GMT+05:00",
    "value": "Qyzylorda Standard Time"
  },
  {
    "label": "Romance-Standard-Time",
    "offset": "GMT+01:00",
    "value": "Romance Standard Time"
  },
  {
    "label": "Russia-Time-Zone-11",
    "offset": "GMT+11:00",
    "value": "Russia Time Zone 11"
  },
  {
    "label": "Russia-Time-Zone-12",
    "offset": "GMT+12:00",
    "value": "Russia Time Zone 12"
  },
  {
    "label": "Russia-Time-Zone-4",
    "offset": "GMT+04:00",
    "value": "Russia Time Zone 4"
  },
  {
    "label": "Russian-Standard-Time",
    "offset": "GMT+03:00",
    "value": "Russian Standard Time"
  },
  {
    "label": "SA-Eastern-Standard-Time",
    "offset": "GMT-03:00",
    "value": "SA Eastern Standard Time"
  },
  {
    "label": "SA-Pacific-Standard-Time",
    "offset": "GMT-05:00",
    "value": "SA Pacific Standard Time"
  },
  {
    "label": "SA-Western-Standard-Time",
    "offset": "GMT-04:00",
    "value": "SA Western Standard Time"
  },
  {
    "label": "Saint-Pierre-Standard-Time",
    "offset": "GMT-03:00",
    "value": "Saint Pierre Standard Time"
  },
  {
    "label": "Sakhalin-Standard-Time",
    "offset": "GMT+11:00",
    "value": "Sakhalin Standard Time"
  },
  {
    "label": "Samoa-Standard-Time",
    "offset": "GMT+13:00",
    "value": "Samoa Standard Time"
  },
  {
    "label": "Sao-Tome-Standard-Time",
    "offset": "GMT+00:00",
    "value": "Sao Tome Standard Time"
  },
  {
    "label": "Saratov-Standard-Time",
    "offset": "GMT+04:00",
    "value": "Saratov Standard Time"
  },
  {
    "label": "SE-Asia-Standard-Time",
    "offset": "GMT+07:00",
    "value": "SE Asia Standard Time"
  },
  {
    "label": "Singapore-Standard-Time",
    "offset": "GMT+08:00",
    "value": "Singapore Standard Time"
  },
  {
    "label": "South-Africa-Standard-Time",
    "offset": "GMT+02:00",
    "value": "South Africa Standard Time"
  },
  {
    "label": "South-Sudan-Standard-Time",
    "offset": "GMT+02:00",
    "value": "South Sudan Standard Time"
  },
  {
    "label": "Sri-Lanka-Standard-Time",
    "offset": "GMT+05:30",
    "value": "Sri Lanka Standard Time"
  },
  {
    "label": "Sudan-Standard-Time",
    "offset": "GMT+02:00",
    "value": "Sudan Standard Time"
  },
  {
    "label": "Syria-Standard-Time",
    "offset": "GMT+02:00",
    "value": "Syria Standard Time"
  },
  {
    "label": "Taipei-Standard-Time",
    "offset": "GMT+08:00",
    "value": "Taipei Standard Time"
  },
  {
    "label": "Tasmania-Standard-Time",
    "offset": "GMT+10:00",
    "value": "Tasmania Standard Time"
  },
  {
    "label": "Tocantins-Standard-Time",
    "offset": "GMT-03:00",
    "value": "Tocantins Standard Time"
  },
  {
    "label": "Tokyo-Standard-Time",
    "offset": "GMT+09:00",
    "value": "Tokyo Standard Time"
  },
  {
    "label": "Tomsk-Standard-Time",
    "offset": "GMT+07:00",
    "value": "Tomsk Standard Time"
  },
  {
    "label": "Tonga-Standard-Time",
    "offset": "GMT+13:00",
    "value": "Tonga Standard Time"
  },
  {
    "label": "Transbaikal-Standard-Time",
    "offset": "GMT+09:00",
    "value": "Transbaikal Standard Time"
  },
  {
    "label": "Turkey-Standard-Time",
    "offset": "GMT+03:00",
    "value": "Turkey Standard Time"
  },
  {
    "label": "Turks-And-Caicos-Standard-Time",
    "offset": "GMT-05:00",
    "value": "Turks And Caicos Standard Time"
  },
  {
    "label": "Ulaanbaatar-Standard-Time",
    "offset": "GMT+08:00",
    "value": "Ulaanbaatar Standard Time"
  },
  {
    "label": "US-Eastern-Standard-Time",
    "offset": "GMT-05:00",
    "value": "US Eastern Standard Time"
  },
  {
    "label": "US-Mountain-Standard-Time",
    "offset": "GMT-07:00",
    "value": "US Mountain Standard Time"
  },
  {"label": "UTC", "offset": "GMT+00:00", "value": "UTC"},
  {"label": "UTC-02", "offset": "GMT-02:00", "value": "UTC-02"},
  {"label": "UTC-08", "offset": "GMT-08:00", "value": "UTC-08"},
  {"label": "UTC-09", "offset": "GMT-09:00", "value": "UTC-09"},
  {"label": "UTC-11", "offset": "GMT-11:00", "value": "UTC-11"},
  {"label": "UTC+12", "offset": "GMT+12:00", "value": "UTC+12"},
  {"label": "UTC+13", "offset": "GMT+13:00", "value": "UTC+13"},
  {
    "label": "Venezuela-Standard-Time",
    "offset": "GMT-04:00",
    "value": "Venezuela Standard Time"
  },
  {
    "label": "Vladivostok-Standard-Time",
    "offset": "GMT+10:00",
    "value": "Vladivostok Standard Time"
  },
  {
    "label": "Volgograd-Standard-Time",
    "offset": "GMT+03:00",
    "value": "Volgograd Standard Time"
  },
  {
    "label": "W-Australia-Standard-Time",
    "offset": "GMT+08:00",
    "value": "W. Australia Standard Time"
  },
  {
    "label": "W-Central-Africa-Standard-Time",
    "offset": "GMT+01:00",
    "value": "W. Central Africa Standard Time"
  },
  {
    "label": "W-Europe-Standard-Time",
    "offset": "GMT+01:00",
    "value": "W. Europe Standard Time"
  },
  {
    "label": "W-Mongolia-Standard-Time",
    "offset": "GMT+07:00",
    "value": "W. Mongolia Standard Time"
  },
  {
    "label": "West-Asia-Standard-Time",
    "offset": "GMT+05:00",
    "value": "West Asia Standard Time"
  },
  {
    "label": "West-Bank-Standard-Time",
    "offset": "GMT+02:00",
    "value": "West Bank Standard Time"
  },
  {
    "label": "West-Pacific-Standard-Time",
    "offset": "GMT+10:00",
    "value": "West Pacific Standard Time"
  },
  {
    "label": "Yakutsk-Standard-Time",
    "offset": "GMT+09:00",
    "value": "Yakutsk Standard Time"
  },
  {
    "label": "Yukon-Standard-Time",
    "offset": "GMT-07:00",
    "value": "Yukon Standard Time"
  },
  {
    "label": "Gulf-Standard-Time",
    "offset": "GMT+04:00",
    "value": "Arabian Standard Time"
  },
];

final ln = [
  'timeZones_Afghanistan_Standard_Time',
  'timeZones_Alaskan_Standard_Time',
  'timeZones_Aleutian_Standard_Time',
  'timeZones_Altai_Standard_Time',
  'timeZones_Arab_Standard_Time',
  'timeZones_Arabian_Standard_Time',
  'timeZones_Argentina_Standard_Time',
  'timeZones_Astrakhan_Standard_Time',
  'timeZones_Atlantic_Standard_Time',
  'timeZones_AUS_Central_Standard_Time',
  'timeZones_Aus_Central_W_Standard_Time',
  'timeZones_AUS_Eastern_Standard_Time',
  'timeZones_Azerbaijan_Standard_Time',
  'timeZones_Azores_Standard_Time',
  'timeZones_Bahia_Standard_Time',
  'timeZones_Bangladesh_Standard_Time',
  'timeZones_Belarus_Standard_Time',
  'timeZones_Bougainville_Standard_Time',
  'timeZones_Canada_Central_Standard_Time',
  'timeZones_Cape_Verde_Standard_Time',
  'timeZones_Caucasus_Standard_Time',
  'timeZones_Cen_Australia_Standard_Time',
  'timeZones_Central_America_Standard_Time',
  'timeZones_Central_Asia_Standard_Time',
  'timeZones_Central_Brazilian_Standard_Time',
  'timeZones_Central_Europe_Standard_Time',
  'timeZones_Central_European_Standard_Time',
  'timeZones_Central_Pacific_Standard_Time',
  'timeZones_Central_Standard_Time_Mexico',
  'timeZones_Central_Standard_Time',
  'timeZones_Chatham_Islands_Standard_Time',
  'timeZones_China_Standard_Time',
  'timeZones_Cuba_Standard_Time',
  'timeZones_Dateline_Standard_Time',
  'timeZones_E_Africa_Standard_Time',
  'timeZones_E_Australia_Standard_Time',
  'timeZones_E_Europe_Standard_Time',
  'timeZones_E_South_America_Standard_Time',
  'timeZones_Easter_Island_Standard_Time',
  'timeZones_Eastern_Standard_Time_Mexico',
  'timeZones_Eastern_Standard_Time',
  'timeZones_Egypt_Standard_Time',
  'timeZones_Ekaterinburg_Standard_Time',
  'timeZones_Fiji_Standard_Time',
  'timeZones_FLE_Standard_Time',
  'timeZones_Georgian_Standard_Time',
  'timeZones_GMT_Standard_Time',
  'timeZones_Greenland_Standard_Time',
  'timeZones_GTB_Standard_Time',
  'timeZones_Haiti_Standard_Time',
  'timeZones_Hawaiian_Standard_Time',
  'timeZones_India_Standard_Time',
  'timeZones_Iran_Standard_Time',
  'timeZones_Israel_Standard_Time',
  'timeZones_Jordan_Standard_Time',
  'timeZones_Kaliningrad_Standard_Time',
  'timeZones_Kamchatka_Standard_Time',
  'timeZones_Korea_Standard_Time',
  'timeZones_Libya_Standard_Time',
  'timeZones_Line_Islands_Standard_Time',
  'timeZones_Lord_Howe_Standard_Time',
  'timeZones_Magadan_Standard_Time',
  'timeZones_Magallanes_Standard_Time',
  'timeZones_Marquesas_Standard_Time',
  'timeZones_Mauritius_Standard_Time',
  'timeZones_Mid_Atlantic_Standard_Time',
  'timeZones_Middle_East_Standard_Time',
  'timeZones_Montevideo_Standard_Time',
  'timeZones_Morocco_Standard_Time',
  'timeZones_Mountain_Standard_Time_Mexico',
  'timeZones_Mountain_Standard_Time',
  'timeZones_Myanmar_Standard_Time',
  'timeZones_N_Central_Asia_Standard_Time',
  'timeZones_Namibia_Standard_Time',
  'timeZones_Nepal_Standard_Time',
  'timeZones_New_Zealand_Standard_Time',
  'timeZones_Newfoundland_Standard_Time',
  'timeZones_Norfolk_Standard_Time',
  'timeZones_North_Asia_East_Standard_Time',
  'timeZones_North_Asia_Standard_Time',
  'timeZones_North_Korea_Standard_Time',
  'timeZones_Omsk_Standard_Time',
  'timeZones_Pacific_SA_Standard_Time',
  'timeZones_Pacific_Standard_Time_Mexico',
  'timeZones_Pacific_Standard_Time',
  'timeZones_Pakistan_Standard_Time',
  'timeZones_Paraguay_Standard_Time',
  'timeZones_Qyzylorda_Standard_Time',
  'timeZones_Romance_Standard_Time',
  'timeZones_Russia_Time_Zone_12',
  'timeZones_Russia_Time_Zone_11',
  'timeZones_Russia_Time_Zone_4',
  'timeZones_Russian_Standard_Time',
  'timeZones_SA_Eastern_Standard_Time',
  'timeZones_SA_Pacific_Standard_Time',
  'timeZones_SA_Western_Standard_Time',
  'timeZones_Saint_Pierre_Standard_Time',
  'timeZones_Sakhalin_Standard_Time',
  'timeZones_Samoa_Standard_Time',
  'timeZones_Sao_Tome_Standard_Time',
  'timeZones_Saratov_Standard_Time',
  'timeZones_SE_Asia_Standard_Time',
  'timeZones_Singapore_Standard_Time',
  'timeZones_South_Africa_Standard_Time',
  'timeZones_South_Sudan_Standard_Time',
  'timeZones_Sri_Lanka_Standard_Time',
  'timeZones_Sudan_Standard_Time',
  'timeZones_Syria_Standard_Time',
  'timeZones_Taipei_Standard_Time',
  'timeZones_Tasmania_Standard_Time',
  'timeZones_Tocantins_Standard_Time',
  'timeZones_Tokyo_Standard_Time',
  'timeZones_Tomsk_Standard_Time',
  'timeZones_Tonga_Standard_Time',
  'timeZones_Transbaikal_Standard_Time',
  'timeZones_Turkey_Standard_Time',
  'timeZones_Turks_And_Caicos_Standard_Time',
  'timeZones_Ulaanbaatar_Standard_Time',
  'timeZones_US_Eastern_Standard_Time',
  'timeZones_US_Mountain_Standard_Time',
  'timeZones_UTC',
  'timeZones_UTC_plus_12',
  'timeZones_UTC_plus_13',
  'timeZones_UTC_02',
  'timeZones_UTC_08',
  'timeZones_UTC_09',
  'timeZones_UTC_11',
  'timeZones_Venezuela_Standard_Time',
  'timeZones_Vladivostok_Standard_Time',
  'timeZones_Volgograd_Standard_Time',
  'timeZones_W_Australia_Standard_Time',
  'timeZones_W_Central_Africa_Standard_Time',
  'timeZones_W_Europe_Standard_Time',
  'timeZones_W_Mongolia_Standard_Time',
  'timeZones_West_Asia_Standard_Time',
  'timeZones_West_Bank_Standard_Time',
  'timeZones_West_Pacific_Standard_Time',
  'timeZones_Yakutsk_Standard_Time',
  'timeZones_Yukon_Standard_Time',
  'timeZones_Gulf_Standard_Time',
];
