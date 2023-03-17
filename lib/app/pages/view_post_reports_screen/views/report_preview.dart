import 'package:atlas_mobile/app/model/post_report.model.dart';
import 'package:atlas_mobile/app/pages/view_post_reports_screen/controller/view_post_reports_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ReportPreview extends StatelessWidget {
  final PostReport report;
  ReportPreview({required this.report, super.key});

  final ViewPostReportsController c = Get.find<ViewPostReportsController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => c.onReportTap(),
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF6E9),
          border: Border.all(
            color: const Color(0xFF182335),
            width: 3,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              blurRadius: 4,
              offset: Offset(0, 4), // changes position of shadow
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reported on: ${c.getParsedDate(report.createdAt!)}',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  report.reason.toString().capitalizeFirst ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            SvgPicture.asset('assets/images/right_arrow_icon.svg')
          ],
        ),
      ),
    );
  }
}
