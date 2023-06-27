class ListedSecurityName {
  final String category;
  final String? currencyCode;
  final String isin;
  final String? label;
  final String securityName;
  final String securityShortName;
  final String tradedExchange;
  final String? value;

  ListedSecurityName({
    required this.category,
    this.currencyCode,
    required this.isin,
    this.label,
    required this.securityName,
    required this.securityShortName,
    required this.tradedExchange,
    this.value,
  });

  static const json = [
    {
      "category": "Equity",
      "currencyCode": "USD",
      "isin": "US02079K1079",
      "label": "Amazon.com, Inc.",
      "securityName": "Amazon.com, Inc.",
      "securityShortName": "AMZN",
      "tradedExchange": "Nasdaq",
      "value": "Amazon.com, Inc.",
    },
    {
      "category": "FixedIncome",
      "currencyCode": "IND",
      "isin": "US02079K1079",
      "label": "Alphabet Inc Class A",
      "securityName": "Alphabet Inc Class A",
      "securityShortName": "GOOGL",
      "tradedExchange": "S&P",
      "value": "Alphabet Inc Class A"
    },
    {
      "category": "ETF",
      "currencyCode": "UAD",
      "isin": "US02079K1079",
      "label": "Tesla, Inc.",
      "securityName": "Tesla, Inc.",
      "securityShortName": "TSLA",
      "tradedExchange": "DOW",
      "value": "Tesla, Inc."
    },
    {
      "category": "MutualFund",
      "currencyCode": "USD",
      "isin": "US02079K1079",
      "label": "Meta Platforms, Inc. ",
      "securityName": "Meta Platforms, Inc. ",
      "securityShortName": "META",
      "tradedExchange": "Russell",
      "value": "Meta Platforms, Inc. "
    },
    {
      "category": "Equity",
      "currencyCode": "USD",
      "isin": "US02079K1079",
      "label": "Alphabet Inc Class C",
      "securityName": "Alphabet Inc Class C",
      "securityShortName": "GOOGL",
      "tradedExchange": "Nasdaq",
      "value": "Alphabet Inc Class C"
    },
  ];

  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() => {
        "category": category,
        "currencyCode": currencyCode,
        "isin": isin,
        "label": label,
        "securityName": securityName,
        "securityShortName": securityShortName,
        "tradedExchange": tradedExchange,
        "value": value,
      };

  factory ListedSecurityName.fromJson(Map<String, dynamic> json) =>
      ListedSecurityName(
        category: json["category"]??"",
        currencyCode: json["currencyCode"],
        isin: json["isin"]??"",
        label: json["label"],
        securityName: json["securityName"]??"",
        securityShortName: json["securityShortName"]??"",
        tradedExchange: json["tradedExchange"]??"",
        value: json["value"],
      );

  factory ListedSecurityName.fromAPI(Map<String, dynamic> json) =>
      ListedSecurityName(
        category: json["assetType"]??"",
        currencyCode: json["currency"]??"",
        isin: json["isinNumber"]??"",
        label: json["companyName"]??"",
        securityName: json["companyName"]??"",
        securityShortName: json["primaryExchangeName"]??"",
        tradedExchange: json["ticker"]??"",
        value: json["companyName"]??"",
      );

  static final listedSecurityNameList =
      json.map((e) => ListedSecurityName.fromJson(e)).toList();
}
