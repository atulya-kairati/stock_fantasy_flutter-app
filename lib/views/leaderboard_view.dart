import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stock_fantasy_flutter_app/models/leader_board_entry.dart';
import 'package:stock_fantasy_flutter_app/utils/route_name.dart';

class LeaderBoardView extends StatelessWidget {
  const LeaderBoardView(
      {super.key, required this.leaderBoard, required this.contestdate});

  final List<LeaderBoardEntry> leaderBoard;
  final String contestdate;

  @override
  Widget build(BuildContext context) {
    var meRank = Random().nextInt(leaderBoard.length);
    final meName = leaderBoard[meRank].member;
    leaderBoard.insert(0, leaderBoard.removeAt(meRank));

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView.builder(
            itemCount: leaderBoard.length,
            itemBuilder: ((context, index) {
              final entry = leaderBoard[index];
              return Card(
                color: (entry.member == meName)
                    ? Theme.of(context).colorScheme.inversePrimary
                    : Theme.of(context).colorScheme.primaryContainer,
                child: ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${entry.rank}",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 20),
                      ),
                    ],
                  ),
                  title: Text(
                    entry.member + ((entry.member == meName) ? " (you)" : ""),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    "${entry.score}",
                    style: TextStyle(color: getScoreColor(entry.score)),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      routeIndividualStatPage,
                      arguments: <String, String>{
                        "contestdate": contestdate,
                        "playername": entry.member,
                      },
                    );
                  },
                ),
              );
            })));
  }

  Color getScoreColor(double score) {
    if (score == 0.0) return Colors.yellow[900]!;
    if (score > 0.0) return Colors.green;
    return Colors.red;
  }
}
