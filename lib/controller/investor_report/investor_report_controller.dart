// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart';
import 'package:midas/logs/loggers.dart';
import 'package:midas/service/investor_report/investor_report_service.dart';
import 'package:midas/widgets/alert_message/alert_message.dart';
import 'package:midas/widgets/loader.dart';
import 'package:permission_handler/permission_handler.dart';

class InvestorReportController extends GetxController {
  InvestorReportService investorReportService = InvestorReportService();

  Future<void> downloadHoldingReport(BuildContext context) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }
    if (status.isGranted) {
      try {
        Loader.showLoading();
        final response =
            await investorReportService.downloadHoldingReport(context);
        var jsonResponse = jsonDecode(response.body);
        if (response.statusCode == 200) {
          FileDownloader.downloadFile(
              onDownloadCompleted: (path) {
                showSuccessAlert("holding report download successfully");
              },
              onDownloadError: (path) {
                showErrorAlert("failed to download holding report");
              },
              headers: {"Content-Type": "application/pdf", "Accept": "*/*"},
              url: jsonResponse['result']['path'],
              name: "holdingReport.pdf",
              downloadDestination: DownloadDestinations.appFiles,
              notificationType: NotificationType.all);
        } else if (response.statusCode >= 500) {
          await Loggers.printLog(InvestorReportController, "ERROR",
              "error in download holding report ${jsonResponse['message']}");
        } else {
          showErrorAlert(jsonResponse['message']);
        }
      } catch (e) {
        e.toString();
      } finally {
        Loader.hideLoading();
      }
    } else {
      showErrorAlert("please give permissions to download the files");
    }
  }


  Future<void> downloadCapitalGainReport(BuildContext context) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }
    if (status.isGranted) {
      try {
        Loader.showLoading();
        final response = await investorReportService.downloadCapitalGainReport(context);
        var jsonResponse = jsonDecode(response.body);
        if (response.statusCode == 200) {
          FileDownloader.downloadFile(
              onDownloadCompleted: (path) {
                showSuccessAlert("capital gain report download successfully");
              },
              onDownloadError: (path) {
                showErrorAlert("failed to download capital gain report");
              },
              headers: {"Content-Type": "application/pdf", "Accept": "*/*"},
              url: jsonResponse['result']['path'],
              name: "capitalGainReport.pdf",
              downloadDestination: DownloadDestinations.appFiles,
              notificationType: NotificationType.all);
        } else if (response.statusCode >= 500) {
          await Loggers.printLog(InvestorReportController, "ERROR",
              "error in download capital gain report ${jsonResponse['message']}");
        } else {
          showErrorAlert(jsonResponse['message']);
        }
      } catch (e) {
        e.toString();
      } finally {
        Loader.hideLoading();
      }
    } else {
      showErrorAlert("please give permissions to download the files");
    }
  }

  Future<void> downloadInvestmentAccountWiseReport(BuildContext context) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }
    if (status.isGranted) {
      try {
        Loader.showLoading();
        final response = await investorReportService.downloadInvestmentAccountWiseReport(context);
        var jsonResponse = jsonDecode(response.body);
        if (response.statusCode == 200) {
          FileDownloader.downloadFile(
              onDownloadCompleted: (path) {
                showSuccessAlert("account wise report download successfully");
              },
              onDownloadError: (path) {
                showErrorAlert("failed to download account wise report");
              },
              headers: {"Content-Type": "application/pdf", "Accept": "*/*"},
              url: jsonResponse['result']['path'],
              name: "accountWiseReport.pdf",
              downloadDestination: DownloadDestinations.appFiles,
              notificationType: NotificationType.all);
        } else if (response.statusCode >= 500) {
          await Loggers.printLog(InvestorReportController, "ERROR",
              "error in download account wise report ${jsonResponse['message']}");
        } else {
          showErrorAlert(jsonResponse['message']);
        }
      } catch (e) {
        e.toString();
      } finally {
        Loader.hideLoading();
      }
    } else {
      showErrorAlert("please give permissions to download the files");
    }
  }

   Future<void> downloadSchemeWiseReport(BuildContext context) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }
    if (status.isGranted) {
      try {
        Loader.showLoading();
        final response = await investorReportService.downloadSchemeWiseReport(context);
        var jsonResponse = jsonDecode(response.body);
        if (response.statusCode == 200) {
          FileDownloader.downloadFile(
              onDownloadCompleted: (path) {
                showSuccessAlert("scheme wise report download successfully");
              },
              onDownloadError: (path) {
                showErrorAlert("failed to download scheme wise report");
              },
              headers: {"Content-Type": "application/pdf", "Accept": "*/*"},
              url: jsonResponse['result']['path'],
              name: "accountWiseReport.pdf",
              downloadDestination: DownloadDestinations.appFiles,
              notificationType: NotificationType.all);
        } else if (response.statusCode >= 500) {
          await Loggers.printLog(InvestorReportController, "ERROR",
              "error in download scheme wise report ${jsonResponse['message']}");
        } else {
          showErrorAlert(jsonResponse['message']);
        }
      } catch (e) {
        e.toString();
      } finally {
        Loader.hideLoading();
      }
    } else {
      showErrorAlert("please give permissions to download the files");
    }
  }





  // Future<void> downloadHoldingReport(BuildContext context) async {
  //   var status = await Permission.storage.status;
  //   try {
  //     if (!status.isGranted) {
  //       status = await Permission.storage.request();
  //     }
  //     if (status.isGranted) {
  //       // final response =
  //       //     await investorReportService.downloadHoldingReport(context);
  //       //     print(jsonDecode(response.body));
  //       // // if (response.statusCode == 200) {
  //       final appDocDir = await getExternalStorageDirectory();
  //       // final downloadDir = Directory('${appDocDir!.path}/PDFs');
  //       //   if (!downloadDir.existsSync()) {
  //       //     downloadDir.createSync(recursive: true);
  //       //   }
  //         // final filePath = '${downloadDir.path}/holdingReport.pdf';
  //         // File pdfFile = File(filePath);
  //         // await pdfFile.writeAsBytes(response.bodyBytes);

  //       // Start the download using flutter_downloader
  //     //  String? isSuccess=  await FlutterDownloader.enqueue(
  //     //   allowCellular: true,
  //     //   requiresStorageNotLow: true,
  //     //   saveInPublicStorage: true,
  //     //     // headers: {"Content-Type":"application/pdf", "Accept":"*/*", "Accept-Encoding":"gzip, deflate, br"},
  //     //     url: "https://tinypng.com/images/social/developer-api.jpg",
  //     //     timeout: 300000000,
  //     //     savedDir: appDocDir!.path,
  //     //     fileName: 'holdingReport.pdf',
  //     //     showNotification: true,
  //     //     openFileFromNotification: true,
  //     //   );
  //     //   // print("sdfsfsdfsdfsdfsdfsdfsdfsdfdsfsdfsdfsdf $isSuccess");
  //     //   await FlutterDownloader.initialize(debug: true,ignoreSsl: true);

  //     // http://devmidasadmin.ergobite.com:3000/download_report/assets/data/658330742f8f4f21700f3b64/holding

  //      FileDownloader.downloadFile(
  //         onDownloadCompleted: (path) {
  //           showSuccessAlert("file downlaoded successfully");
  //           print("success");
  //         },
  //         headers: {"Content-Type":"application/pdf", "Accept":"*/*", "Accept-Encoding":"gzip, deflate, br"},
  //         url: "http://devmidasadmin.ergobite.com:3000/download_report/assets/data/658330742f8f4f21700f3b64/holding.pdf",
  //         name: "holdingReport.pdf",
  //         downloadDestination: DownloadDestinations.appFiles,
  //         notificationType: NotificationType.all
  //       );
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
}
