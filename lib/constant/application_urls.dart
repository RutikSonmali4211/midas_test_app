class ApplicationUrls {
  // static const String baseUrl = 'http://10.0.2.2:3000/';
  static const String baseUrl = 'https://devmidasadmin.ergobite.com:3000/';
  static const String getUsersIpAddressUrl = "https://api.ipify.org/";
  static const String signUpUrl = '${baseUrl}auth/signup';
  static const String signInUrl = '${baseUrl}auth/signin';
  static const String signOutUrl = '${baseUrl}auth/signout';
  static const String refreshTokenUrl = '${baseUrl}auth/refreshToken';
  static const String setBiometricLoginEnabledOrDisabledUrl =
      '${baseUrl}users/biomatric';
  static const String checkBiometricEnabledUrl =
      '${baseUrl}auth/checkbiometricenable';
  static const String addDeviceTokenForBiometricUrl =
      '${baseUrl}users/addnewdevicetoken';
  static const String usersUrl = '${baseUrl}users';
  static const String signInWithBiometricUrl = '${baseUrl}auth/signinbiometric';
  static const String dropDownUrl = "${baseUrl}dropdownData";
  static const String investmentUrl = "${baseUrl}investment";
  static const String goalsUrl = "${baseUrl}goals";
  static const String userUrl = "${baseUrl}users";
  static const String getGoalsListByUserIdUrl = "${baseUrl}goals";
  static const String goldTypesUrl = "${baseUrl}goldType";
  static const String getTodaysGoldRatesUrl = "${baseUrl}goldType/today";
  static const String contactUsUrl = "${baseUrl}contactUs";
  static const String sendOtpUrl = "${baseUrl}sms/sendotp";
  static const String resendOtpUrl = "${baseUrl}sms/resendotp";
  static const String verifyOtpUrl = "${baseUrl}sms/verifyotp";
  static const String netWorthUrl = "${baseUrl}netWorth/checkNetWorth";
  static const String uploadKycFile = "${baseUrl}kyc/uploadKycFile";
  static const String createKyc = "${baseUrl}kyc/";
  static const String createEsign = "${baseUrl}kyc/startesign";
  static const String updateKycStatusAfterEsignCompleted = "${baseUrl}kyc/updatekycstatusbyuserid";
  static const String updateBankaccount = "${baseUrl}kyc/updatebankdetails";
  static const String fetchKycStatus = "${baseUrl}kyc/fetchkycstatus";
  static const String checkKyc = "${baseUrl}kyc/checkkyc";
  static const String getMutualFundsAmcWatchlist =
      "${baseUrl}mutualFund/getmutualfundlist";
  static const String getUsersMutualFundsAmcWatchlist =
      "${baseUrl}mutualFund/getWatchListMutalFundInfo";
  static const String addAmcToUsersWatchList =
      "${baseUrl}mutualFund/addMutualFundToWatchList";
  static const String removeAmcFromUsersWatchList =
      "${baseUrl}mutualFund/removeMutualFundToWatchList";
  static const String getMutualFundsSchemeDetailsByAmfiCode =
      "${baseUrl}amc/getschemedetails";
  static const String getSIPDetails = "${baseUrl}sip/getsipbyuserid";
  static const String mutualFundPurchaseUrl = "${baseUrl}mutualFund/buy";
  static const String mutualFundRedeemUrl = "${baseUrl}mutualFund/redemption";
  static const String verifyOrderAndMakePaymenturl =
      "${baseUrl}mutualFund/verifystartpayment";
  static const String confirmMutualFundRedeemUrl =
      "${baseUrl}mutualFund/verifyOtpToConfirmRedeem";
  static const String cancelSip = "${baseUrl}sip/cancel";
  static const String getMutualFundsPortfolioDetailsUrl =
      "${baseUrl}mutualFund/getportfoliodetails";
  static const String getMutualFundsHoldingReportstUrl =
      "${baseUrl}reports/holding/growth";
  static const String sipUrl = "${baseUrl}sip";
  static const String requestSIPPurchaseUrl = "${baseUrl}sip/create";
  static const String verifyOtpAndConfirmSipMandate = "${baseUrl}sip/verifyotpcreatemanadate";
  static const String createmandateForModifySip = "${baseUrl}sip/createauthorizemanadate";
  static const String confirmSIPPurchaseUrl = "${baseUrl}sip/confirmSip";
  static const String getMutualFundPurchaseByFolioNumber =
      "${baseUrl}mutualFund/getmfPurchase";
  static const String getsipbyid = "${baseUrl}sip/getsipbysipid";
  static const String skipSip = "${baseUrl}sip/skipsip";
  static const String getMutualFundOrders = "${baseUrl}order/getorderbyuserid";
  static const String getMutualFundOrdersByIsinNumber =
      "${baseUrl}order/getorderbyuseridisin";
  static const String downloadHoldingReportUrl = "${baseUrl}reports/holding";
  static const String downloadCapitalGainReportUrl = "${baseUrl}reports/capitalGain";
  static const String downloadInvestmentAccountWiseReportUrl = "${baseUrl}reports/investmentAccount";
  static const String downloadSchemeWiseReportUrl = "${baseUrl}reports/scheme";
  static const String getNotificationsUrl ="${baseUrl}notifications";
  static const String getMutualFundRecommondationStrategies ="${baseUrl}mfrecommondation/getmfRecommondationstrategybyuserid";
  static const String createMutualFundRecommondationForGoals ="${baseUrl}mutualFund/recommendmutualfund";
  static const String postbackUrl ="https://eoxgk333pft8s7x.m.pipedream.net";
}
