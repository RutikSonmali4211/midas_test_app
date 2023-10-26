import 'package:midas/model/goals/goal_strategy_model.dart';

List<GoalStrategyModel> goalStrategyList = [
  GoalStrategyModel(
    name: 'House',
    fundDetails:
        'The goal has a long tern horizon. So, the strategy should focus on investing in equity based instruments. Mutual Funds suited to achieve this goal are:',
    mutualFundList: [
      MutualFunds(fundName: 'Tata equity midcap fund - 10,000 monthly SIP'),
      MutualFunds(fundName: 'HDFC balanced fund - 13,000 monthly SIP'),
      MutualFunds(fundName: 'Parag Parikh Flexicap fund - 12,400 monthly SIP'),
    ],
  ),
  GoalStrategyModel(
    name: 'Car',
    fundDetails:
        'The goal has a medium tern horizon. So, the strategy should focus on investing in hybrid instruments. Mutual Funds suited to achieve this goal are:',
    mutualFundList: [
      MutualFunds(fundName: 'Tata equity midcap fund - 10,000 monthly SIP'),
      MutualFunds(fundName: 'HDFC balanced fund - 13,000 monthly SIP'),
      MutualFunds(fundName: 'Parag Parikh Flexicap fund - 12,400 monthly SIP'),
    ],
  ),
];
