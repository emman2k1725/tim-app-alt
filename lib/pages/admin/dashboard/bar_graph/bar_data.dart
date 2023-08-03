import 'package:tim_app/pages/admin/dashboard/bar_graph/individual_bar.dart';

class BarData {
  final double sunUser;
  final double monUser;
  final double tueUser;
  final double wedUser;
  final double thuUser;
  final double friUser;
  final double satUser;

  BarData({
    required this.sunUser,
    required this.monUser,
    required this.tueUser,
    required this.wedUser,
    required this.thuUser,
    required this.friUser,
    required this.satUser,
  });

  List<IndividualBar> barData = [];

//initialize bar data
  void initializeBardata() {
    barData = [
      IndividualBar(x: 0, y: sunUser),
      IndividualBar(x: 1, y: monUser),
      IndividualBar(x: 2, y: tueUser),
      IndividualBar(x: 3, y: wedUser),
      IndividualBar(x: 4, y: thuUser),
      IndividualBar(x: 5, y: friUser),
      IndividualBar(x: 6, y: satUser),
    ];
  }
}
