import 'package:midas/constant/colors.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/data/mutual_funds/sip_details_list.dart';
import 'package:midas/model/investments/mutual__funds/sip_details.dart';
import 'package:flutter/material.dart';

class MutualFundsWatchList extends StatefulWidget {
  const MutualFundsWatchList({super.key});

  @override
  State<MutualFundsWatchList> createState() => _MutualFundsWatchListState();
}

class _MutualFundsWatchListState extends State<MutualFundsWatchList> {
  final TextEditingController _searchController = TextEditingController();
  List<SIPDetails> filteredSipDetailsList = sipDetailsList;
  List<SIPDetails> selectedSipDetails = [];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: TextFormField(
                      controller: _searchController,
                      maxLength: 150,
                      onChanged: (value) {
                        setState(() {
                          filteredSipDetailsList = sipDetailsList
                              .where((sip) => sip.name
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                        });
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        counterText: "",
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Icon(Icons.search,
                              size: SizeUtil.iconsSize(context),
                              color: AppColors.primary),
                        ),
                        prefixIconConstraints: const BoxConstraints(),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Icon(Icons.highlight_remove_rounded,
                              size: SizeUtil.iconsSize(context),
                              color: AppColors.primary),
                        ),
                        suffixIconConstraints: const BoxConstraints(),
                        filled: true,
                        isDense: true,
                        border: InputBorder.none,
                        fillColor: TextfieldColors.background,
                      ),
                      style: TextStyle(fontSize: SizeUtil.body(context)),
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  icon: Icon(
                    Icons.filter_alt_sharp,
                    size: SizeUtil.iconsSize(context),
                    color: AppColors.primary,
                  ),
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuItem<String>>[
                      const PopupMenuItem<String>(
                        value: 'AMC name',
                        child: Text('AMC name'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'AMC type',
                        child: Text('AMC type'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'AMC category',
                        child: Text('AMC category'),
                      ),
                    ];
                  },
                  onSelected: (String choice) {
                    print('Selected filter: $choice');
                  },
                ),
              ],
            ),
            const Divider(
              color: AppColors.lightgrey,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            if (_searchController.text.isEmpty)
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: sipDetailsList.length,
                itemBuilder: (context, index) {
                  SIPDetails sip = sipDetailsList[index];
                  return Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(
                              SizeUtil.verticalSpacingSmall(context)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    sip.name,
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: SizeUtil.headingMedium(context),
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Helvetica",
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.delete,
                                      color: AppColors.primary,
                                      size: SizeUtil.iconsSize(context),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: SizeUtil.verticalSpacingSmall(context),
                              ),
                              Text(
                                'Growth | ${sip.sipType} - ${sip.sipTypeValue}',
                                style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: SizeUtil.body(context),
                                    fontFamily: "Helvetica"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        height: SizeUtil.verticalSpacingMedium(context),
                        color: AppColors.lightgrey,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),
                    ],
                  );
                },
              ),
            if (_searchController.text.isNotEmpty)
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: filteredSipDetailsList.length,
                itemBuilder: (context, index) {
                  SIPDetails sip = filteredSipDetailsList[index];
                  return Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(
                              SizeUtil.verticalSpacingSmall(context)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    sip.name,
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: SizeUtil.headingMedium(context),
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Helvetica",
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        SizeUtil.verticalSpacingSmall(context),
                                  ),
                                  Text(
                                    'Growth | ${sip.sipType} - ${sip.sipTypeValue}',
                                    style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: SizeUtil.body(context),
                                        fontFamily: "Helvetica"),
                                  ),
                                ],
                              ),
                              if (_searchController.text.isNotEmpty)
                                Theme(
                                  data: ThemeData(
                                    unselectedWidgetColor: AppColors.primary,
                                  ),
                                  child: Transform.scale(
                                    scale: 1,
                                    child: Checkbox(
                                      activeColor: AppColors.primary,
                                      value: selectedSipDetails.contains(sip),
                                      visualDensity: const VisualDensity(
                                        horizontal:
                                            VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity,
                                      ),
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      onChanged: (newValue) {
                                        setState(() {
                                          if (newValue ?? false) {
                                            selectedSipDetails.add(sip);
                                          } else {
                                            selectedSipDetails.remove(sip);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        height: SizeUtil.verticalSpacingMedium(context),
                        color: AppColors.lightgrey,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),
                    ],
                  );
                },
              )
          ],
        ),
      ),
    );
  }
}
