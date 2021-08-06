import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kawaii/admin_panel/subScreens/SpecialItemScreen.dart';
import 'package:kawaii/components/constantComponents.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../constants.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  Map<String, double> dataMap = {"AverageEarning": 4, "none": 6};
  List<Color> colorList = [Color(0xFF2D60FF), Color(0xFFE7EDFF)];

  ChartType? _chartType = ChartType.ring;
  double? _ringStrokeWidth = 32;
  double? _chartLegendSpacing = 32;

  bool _showLegendsInRow = false;
  bool _showLegends = false;

  bool _showChartValueBackground = true;
  bool _showChartValues = false;
  bool _showChartValuesInPercentage = false;
  bool _showChartValuesOutside = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [unFilledOrderCard(), onShipping(), completedOrders()],
          ),
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(top: 20),
            decoration: kBoxDecoration,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Earnings Summary",
                  style: kBigText.copyWith(fontSize: 30),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: PieChart(
                          key: ValueKey(key),
                          dataMap: dataMap,
                          animationDuration: Duration(milliseconds: 800),
                          chartLegendSpacing: _chartLegendSpacing!,
                          chartRadius: MediaQuery.of(context).size.width * 0.05,
                          colorList: colorList,
                          initialAngleInDegree: 270,
                          chartType: _chartType!,
                          legendOptions: LegendOptions(
                            showLegendsInRow: _showLegendsInRow,
                            //legendPosition: _legendPosition!,
                            showLegends: _showLegends,
                            legendTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          chartValuesOptions: ChartValuesOptions(
                            showChartValueBackground: _showChartValueBackground,
                            showChartValues: _showChartValues,
                            showChartValuesInPercentage:
                                _showChartValuesInPercentage,
                            showChartValuesOutside: _showChartValuesOutside,
                          ),
                          ringStrokeWidth: _ringStrokeWidth!,
                          emptyColor: Colors.grey,
                        ),
                      ),
                      Container(
                        child: PieChart(
                          key: ValueKey(key),
                          dataMap: dataMap,
                          animationDuration: Duration(milliseconds: 800),
                          chartLegendSpacing: _chartLegendSpacing!,
                          chartRadius: MediaQuery.of(context).size.width * 0.05,
                          colorList: [Color(0xFF16DBCC), Color(0xFFDCFAF8)],
                          initialAngleInDegree: 270,
                          chartType: _chartType!,
                          legendOptions: LegendOptions(
                            showLegendsInRow: _showLegendsInRow,
                            //legendPosition: _legendPosition!,
                            showLegends: _showLegends,
                            legendTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          chartValuesOptions: ChartValuesOptions(
                            showChartValueBackground: _showChartValueBackground,
                            showChartValues: _showChartValues,
                            showChartValuesInPercentage:
                                _showChartValuesInPercentage,
                            showChartValuesOutside: _showChartValuesOutside,
                          ),
                          ringStrokeWidth: _ringStrokeWidth!,
                          emptyColor: Colors.grey,
                        ),
                      ),
                      Container(
                        child: PieChart(
                          key: ValueKey(key),
                          dataMap: dataMap,
                          animationDuration: Duration(milliseconds: 800),
                          chartLegendSpacing: _chartLegendSpacing!,
                          chartRadius: MediaQuery.of(context).size.width * 0.05,
                          colorList: colorList,
                          initialAngleInDegree: 270,
                          chartType: _chartType!,
                          legendOptions: LegendOptions(
                            showLegendsInRow: _showLegendsInRow,
                            //legendPosition: _legendPosition!,
                            showLegends: _showLegends,
                            legendTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          chartValuesOptions: ChartValuesOptions(
                            showChartValueBackground: _showChartValueBackground,
                            showChartValues: _showChartValues,
                            showChartValuesInPercentage:
                                _showChartValuesInPercentage,
                            showChartValuesOutside: _showChartValuesOutside,
                          ),
                          ringStrokeWidth: _ringStrokeWidth!,
                          emptyColor: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: ()=>Navigator.pushNamed(context, SpecialItems.id),
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.1,
                    height: MediaQuery.of(context).size.height*0.1,
                    decoration:kBoxDecoration.copyWith(
                      color: Colors.purpleAccent
                    ),
                    child: Center(child: Text("Add New Special",textAlign: TextAlign.center,)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }


}
