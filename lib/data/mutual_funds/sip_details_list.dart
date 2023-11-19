import 'package:midas/model/investments/mutual__funds/sip_details.dart';

List<SIPDetails> sipDetailsList = [
  SIPDetails(
      name: 'UTI Nifty50 Index Fund',
      sipType: 'Others',
      sipTypeValue: 'index Fund/ETFs',
      sipDuration: 'Monthly',
      amount: '10,000',
      isActive: true,
      nextInstallment: "2nd Aug 2023"),
  SIPDetails(
      name: 'Parag Parikh Flexi Cap Fund',
      sipType: 'Equity',
      sipTypeValue: 'Flexi Cap',
      sipDuration: 'Monthly',
      amount: '10,000',
      isActive: true,
      nextInstallment: "2nd Aug 2023"),
  SIPDetails(
      name: 'HDFC Banking Large Cap Fund',
      sipType: 'Equity',
      sipTypeValue: 'Large Cap',
      sipDuration: 'Monthly',
      amount: '10,000',
      isActive: false,
      nextInstallment: "2nd Aug 2023"),
];
