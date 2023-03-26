import '../../domain/entities/get_glossaries_entity.dart';

class GetGlossariesResponse  extends GetGlossariesEntity{
    const GetGlossariesResponse({
       required String alphabet,
       required List<RecordEntity> record,
}) : super(
        alphabet: alphabet,
        record: record,
    );

    factory GetGlossariesResponse.fromJson(Map<String, dynamic> json) => GetGlossariesResponse(
        alphabet: json["alphabet"] ?? "",
        record: json["record"] == null ? [] : List<RecordEntity>.from(json["record"].map((x) => RecordResponse.fromJson(x))),
    );
    
    static final tResponse = ([{"alphabet":"A","record":[{"term":"Absolute Return Strategy","definition":"An investment stategy that aims to produce positive returns, even when share markets are volatile, flat or falling, usually employing techniques that differ from traditional long-only strategies"},{"term":"Access Fund","definition":"Access Fund SPC"},{"term":"Account Stage","definition":"The progress of the investment portfolio."},{"term":"AGPE","definition":"Asia Gateway Private Equity Fund SPC"},{"term":"AGRECO","definition":"Asia Gateway Real Estate Co-investment Fund SPC"},{"term":"Alternatives","definition":"Assets that are alternatives to conventional investment types such as stocks, bonds and cash (e.g.&nbsp; private equity, hedge funds, real estate, and commodities),."},{"term":"Annualized Return","definition":"A return on an investment recalculated as an annual rate."},{"term":"AUM","definition":"Assets Under Management: the market value of the financial assets managed by a financial institution."}]},{"alphabet":"B","record":[{"term":"Balance Sheet","definition":"A report of the assets, liabilities and shareholders' equity of an entity at a specific point in time."},{"term":"Bearish","definition":"A market sentiment that expects asset prices to fall."},{"term":"BondVest","definition":"BondVest Limited."},{"term":"Book Value","definition":"The accounting value of an asset based on the original value, adjusted by accounting profits and losses, additional investment and shareholder distributions."},{"term":"Bullish","definition":"A market sentiment that expects asset prices to rise."}]},{"alphabet":"C","record":[{"term":"Called Commitment","definition":"A Commitment that has been funded at the request of the fund manager."},{"term":"Cap Rates","definition":"Capitalization Rates: the expected net income from a real estate property divided by its value."},{"term":"Capital Call","definition":"A request from a fund manager to an investor to pay some or all of Uncalled Commitments."},{"term":"Capital Growth","definition":"An investment strategy that aims to increase the value of an investment over time (also known as \"Capital Appreciation\"),."},{"term":"Capital Growth Program","definition":"Capital Growth Programme SPC"},{"term":"Capital Yielding","definition":"An investment strategy that aims to provide regular Income/ yield."},{"term":"Capital Yielding Program","definition":"Capital Yielding Program SPC"},{"term":"Cash in Transit","definition":"Money received from an investor that has yet to be processed due to the lag between the time money is received and the reporting period."},{"term":"Cash yield","definition":"The cash portion of the income from an investment divided by the value of the assets."},{"term":"ChinaVest","definition":"ChinaVest SPC"},{"term":"ChinaVest 2","definition":"ChinaVest II SPC"},{"term":"Commis. Expenses","definition":"Commissions charged by the financial advisor for providing investment advice or trading services."},{"term":"Commitment","definition":"The total capital (paid and unpaid), that an Investor has agreed to provide over a period when requested by the fund manager."},{"term":"Credit Opps","definition":"Credit Opportunities Segregated Portfolio"}]},{"alphabet":"D","record":[{"term":"Distressed Opps","definition":"Distressed/Opportunistic Segregated Portfolio"},{"term":"Distressed Shipping","definition":"Distressed Shipping Opportunities Segregated Portfolio"},{"term":"Distribution","definition":"A dividend, interest or capital repayment to an Investor."},{"term":"Dividend","definition":"The payment that a company makes to its shareholders from its accumulated earnings."},{"term":"DUNA","definition":"Duna Financing Segregated Portfolio"},{"term":"DYF","definition":"Diversified Yielding Fund SPC"}]},{"alphabet":"E","record":[{"term":"EBITDA","definition":"Earnings Before Interest, Tax, Depreciation and Amortization: a measure of a operating performance."}]},{"alphabet":"F","record":[{"term":"FIRF 2","definition":"Financial Institutions Restructuring Fund II SPC"},{"term":"FIRF 3","definition":"Financial Institutions Restructuring Fund III SPC"},{"term":"Fixed Income","definition":"A type of investment that usually has a fixed return that paid at regular intervals (e.g. bonds and money market funds),."},{"term":"Forex","definition":"Foreign exchange market"},{"term":"Fund","definition":"An investment vehicle through which investments are made."}]},{"alphabet":"G","record":[{"term":"GDF","definition":"GDF Fund SPC and GDF Fund LLC"}]},{"alphabet":"H","record":[{"term":"Healthcare Fund","definition":"Healthcare Fund Ltd."},{"term":"Holding(s),","definition":"The underlying assets/ investments/ deals in the portfolio."}]},{"alphabet":"I","record":[{"term":"Illiquid Asset","definition":"An asset that cannot be readily sold or exchanged for cash (e.g. private equity, real estate),."},{"term":"IndiaVest","definition":"IndiaVest Ltd."},{"term":"IRR","definition":"Internal Rate of Return: the annual return from an investment over the investment period."},{"term":"ITD","definition":"Inception-to-date: the period from the establishment of the portfolio/ investment to the date of the communication."}]},{"alphabet":"J","record":[{"term":"J-Curve","definition":"The tendency for investments (usually private equity), to deliver negative returns during the early years followed by gains in later years."}]},{"alphabet":"L","record":[{"term":"Liquid Asset","definition":"An asset that can be readily converted into cash&nbsp; (e.g. money market funds, shares of publicly held companies traded on a stock exchange),."}]},{"alphabet":"M","record":[{"term":"Managed Holdings","definition":"An investment portfolio managed by a third-party financial institution."},{"term":"Market Cap","definition":"Market Capitalization: the total value of the shares of a company traded on the stock market (market price multiplied by the number of shares outstanding),."},{"term":"Market Value","definition":"The price of an asset in the marketplace."},{"term":"MasterOpps","definition":"Master Opportunities SPC"},{"term":"Maturity","definition":"The date that the principal on debt instruments and other fixed income instruments is due to be repaid."},{"term":"MOIC","definition":"Multiple of Invested Capital: The cumulative returns from an investment over the investment period divided by the cost of the investment (typically used to assess private equity performance),."}]},{"alphabet":"N","record":[{"term":"NAV","definition":"Net Asset Value: the net value of the investments in a fund at given time."}]},{"alphabet":"O","record":[{"term":"Opps Credit II","definition":"Opportunistic Credit II Segregated Portfolio"}]},{"alphabet":"P","record":[{"term":"P/E Ratio","definition":"Price-to-Earnings: The price of a share divided by its past or future earnings."},{"term":"PECO","definition":"Private Equity Co-investment Fund SPC"},{"term":"PIK","definition":"Payment-in-Kind: interest or dividend that is not paid in cash (usually in the form of additional securities or deferred payments),."},{"term":"Portfolio Weight","definition":"The proportion that a particular asset represents in the portfolio expressed."},{"term":"Private Equity","definition":"An alternative investment in a company that is not listed on a public stock exchange."},{"term":"PV","definition":"Present Value: the value of a stream of cash flow discounted at a specified rate of return."}]},{"alphabet":"R","record":[{"term":"RAYF","definition":"Real Assets Yielding Fund SPC"},{"term":"RECO","definition":"TFO Real Estate Co-investment Program"},{"term":"Redemption","definition":"The return of invested capital."},{"term":"REOpps 2","definition":"TFO Real Estate Opportunities II SP"},{"term":"REVA","definition":"Real Estate Value-Add Programme SPC"}]},{"alphabet":"S","record":[{"term":"Sh Access Fund","definition":"Shari'ah Access Fund SPC"},{"term":"Sh AGPE","definition":" Shari'ah Asia Gateway Private Equity Fund SPC"},{"term":"Sh AGRECO","definition":" Shari'ah Asia Gateway Real Estate Co-Investment Fund SPC"},{"term":"Sh Capital Growth Program","definition":" Shari'ah Capital Growth Program SPC"},{"term":"Sh Capital Yielding Program","definition":" Shari'ah Capital Yielding Program SPC"},{"term":"Sh ChinaVest 2","definition":" Shari'ah ChinaVest II SPC"},{"term":"Shari'ah WealthAllocator","definition":" Shari'ah Wealth Allocator SPC"},{"term":"SPECO","definition":" Shari'ah Co-Investment Fund SPC"},{"term":"SPV","definition":"Special Purpose Vehicle: a legal entity created to fulfill a specific investment objective."},{"term":"SREVA","definition":"Shari'ah Real Estate Value-Add programm SPC"},{"term":"STIC","definition":"TFO/STIC Co-Investment Fund SPC"},{"term":"SukukVest","definition":"SukukVest Limited"}]},{"alphabet":"U","record":[{"term":"Uncalled Commitment","definition":"A Commitment that has been not yet been requested by the fund manager."}]},{"alphabet":"V","record":[{"term":"Valuation","definition":"The analytical process of determining the value of an asset."},{"term":"Volatility","definition":"A measure of the variations (using either standard deviation or variance), in the returns for a given security or market index."}]},{"alphabet":"W","record":[{"term":"WealthAllocator","definition":"Wealth Allocator SPC"}]},{"alphabet":"Y","record":[{"term":"Yield","definition":"Income received from an investment (including cash and/ or accrued interest),"},{"term":"YTD","definition":"Year-to-date: the period from the first day of the calendar year to the date of the communication."}]}] as List<dynamic>)
        .map((e) => GetGlossariesResponse.fromJson(e))
        .toList();
}

class RecordResponse extends RecordEntity{
    const RecordResponse({
        required String term,
        required String definition,
    }) : super(
        term: term,
        definition: definition,
    );

    factory RecordResponse.fromJson(Map<String, dynamic> json) => RecordResponse(
        term: json["term"] ?? "",
        definition: json["definition"] ?? "",
    );
}
    