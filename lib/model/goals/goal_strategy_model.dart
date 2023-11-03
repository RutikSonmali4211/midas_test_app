class GoalStrategyModel {
  final String name;
  final String fundDetails;
  final List<MutualFunds> mutualFundList;
  GoalStrategyModel({
    required this.name,
    required this.fundDetails,
    required this.mutualFundList,
  });
}

class MutualFunds{
  final String fundName;
 MutualFunds({
    required this.fundName
  });
}