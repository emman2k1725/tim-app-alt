// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:tim_app/widgets/blurContainer.dart';
import '../../../responsive.dart';
import '../../../utils/constants.dart';

class TravellerDashboardBody extends StatefulWidget {
  const TravellerDashboardBody({super.key});

  @override
  State<TravellerDashboardBody> createState() => _TravellerDashboardBodyState();
}

class _TravellerDashboardBodyState extends State<TravellerDashboardBody> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: Responsive.isDesktop(context) ? 0 : w / 20,
            vertical: 5),
        child: Responsive.isDesktop(context)
            ? DesktopScreenSize()
            : MobileScreenSize(),
      ),
    );
  }
}

class DesktopScreenSize extends StatelessWidget {
  const DesktopScreenSize({super.key});

  @override
  Widget build(BuildContext context) {
    return const BlurContainer(
        height: 650,
        width: double.maxFinite,
        childColumn: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        BlurContainer(
                          height: 220,
                          width: double.maxFinite,
                          childColumn: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BlurContainer(
                            height: 350,
                            width: double.maxFinite,
                            childColumn: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [],
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        BlurContainer(
                            height: 220,
                            width: double.maxFinite,
                            childColumn: Column()),
                        SizedBox(
                          height: 20,
                        ),
                        BlurContainer(
                            height: 350,
                            width: double.maxFinite,
                            childColumn: Column()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class MobileScreenSize extends StatelessWidget {
  const MobileScreenSize({super.key});

  @override
  Widget build(BuildContext context) {
    return BlurContainer(
        height: h!,
        width: w!,
        childColumn: Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlurContainer(
                  height: 220,
                  width: double.maxFinite,
                  childColumn: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [],
                  ),
                ),
                SizedBox(height: 15),
                BlurContainer(
                  height: 220,
                  width: double.maxFinite,
                  childColumn: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [],
                  ),
                ),
                SizedBox(height: 15),
                BlurContainer(
                  height: 220,
                  width: double.maxFinite,
                  childColumn: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [],
                  ),
                ),
                SizedBox(height: 15),
                BlurContainer(
                  height: 220,
                  width: double.maxFinite,
                  childColumn: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
