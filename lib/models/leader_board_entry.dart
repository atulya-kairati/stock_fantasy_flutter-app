
class LeaderBoardEntry {

  final String member;
  final int rank;
  final double score;

  LeaderBoardEntry(this.member, this.rank, this.score);
  
  @override
  String toString() {
    return "LeaderBoardEntry[member: $member, rank: $rank, score: $score]";
  }
}