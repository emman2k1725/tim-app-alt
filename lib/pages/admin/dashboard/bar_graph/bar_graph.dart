import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tim_app/pages/admin/dashboard/bar_graph/bar_data.dart';

class BarGraph extends StatelessWidget {
  final List weeklySummary;
  const BarGraph({super.key, required this.weeklySummary});

  @override
  Widget build(BuildContext context) {
    BarData finalBarData = BarData(
      sunUser: weeklySummary[0],
      monUser: weeklySummary[1],
      tueUser: weeklySummary[2],
      wedUser: weeklySummary[3],
      thuUser: weeklySummary[4],
      friUser: weeklySummary[5],
      satUser: weeklySummary[6],
    );

    finalBarData.initializeBardata();

    return BarChart(BarChartData(
      maxY: 100,
      minY: 0,
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true, getTitlesWidget: getBottomTiles)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))),
      barGroups: finalBarData.barData
          .map(
            (data) => BarChartGroupData(x: data.x, barRods: [
              BarChartRodData(
                toY: data.y,
                width: 25,
                borderRadius: BorderRadius.circular(4),
              )
            ]),
          )
          .toList(),
    )

        // barGroups: finalBarData.barData
        // .map((data) =>
        // BarChartGroupData(x: data.x,
        // barRods: BarChartRodData(toY: data.y),
        // ),)
        // barGroups: finalBarData.barData
        // .map((data) =>
        // BarChartGroupData(x: data.x,
        // barRods: BarChartRodData(toY: data.y),
        // ),)
        );
  }
}

Widget getBottomTiles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text(
        'Sun',
        style: style,
      );
      break;
    case 1:
      text = const Text(
        'Mon',
        style: style,
      );
      break;
    case 2:
      text = const Text(
        'Tue',
        style: style,
      );
      break;
    case 3:
      text = const Text(
        'Wed',
        style: style,
      );
      break;
    case 4:
      text = const Text(
        'Thu',
        style: style,
      );
      break;
    case 5:
      text = const Text(
        'Fri',
        style: style,
      );
      break;
    case 6:
      text = const Text(
        'Sat',
        style: style,
      );
      break;
    default:
      text = const Text(
        '',
        style: style,
      );
      break;
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}
