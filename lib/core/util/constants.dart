import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/models/time_filer_obj.dart';

class AppConstants {
  static bool publicMvp2Items = dotenv.env['NEXT_PUBLIC_MVP2_ITEM']! == 'true';
  static bool developMode = dotenv.env['DEVELOPING_MODE']! == 'true';
  static bool developRoutes = dotenv.env['DEVELOPING_ROUTES']! == 'true';
  static bool isRelease1 = dotenv.env['IS_RELEASE_ONE']! == 'true';
  static bool isRelease2 = dotenv.env['IS_RELEASE_TWO']! == 'true';
  static bool currencyConvertor = dotenv.env['CURRENCY_CONVERTOR']! == 'true';
  static String bundleId = dotenv.env['BUNDLE_ID']!;

  static const String contactEmail = "developer@allinoneplus.com";
  // developMode ? "developer@allinoneplus.com" : "n.albasri@tfoco.com";

  static String tfoAuth0Base = dotenv.env['TFO_AUTH0_ISSUER_BASE_URL']!;
  static String tfoAuth0IssuerBaseUrl = Uri.https(tfoAuth0Base).toString();
  static String tfoAuth0ClientId = dotenv.env['TFO_AUTH0_CLIENT_ID']!;
  static String tfoAuth0Audience = 'https://$tfoAuth0Base/api/v2/';
  static String tfoAuth0RedirectionAndroid =
      '$bundleId://$tfoAuth0Base/android/$bundleId/callback';
  static String tfoAuth0RedirectionIos =
      '$bundleId://$tfoAuth0Base/ios/$bundleId/callback';

  static String pamAuth0IssuerBaseUrl =
      dotenv.env['PAM_AUTH0_ISSUER_BASE_URL']!;
  static String pamAuth0ClientId = dotenv.env['PAM_AUTH0_CLIENT_ID']!;

  static String getCertificate(env) {
    switch (env) {
      case "uat":
        return "assets/certificates/uat.crt";
      case "qa":
        return "assets/certificates/qa.crt";
      case "oldqa":
        return "assets/certificates/qa.crt";
      case "prod":
        return "assets/certificates/prod.crt";
      case "dev":
        return "assets/certificates/dev.crt";
      case "developer":
        return "assets/certificates/qa.crt";
      default:
        return "assets/certificates/dev.crt";
    }
  }

  static const custodianList = [
    "Abbot Downing",
    "ABN Amro",
    "Acrevis",
    "Addepar",
    "Aegis Capital Corp",
    "AKB",
    "Alliance Bernstein",
    "Apsys",
    "Aquila",
    "Arvest Bank",
    "Associated Bank",
    "Axion Bank",
    "Banca CIC",
    "Banca del Sempione",
    "Banca Popolare di Sondrio",
    "Banca Stato",
    "Banco de Investimento Global, S.A.",
    "Bank Julius Baer and Co.",
    "Bank of America",
    "Bank of Montreal",
    "Bank of New York Mellon",
    "Bank of Valletta",
    "Bank Syz & CO",
    "Banque Cantonal de Geneve (BCGE)",
    "Banque Cantonale de Fribourg",
    "Banque Cantonale du Valais",
    "Banque Cantonale GE",
    "Banque Cantonale Vaudoise",
    "Banque et Caisse d'pargne de l'tat",
    "Barclays",
    "Basellandschaftlichen Kantonalbank",
    "Basler Kantonalbank",
    "Baumann & Cie",
    "BBVA USA",
    "BDL",
    "BEKB",
    "Belfius",
    "Bellerive",
    "Bendura",
    "Berenberg",
    "Berliner Volksbank",
    "Bessemer Trust",
    "Biegel & Waller",
    "BIL",
    "BinckBank",
    "Bitcoin Suisse",
    "BNP Paribas",
    "Bordier",
    "Bordier & Cie",
    "Boston Private Bank",
    "BR Wealth Management",
    "Breckinridge Capital",
    "Brown Advisory",
    "Brown Brothers Harriman",
    "BT Super",
    "Buell Securities Corp.",
    "Burnham Securities Inc.",
    "C.W. Henderson & Associates, Inc.",
    "CA Indosuez",
    "Caceis",
    "Cambridge Investment Research",
    "Capital Analysts",
    "Capital@Work",
    "Cardinal Wealth Services",
    "Carnegie Bank",
    "Carnes Capital Corp",
    "Caseis Bank",
    "Catalio Capital Management",
    "Chapin Davis Investments",
    "Charles Schwab",
    "Chevy Chase Trust",
    "Chickasaw Securities",
    "CIBC",
    "CIC Bank",
    "Citibank",
    "Citigroup",
    "Commerce Brokerage Services, Inc.",
    "Commerce National Bank & Trust",
    "Commonwealth Financial Network",
    "Compagnie Monégasque de Banque",
    "Consolidated Financial Investments, Inc.",
    "Cornèr Bank",
    "Coutts",
    "Credem (Credito Emiliano)",
    "Credit Suisse",
    "Credo",
    "CryptoCrunch",
    "Cumberland Advisors",
    "Curren & Co.",
    "DA Davidson & Co.",
    "DBS",
    "Degroof",
    "Delen Private Bank",
    "Deutsche Bank",
    "DNB",
    "Dorsey & Whitney Trust Company",
    "Dreyfus",
    "DZ Bank",
    "Edmond de Rothschild",
    "EFG",
    "Enterprise Trust Company",
    "European Fund Administration",
    "Falcon",
    "Fidelity Investments",
    "Fiduciary Trust Company International",
    "Fifth Third Bank",
    "First Financial Trust & Asset Management Company",
    "First Horizon Bank",
    "First Knox National Bank",
    "First Merit Wealth Management Services",
    "First Republic Bank",
    "Fisher Investments",
    "Frankfurter Bankgesellschaft",
    "Frost Online Trust & Asset Management",
    "Gibraltar Private Bank & Trust",
    "Gilder, Gagnon Howe & Co.",
    "GLKB",
    "Globalance",
    "Goldman Sachs",
    "Gonet",
    "Graffenried",
    "Graubündner Kantonalbank (GKB)",
    "Greenleaf Trust",
    "Gutmann",
    "GW & Wade Asset Management Co.",
    "H.D. Vest Financial Services",
    "Handelsbanken",
    "Hauck Aufhäuser",
    "Hof Hoorneman Bankiers",
    "HSBC",
    "Huntleigh Securities Corp",
    "Hypothekarbank Lenzburg",
    "Hypovereinsbank",
    "ICONIQ Capital",
    "IHAG",
    "ING Group",
    "InsingerGilissen",
    "Interactive Brokers",
    "International Assets Advisory",
    "Intesa San Paolo",
    "Investacorp",
    "Investec",
    "J. Safra Sarasin",
    "J.P. Turner & Co.",
    "Janney Montgomery Scott",
    "JB Singapore",
    "John Hancock Financial",
    "JP Morgan",
    "JPMorgan Chase",
    "Julius Bär",
    "Kaiser Partner Privatbank",
    "KAS Bank",
    "Key Bank",
    "Klingenstein Fields & Co. LLC",
    "Ladenburg Thalmann & Co.",
    "Landolt et Cie",
    "LBBW",
    "LCS Securities LLC",
    "LGT",
    "Liberty",
    "Lienhardt&Partner",
    "Lincoln Douglas Investments, LLC",
    "LLB",
    "Lombard Odier",
    "LPL Direct Feed",
    "Luzerner Kantonalbank (LUKB)",
    "M&T Bank",
    "Maduro & Curiel's Bank",
    "Märki Baumann",
    "MassMutual",
    "Merrill Lynch",
    "Mesirow Financial, Inc.",
    "Mill Creek Capital Advisors, LLC",
    "Mirabaud",
    "Morgan Stanley",
    "NAB (Credit Suisse)",
    "Natixis",
    "Neuberger",
    "Neuberger Berman, LLC",
    "Neue Bank",
    "Neue Bank AG",
    "New York Life",
    "NFP",
    "Nidwaldner Kantonalbank",
    "NN Group",
    "Northern Trust Company",
    "Notenstein La Roche",
    "ODDO BHF",
    "Odlum Brown",
    "One Swiss Bank",
    "Open Wealth Format",
    "Oppenheimer & Co.",
    "Optimix Netherlands",
    "Pacific Investment Management Company LLC",
    "Pacific Western Bank",
    "Pareto Group",
    "Park Avenue Securities",
    "Pensco Trust Company, LLC",
    "Pictet",
    "Piguet Galland",
    "PKB",
    "PNC",
    "Popular, Inc.",
    "Purshe Kaplan Sterling Investments",
    "QazcomBank",
    "Quilvest",
    "Quintet",
    "Rabobank",
    "Rahn & Bodmer",
    "Raiffeisen",
    "Raymond James Financial",
    "Reichmuth",
    "Reyl",
    "Richards, Merrill & Peterson",
    "Robert W. Baird & Co. Incorporated",
    "Rockefeller Capital Management",
    "Ropes & Gray",
    "Rothschild & Co AG",
    "Royal Bank of Canada",
    "Safra Group",
    "Safra Sarasin",
    "SberBank",
    "Schwab",
    "Schwyzer Kantonalbank (SZKB)",
    "Seacoast Bank",
    "Seaside Bank & Trust",
    "Securities Service Network",
    "SGKB Deutschland",
    "Shelby Cullom Davis & Co, LP",
    "Shufro, Rose Co., LLC",
    "Sigma Financial Corp.",
    "Skandinaviska Enskilda Banken (SEB)",
    "Societe General",
    "Sparkasse",
    "Sparkasse Bludenz",
    "St. Galler Kantonalbank (SGBK)",
    "State Street",
    "Stephens Inc.",
    "Stifel",
    "Stifel Nicolaus",
    "Summit Equities, Inc.",
    "Sunflower Bank",
    "SunTrust Bank",
    "Svenska Handelsbanken",
    "Swissquote",
    "Syz",
    "Telesto",
    "Teslin Capital Management",
    "Thurgauer Kantonalbank (TKB)",
    "Tiedemann Advisors",
    "Transtrend",
    "Triad Advisors",
    "Triodos Bank",
    "Trust Company of Oklahoma",
    "UBS",
    "UMB Financial",
    "Umpqua Holdings Corporation",
    "Union Bancaire Prive",
    "US Bank",
    "USAA Financial Advisors, Inc.",
    "Van Lanschot",
    "Vanguard",
    "V-Bank",
    "Vontobel",
    "VP Bank",
    "Wedbush",
    "Wells Fargo",
    "Westpac",
    "WFG Investments Inc",
    "William Blair & Company",
    "Wilmington Trust WebFolio",
    "WSFS Wealth Christiana Trust",
    "Zähringer",
    "Zuger Kantonalbank (ZGKB)",
    "Zürcher Kantonalbank (ZKB)"
  ];

  static const securityList = [
    {
      "category": "Equity",
      "currencyCode": "USD",
      "isin": "US02079K1079",
      "label": "Amazon.com, Inc.",
      "securityName": "Amazon.com, Inc.",
      "securityShortName": "AMZN",
      "tradedExchange": "Nasdaq",
      "value": "Amazon.com, Inc."
    },
    {
      "category": "ETFs",
      "currencyCode": "IND",
      "isin": "US02079K1079",
      "label": "Alphabet Inc Class A",
      "securityName": "Alphabet Inc Class A",
      "securityShortName": "GOOGL",
      "tradedExchange": "S&P",
      "value": "Alphabet Inc Class A"
    },
    {
      "category": "EFF",
      "currencyCode": "UAD",
      "isin": "US02079K1079",
      "label": "Tesla, Inc.",
      "securityName": "Tesla, Inc.",
      "securityShortName": "TSLA",
      "tradedExchange": "DOW",
      "value": "Tesla, Inc."
    },
    {
      "category": "ETFs",
      "currencyCode": "USD",
      "isin": "US02079K1079",
      "label": "Meta Platforms, Inc. ",
      "securityName": "Meta Platforms, Inc. ",
      "securityShortName": "META",
      "tradedExchange": "Russell",
      "value": "Meta Platforms, Inc. "
    },
    {
      "category": "Mutual Fund",
      "currencyCode": "USD",
      "isin": "US02079K1079",
      "label": "Alphabet Inc Class C",
      "securityName": "Alphabet Inc Class C",
      "securityShortName": "GOOGL",
      "tradedExchange": "Nasdaq",
      "value": "Alphabet Inc Class C"
    }
  ];

  static String getCurrencySymbolByCode(String? currencyCode) {
    switch (currencyCode) {
      case "USD":
        return '\$';
      default:
        return '\$';
    }
  }

  static List<TimeFilterObj> timeFilter(BuildContext context) {
    final appLocalization = AppLocalizations.of(context);
    return [
      TimeFilterObj(
          key: appLocalization.home_select_duration_options_seven, value: 7),
      TimeFilterObj(
          key: appLocalization.home_select_duration_options_thirty, value: 30),
    ];
  }

  static List<TimeFilterObj> timeFilterForAssetPerformance(
      BuildContext context) {
    final appLocalization = AppLocalizations.of(context);
    return [
      TimeFilterObj(key: appLocalization.assets_label_itd, value: "ITD"),
      TimeFilterObj(key: appLocalization.assets_label_ytd, value: "YTD"),
      ...timeFilterOnlyDays(context),
    ];
  }

  static List<TimeFilterObj> timeFilterOnlyDays(BuildContext context){
    final appLocalization = AppLocalizations.of(context);
    return [
      TimeFilterObj(
          key: appLocalization.home_select_duration_options_seven,
          value: "Last7days"),
      TimeFilterObj(
          key: appLocalization.home_select_duration_options_thirty,
          value: "Last30days"),
    ];
  }
}

class BankProviders {
  static const String plaid = "Plaid";
  static const String lean = "Lean";
}

class AssetTypes {
  static const String bankAccount = 'BankAccount';
  static const String realEstate = 'RealEstate';
  static const String listedAsset = 'ListedAsset';
  static const String listedAssetEquity = 'ListedAssetEquity';
  static const String listedAssetFixedIncome = 'ListedAssetFixedIncome';
  static const String listedAssetOther = 'ListedAssetOther';
  static const String listedAssetOtherAsset = 'ListedAssetOtherAsset';
  static const String privateDebt = 'PrivateDebt';
  static const String privateEquity = 'PrivateEquity';
  static const String otherAsset = 'OtherAsset';
  static const String otherAssets = 'OtherAssets';
  static const String loanLiability = 'LoanLiability';
}
