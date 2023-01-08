import 'package:stock_fantasy_flutter_app/models/individual_stat.dart';

const Map<String, List<String>> influencers = {
  "Gems Bong": ["Reliance", "Nifty 50", "M&M"],
  "Hari Putar": ["Reliance", "Nifty 50", "M&M"],
  "Zhong Xina": ["Reliance", "Nifty 50", "M&M", "Bing Chiling"],
  "Chacha Chaudhary": ["Reliance", "Nifty 50", "M&M"],
};

const Map<String, String> influencerPics = {
  "Gems Bong": "gems.jpg",
  "Hari Putar": "putar.jpg",
  "Zhong Xina": "xina.jpg",
  "Chacha Chaudhary": "chacha.jpg",
};

List<String> months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

Map<String, DateTime> otherDates = {
  "05-01-2023": DateTime(2023, 1, 5),
  "06-01-2023": DateTime(2023, 1, 6),
};

Map<String, double> previousStockData = {
  "NIFTY 50": 18042.95,
  "DIVISLAB": 3430,
  "MARUTI": 8419,
  "HDFCLIFE": 597.9,
  "EICHERMOT": 3216,
  "DRREDDY": 4241.45,
  "TCS": 3313.1,
  "ULTRACEMCO": 6994.7,
  "BPCL": 336.3,
  "ADANIENT": 3822,
  "NTPC": 167,
  "HINDUNILVR": 2532.5,
  "AXISBANK": 958.6,
  "TECHM": 1019.7,
  "ICICIBANK": 897.65,
  "KOTAKBANK": 1824.9,
  "BRITANNIA": 4222.85,
  "HCLTECH": 1036.5,
  "HEROMOTOCO": 2707,
  "ASIANPAINT": 3012,
  "UPL": 715.1,
  "SBILIFE": 1260.65,
  "BAJFINANCE": 6562,
  "TATACONSUM": 761.65,
  "SUNPHARMA": 1001,
  "TITAN": 2592,
  "NESTLEIND": 19540,
  "LT": 2069,
  "CIPLA": 1065,
  "BAJAJFINSV": 1546,
  "M&M": 1235.5,
  "SBIN": 605.6,
  "BAJAJ-AUTO": 3556,
  "BHARTIARTL": 807,
  "ITC": 326.6,
  "APOLLOHOSP": 4428.95,
  "HDFC": 2625,
  "RELIANCE": 2516.65,
  "INDUSINDBK": 1220.95,
  "ADANIPORTS": 807,
  "GRASIM": 1688,
  "HDFCBANK": 1610.3,
  "INFY": 1494.95,
  "WIPRO": 389.4,
  "POWERGRID": 211.15,
  "TATAMOTORS": 385.75,
  "ONGC": 146.4,
  "TATASTEEL": 115.45,
  "COALINDIA": 216.9,
  "HINDALCO": 460.45,
  "JSWSTEEL": 735.95
};

List<List<IndividualStockStat>> stockStats = [
  [
    IndividualStockStat("RELIANCE", -250, 32),
    IndividualStockStat("M&M", 1002, 48),
    IndividualStockStat("BPCL", 230, 20),
  ],
  [
    IndividualStockStat("HFCLIFE", 121, 72),
    IndividualStockStat("M&M", 342, 28),
  ],
  [
    IndividualStockStat("LT", 2100, 50),
    IndividualStockStat("M&M", 1002, 32),
    IndividualStockStat("ADANIENT", 230, 38),
  ],
  [
    IndividualStockStat("RELIANCE", -250, 32),
    IndividualStockStat("M&M", 458, 40),
    IndividualStockStat("SBILIFE", 987, 18),
    IndividualStockStat("NIFY 50", 564, 10),
  ],
];
