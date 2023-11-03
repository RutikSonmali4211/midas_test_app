import 'package:midas/model/investments/mutual__funds/mutual_fund_transaction.dart';

List<MutualFundTransaction> mutualFundTransactionList = [
  MutualFundTransaction(
      name: 'UTI Nifty50 Index Fund',
      date: '6th Aug 2023',
      isComplete: false,
      nav: 'NA',
      amount: '10,000',
      units: '4.9803',
      paymentType: "Buy"),
  MutualFundTransaction(
      name: 'UTI Nifty50 Index Fund',
      date: '2nd Aug 2023',
      isComplete: true,
      nav: '2007.91',
      amount: '10,000',
      units: '4.9803',
      paymentType: "Sell"),
];
