import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:notes/core/const/const.dart';

class Notes extends StatelessWidget {
  final String body;
  final String title;
  final String time;
  final String color;
  const Notes(
      {super.key,
      required this.body,
      required this.color,
      required this.time,
      required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p10),
      decoration: BoxDecoration(
        color: Color(int.parse(color)),
        borderRadius: BorderRadius.circular(AppRadius.r10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Scrollbar(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: AppColors.black),
                ),
                const SizedBox(
                  height: AppHeight.h8,
                ),
                Text(body,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: AppColors.black)),
              ],
            ),
          ),
          const SizedBox(
            height: AppHeight.h8,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.r25),
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: Center(
                child: Text(
                    DateTimeFormat.format(DateTime.parse(time),
                        format: 'D, M j, H:i'),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: AppColors.black)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
