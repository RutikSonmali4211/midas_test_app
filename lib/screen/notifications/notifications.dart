import 'package:flutter/material.dart';
import 'package:midas/constant/date_util.dart';
import 'package:midas/controller/notification/notification_controller.dart';
import 'package:midas/model/notifications/notifications_model.dart';
import 'package:midas/widgets/appbar/small_appbar.dart';

import 'package:get/get.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/widgets/alert_box.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var height;
  var width;
  final ScrollController notificationScrollController = ScrollController();
  int currentPage = 1;

  NotificationController notificationController =
      Get.put(NotificationController());

  @override
  void initState() {
    super.initState();
    notificationScrollController.addListener(scrollMoreNotifications);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notificationController.getNotifications(1, context);
    });
  }

  Future<void> scrollMoreNotifications() async {
    if (notificationController.isLoadingMoreNotificationList.value ||
        notificationController.noMoreDataLoadNotificationList.value) return;
    if (notificationScrollController.position.pixels ==
        notificationScrollController.position.maxScrollExtent) {
      setState(() {
        notificationController.isLoadingMoreNotificationList.value = true;
      });
      currentPage = currentPage + 1;
      await notificationController
          .getNotifications(currentPage, context)
          .then((value) {
        setState(() {
          notificationController.isLoadingMoreNotificationList.value = false;
        });
      });
    }
    notificationController.update();
  }

  @override
  void dispose() {
    notificationController.noMoreDataLoadNotificationList.value = false;
    notificationScrollController.dispose();
    super.dispose();
  }

  bool istoggle = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ignore: prefer_const_constructors
          SmallAppbar(heading: "Notifications"),
          SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: Obx(() => RefreshIndicator(
                    onRefresh: () async {
                      setState(() {
                          notificationController.noMoreDataLoadNotificationList.value = false;
                        currentPage=1;
                        notificationScrollController
                            .removeListener(scrollMoreNotifications);
                        notificationScrollController
                            .addListener(scrollMoreNotifications);
                        notificationController.getNotifications(1, context);
                      });
                    },
                    child: notificationController
                            .isLoadingNotificationList.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            controller: notificationScrollController,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: notificationController
                                    .notificationsList.length +
                                1,
                            itemBuilder: (context, index) {
                              if (index <
                                  notificationController
                                      .notificationsList.length) {
                                NotificationsModel notification =
                                    notificationController
                                        .notificationsList[index];
                                return Container(
                                  margin: EdgeInsets.only(
                                      bottom: SizeUtil.verticalSpacingSmall(
                                          context)),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            AppColors.shadow.withOpacity(0.01),
                                        offset: const Offset(0, 1),
                                        blurRadius: 1.0,
                                        spreadRadius: 1.0,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color:
                                          AppColors.lightgrey, // Border color
                                      width: 2.0, // Border width
                                    ),
                                    color: AppColors.white,
                                  ),
                                  width: double.infinity,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: SizeUtil.verticalSpacingSmall(
                                            context),
                                        left: SizeUtil.verticalSpacingSmall(
                                            context),
                                        right: SizeUtil.verticalSpacingSmall(
                                            context), //
                                        bottom: SizeUtil.verticalSpacingSmall(
                                            context)), //
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      notification.title
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.primary,
                                                          fontSize: SizeUtil
                                                              .bodyLarge(
                                                                  context),
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily:
                                                              "Helvetica"),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertBox(
                                                            message:
                                                                "Confirm Delete",
                                                            onConfirm: () {
                                                          notificationController.deleteNotification(notification.id.toString(),context);
                                                            Navigator.pop(
                                                                context);
                                                            });
                                                      },
                                                    );
                                                  },
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: AppColors.primary,
                                                    size: SizeUtil.iconsSize(
                                                        context),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                            height: SizeUtil.scallingFactor(
                                                    context) *
                                                8),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: RichText(
                                                    textScaleFactor:
                                                        MediaQuery.of(context)
                                                            .textScaleFactor,
                                                    textAlign: TextAlign.start,
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: notification
                                                              .body
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .primary,
                                                            fontSize:
                                                                SizeUtil.body(
                                                                    context),
                                                            fontFamily:
                                                                "Helvetica",
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      SizeUtil.scallingFactor(
                                                              context) *
                                                          8,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: Text(
                                                    DateUtil.checkNotificationTiming(notification.createdAt!),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: AppColors.grey,
                                                      fontFamily: "Helvetica",
                                                      fontSize: SizeUtil.body(
                                                          context),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Center(
                                      child: notificationController
                                              .noMoreDataLoadNotificationList
                                              .value
                                          ? Text(
                                              'no more data',
                                              style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontSize:
                                                      SizeUtil.body(context),
                                                  fontFamily: "Helvetica"),
                                            )
                                          : const CircularProgressIndicator()),
                                );
                              }
                            },
                          ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
