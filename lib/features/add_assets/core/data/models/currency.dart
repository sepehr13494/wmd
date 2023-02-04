class Currency {
  final String symbol;
  final String name;

  Currency({
    required this.symbol,
    required this.name,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        symbol: json["value"],
        name: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "value": symbol,
        "label": name,
      };

  @override
  String toString() {
    return toJson().toString();
  }

  static final currenciesList = json.map((e) => Currency.fromJson(e)).toList();

  static const json = [
    {"value": "USD", "label": "United States dollar"},
    {"value": "BHD", "label": "Bahraini dinar"},
    {"value": "KWD", "label": "Kuwaiti dinar"},
    {"value": "OMR", "label": "Omani rial"},
    {"value": "QAR", "label": "Qatari riyal"},
    {"value": "SAR", "label": "Saudi riyal"},
    {"value": "AED", "label": "United Arab Emirates dirham"},
    {"value": "AFN", "label": "Afghan afghani"},
    {"value": "ALL", "label": "Albanian lek"},
    {"value": "AMD", "label": "Armenian dram"},
    {"value": "ANG", "label": "Netherlands Antillean guilder"},
    {"value": "AOA", "label": "Angolan kwanza"},
    {"value": "ARS", "label": "Argentine peso"},
    {"value": "AUD", "label": "Australian dollar"},
    {"value": "AWG", "label": "Aruban florin"},
    {"value": "AZN", "label": "Azerbaijani manat"},
    {"value": "BAM", "label": "Bosnia and Herzegovina convertible mark"},
    {"value": "BBD", "label": "Barbados dollar"},
    {"value": "BDT", "label": "Bangladeshi taka"},
    {"value": "BGN", "label": "Bulgarian lev"},
    {"value": "BIF", "label": "Burundian franc"},
    {"value": "BMD", "label": "Bermudian dollar"},
    {"value": "BND", "label": "Brunei dollar"},
    {"value": "BOB", "label": "Boliviano"},
    {"value": "BRL", "label": "Brazilian real"},
    {"value": "BSD", "label": "Bahamian dollar"},
    {"value": "BTN", "label": "Bhutanese ngultrum"},
    {"value": "BWP", "label": "Botswana pula"},
    {"value": "BYN", "label": "New Belarusian ruble"},
    {"value": "BYR", "label": "Belarusian ruble"},
    {"value": "BZD", "label": "Belize dollar"},
    {"value": "CAD", "label": "Canadian dollar"},
    {"value": "CDF", "label": "Congolese franc"},
    {"value": "CHF", "label": "Swiss franc"},
    {"value": "CLF", "label": "Unidad de Fomento"},
    {"value": "CLP", "label": "Chilean peso"},
    {"value": "CNY", "label": "Renminbi|Chinese yuan"},
    {"value": "COP", "label": "Colombian peso"},
    {"value": "CRC", "label": "Costa Rican colon"},
    {"value": "CUC", "label": "Cuban convertible peso"},
    {"value": "CUP", "label": "Cuban peso"},
    {"value": "CVE", "label": "Cape Verde escudo"},
    {"value": "CZK", "label": "Czech koruna"},
    {"value": "DJF", "label": "Djiboutian franc"},
    {"value": "DKK", "label": "Danish krone"},
    {"value": "DOP", "label": "Dominican peso"},
    {"value": "DZD", "label": "Algerian dinar"},
    {"value": "EGP", "label": "Egyptian pound"},
    {"value": "ERN", "label": "Eritrean nakfa"},
    {"value": "ETB", "label": "Ethiopian birr"},
    {"value": "EUR", "label": "Euro"},
    {"value": "FJD", "label": "Fiji dollar"},
    {"value": "FKP", "label": "Falkland Islands pound"},
    {"value": "GBP", "label": "Pound sterling"},
    {"value": "GEL", "label": "Georgian lari"},
    {"value": "GHS", "label": "Ghanaian cedi"},
    {"value": "GIP", "label": "Gibraltar pound"},
    {"value": "GMD", "label": "Gambian dalasi"},
    {"value": "GNF", "label": "Guinean franc"},
    {"value": "GTQ", "label": "Guatemalan quetzal"},
    {"value": "GYD", "label": "Guyanese dollar"},
    {"value": "HKD", "label": "Hong Kong dollar"},
    {"value": "HNL", "label": "Honduran lempira"},
    {"value": "HRK", "label": "Croatian kuna"},
    {"value": "HTG", "label": "Haitian gourde"},
    {"value": "HUF", "label": "Hungarian forint"},
    {"value": "IDR", "label": "Indonesian rupiah"},
    {"value": "ILS", "label": "Israeli new shekel"},
    {"value": "IND", "label": "Indian rupee"},
    {"value": "IQD", "label": "Iraqi dinar"},
    {"value": "IRR", "label": "Iranian rial"},
    {"value": "ISK", "label": "Icelandic króna"},
    {"value": "JMD", "label": "Jamaican dollar"},
    {"value": "JOD", "label": "Jordanian dinar"},
    {"value": "JPY", "label": "Japanese yen"},
    {"value": "KES", "label": "Kenyan shilling"},
    {"value": "KGS", "label": "Kyrgyzstani som"},
    {"value": "KHR", "label": "Cambodian riel"},
    {"value": "KMF", "label": "Comoro franc"},
    {"value": "KPW", "label": "North Korean won"},
    {"value": "KRW", "label": "South Korean won"},
    {"value": "KYD", "label": "Cayman Islands dollar"},
    {"value": "KZT", "label": "Kazakhstani tenge"},
    {"value": "LAK", "label": "Lao kip"},
    {"value": "LBP", "label": "Lebanese pound"},
    {"value": "LKR", "label": "Sri Lankan rupee"},
    {"value": "LRD", "label": "Liberian dollar"},
    {"value": "LSL", "label": "Lesotho loti"},
    {"value": "LYD", "label": "Libyan dinar"},
    {"value": "MAD", "label": "Moroccan dirham"},
    {"value": "MDL", "label": "Moldovan leu"},
    {"value": "MGA", "label": "Malagasy ariary"},
    {"value": "MKD", "label": "Macedonian denar"},
    {"value": "MMK", "label": "Myanmar kyat"},
    {"value": "MNT", "label": "Mongolian tögrög"},
    {"value": "MOP", "label": "Macanese pataca"},
    {"value": "MRO", "label": "Mauritanian ouguiya"},
    {"value": "MUR", "label": "Mauritian rupee"},
    {"value": "MVR", "label": "Maldivian rufiyaa"},
    {"value": "MWK", "label": "Malawian kwacha"},
    {"value": "MXN", "label": "Mexican peso"},
    {"value": "MXV", "label": "Mexican Unidad de Inversion"},
    {"value": "MYR", "label": "Malaysian ringgit"},
    {"value": "MZN", "label": "Mozambican metical"},
    {"value": "NAD", "label": "Namibian dollar"},
    {"value": "NGN", "label": "Nigerian naira"},
    {"value": "NIO", "label": "Nicaraguan córdoba"},
    {"value": "NOK", "label": "Norwegian krone"},
    {"value": "NPR", "label": "Nepalese rupee"},
    {"value": "NZD", "label": "New Zealand dollar"},
    {"value": "PAB", "label": "Panamanian balboa"},
    {"value": "PEN", "label": "Peruvian Sol"},
    {"value": "PGK", "label": "Papua New Guinean kina"},
    {"value": "PHP", "label": "Philippine peso"},
    {"value": "PKR", "label": "Pakistani rupee"},
    {"value": "PLN", "label": "Polish złoty"},
    {"value": "PYG", "label": "Paraguayan guaraní"},
    {"value": "RON", "label": "Romanian leu"},
    {"value": "RSD", "label": "Serbian dinar"},
    {"value": "RUB", "label": "Russian ruble"},
    {"value": "RWF", "label": "Rwandan franc"},
    {"value": "SBD", "label": "Solomon Islands dollar"},
    {"value": "SCR", "label": "Seychelles rupee"},
    {"value": "SDG", "label": "Sudanese pound"},
    {"value": "SEK", "label": "Swedish krona"},
    {"value": "SGD", "label": "Singapore dollar"},
    {"value": "SHP", "label": "Saint Helena pound"},
    {"value": "SLL", "label": "Sierra Leonean leone"},
    {"value": "SOS", "label": "Somali shilling"},
    {"value": "SRD", "label": "Surilabelse dollar"},
    {"value": "SSP", "label": "South Sudanese pound"},
    {"value": "STD", "label": "São Tomé and Príncipe dobra"},
    {"value": "SVC", "label": "Salvadoran colón"},
    {"value": "SYP", "label": "Syrian pound"},
    {"value": "SZL", "label": "Swazi lilangeni"},
    {"value": "THB", "label": "Thai baht"},
    {"value": "TJS", "label": "Tajikistani somoni"},
    {"value": "TMT", "label": "Turkmenistani manat"},
    {"value": "TND", "label": "Tunisian dinar"},
    {"value": "TOP", "label": "Tongan paʻanga"},
    {"value": "TRY", "label": "Turkish lira"},
    {"value": "TTD", "label": "Trinidad and Tobago dollar"},
    {"value": "TWD", "label": "New Taiwan dollar"},
    {"value": "TZS", "label": "Tanzanian shilling"},
    {"value": "UAH", "label": "Ukrainian hryvnia"},
    {"value": "UGX", "label": "Ugandan shilling"},
    {"value": "UYI", "label": "Uruguay Peso en Unidades Indexadas"},
    {"value": "UYU", "label": "Uruguayan peso"},
    {"value": "UZS", "label": "Uzbekistan som"},
    {"value": "VEF", "label": "Venezuelan bolívar"},
    {"value": "VND", "label": "Vietlabelse đồng"},
    {"value": "VUV", "label": "Vanuatu vatu"},
    {"value": "WST", "label": "Samoan tala"},
    {"value": "XAF", "label": "Central African CFA franc"},
    {"value": "XCD", "label": "East Caribbean dollar"},
    {"value": "XOF", "label": "West African CFA franc"},
    {"value": "XPF", "label": "CFP franc"},
    {"value": "XXX", "label": "No currency"},
    {"value": "YER", "label": "Yemeni rial"},
    {"value": "ZAR", "label": "South African rand"},
    {"value": "ZMW", "label": "Zambian kwacha"},
    {"value": "ZWL", "label": "Zimbabwean dollar"}
  ];
}
