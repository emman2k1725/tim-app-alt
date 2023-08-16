import 'package:flutter/material.dart';
import 'package:tim_app/pages/travellers/traveller_plan/components/travel_plan_date.dart';
import 'package:tim_app/pages/travellers/traveller_plan/travel_plan_kanban.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/utils/styles.dart';
import 'package:tim_app/widgets/blurContainer.dart';
import 'package:tim_app/widgets/customButtons.dart';

class TravelPlanSearch extends StatefulWidget {
  const TravelPlanSearch({super.key});

  @override
  State<TravelPlanSearch> createState() => _TravelPlanSearchState();
}

class _TravelPlanSearchState extends State<TravelPlanSearch> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: BlurContainer(
        height: 500,
        width: double.maxFinite,
        childColumn: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.receipt_long_outlined,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Start planning',
                      style: AppTextstyle.headerTextStyle,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [DateRangePickerTextField()]),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          child: SizedBox(
                            height: 300,
                            width: double.maxFinite,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Image.network(
                                homepageTim,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isLoading
                    ? const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2.0),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Generating',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )
                    : BlueElevatedButton(
                        onPressed: () async {
                          if (isLoading) return;

                          setState(() {
                            isLoading = true;
                          });
                          await Future.delayed(const Duration(seconds: 1));

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TravelPlanKanban()));
                        },
                        text: 'Generate Plan',
                        iconData: Icons.generating_tokens_outlined,
                      ),
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
