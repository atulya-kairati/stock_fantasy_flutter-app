import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:stock_fantasy_flutter_app/models/individual_stat.dart';
import 'package:stock_fantasy_flutter_app/models/leader_board_entry.dart';
import 'package:stock_fantasy_flutter_app/utils/app_data.dart';
import 'package:stock_fantasy_flutter_app/utils/dummy_data.dart';

import '../models/stock.dart';

Future<String> getContest() async {
  const endpoint = "http://182.23.130.96:443/sfl/getsflcontest";

  final url = Uri.parse(endpoint);
  final response = await http.get(url);
  final resJson = jsonDecode(response.body);
  dev.log("res body: $resJson");
  String date = resJson["contestdate"];
  var dateList = date.split("-").map((e) => int.parse(e)).toList();
  DateTime dateObj = DateTime(dateList[2], dateList[1], dateList[0]);
  dev.log(dateObj.toString());
  contestdateObj = dateObj;
  return date;
  // return "06-01-2023";
}

Future<List<Stock>> getPreContestFeed() async {
  const endpoint = "http://182.23.130.96:443/sfl/getsflprecontestfeed";

  var data = <String, String>{};
  data['contestdate'] = contestdate;

  final url = Uri.parse(endpoint);

  final response = await http.post(url, body: data);
  final resJson = jsonDecode(response.body);
  var dataMap = Map<String, num>.from(resJson['contestfeed']['data']);

  var stockMap = <String, double>{};

  List<Stock> stockList = [];

  for (var key in dataMap.keys) {
    stockMap[key] = dataMap[key]!.toDouble();
    stockList.add(Stock(key, dataMap[key]!.toDouble()));
  }

  return stockList;
}

joinContest(String data) async {
  var headers = {'Content-Type': 'application/json'};

  var response = await http.post(
    Uri.parse('http://182.23.130.96:443/sfl/joinsflcontest'),
    headers: headers,
    body: data,
  );
}

Future<List<LeaderBoardEntry>> getLeaderBoard(String contestdate) async {
  String endpoint = "http://182.23.130.96:443/sfl/getsflleaderboard";

  var data = <String, String>{};
  data['contestdate'] = contestdate;

  final url = Uri.parse(endpoint);

  final response = await http.post(url, body: data);
  final json = jsonDecode(response.body);

  List<LeaderBoardEntry> leaderBoard = [];

  // log(json["leaderboard"][0]["member"].toString());

  for (var entry in List<Map<String, dynamic>>.from(json["leaderboard"])) {
    LeaderBoardEntry leaderBoardEntry = LeaderBoardEntry(
        entry["member"] as String,
        entry["rank"] as int,
        entry["score"] as double);

    leaderBoard.add(leaderBoardEntry);
  }
  // print(leaderBoard);

  return leaderBoard;
}

Future<List<IndividualStockStat>> getIndividualStats(String name, String date) async {
  // await Future.delayed(const Duration(milliseconds: 500));

  const endpoint = "http://182.23.130.96:443/sfl/getsflteamscore";

  final url = Uri.parse(endpoint);
  final headers = {'Content-Type': 'application/json'};
  final body =  '{"contestdate":"09-01-2023", "teamname":"$name" }';

  var response = await http.post(
    url,
    headers: headers,
    body: body,
  );

  dev.log(response.body.toString());

  var data =
      '{"rank": 2, "score": 1200.0, "status": "success", "teamname": "sfluser1", "teamscore": {"teamname": "sfluser1", "cdate": "05-01-2023", "state": "Closed", "selection": {}, "totalbuyamount": 436400, "stockinfo": {"BAJFINANCE": {"buyprice": 6640, "quantity": 50, "amount": 332000, "currentprice": 6642, "currentamount": 332100, "gain": 100}, "HCLTECH": {"buyprice": 1044, "quantity": 100, "amount": 104400, "currentprice": 1055, "currentamount": 105500, "gain": 1100}}}}';

  // data = response.body;

  double totalAmount =
      double.parse(jsonDecode(data)["teamscore"]["totalbuyamount"].toString());


  Map<String, dynamic> med =
      Map.from(jsonDecode(data)["teamscore"]["stockinfo"]);

  List<IndividualStockStat> individualStatList = [];

  for (String key in med.keys) {
    var buyprice = double.parse(med[key]['buyprice'].toString());
    var currentprice = double.parse(med[key]['currentprice'].toString());
    var amount = double.parse(med[key]['amount'].toString());
    var quantity = double.parse(med[key]['quantity'].toString());

    if(buyprice == 0.0 || currentprice == 0.0 || amount == 0.0 || quantity == 0.0) continue;


    individualStatList.add(
      IndividualStockStat(
        key,
        (currentprice - buyprice) * quantity,
        amount * 100 / totalAmount,
      ),
    );
  }

  print(individualStatList);

  return stockStats[Random().nextInt(stockStats.length)];
}
