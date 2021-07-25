import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../constants.dart';
class AddPromo extends StatefulWidget {
  static String id = '/addpromocode';
  const AddPromo({Key? key}) : super(key: key);

  @override
  _AddPromoState createState() => _AddPromoState();
}

class _AddPromoState extends State<AddPromo> {
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
    setState(() {
      if (args.value is PickerDateRange) {
        _range =
            DateFormat('dd/MM/yyyy').format(args.value.startDate).toString() +
                ' - ' +
                DateFormat('dd/MM/yyyy')
                    .format(args.value.endDate ?? args.value.startDate)
                    .toString();
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }
  String name = '';
  String code = '';
  String discount = '';
  String amount = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.cyan,title: Text("Add Promo Code"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.3,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      labelText: 'Promo Name',
                      labelStyle: TextStyle(
                          color: Colors.black45,
                          letterSpacing: 1.2,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (text) {
                      name = text;
                    },
                    style: TextStyle(
                      //fontSize: 1 * SizeConfig.heightMultiplier,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.3,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      labelText: 'Promo Code',
                      labelStyle: TextStyle(
                          color: Colors.black45,
                          letterSpacing: 1.2,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (text) {
                      code = text;
                    },
                    style: TextStyle(
                      //fontSize: 1 * SizeConfig.heightMultiplier,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
            Container(
              decoration: kBoxDecoration,
              child: Column(
                children: [Text("Valid Till",style: kBigText.copyWith(fontSize: 30),),
                  SfDateRangePicker(
                    onSelectionChanged: _onSelectionChanged,
                    selectionMode: DateRangePickerSelectionMode.single,
                    enablePastDates: false,
                    initialDisplayDate: DateTime.now(),
                  ),],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.3,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      labelText: 'Discount',
                      labelStyle: TextStyle(
                          color: Colors.black45,
                          letterSpacing: 1.2,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (text) {
                      discount = text;
                    },
                    style: TextStyle(
                      //fontSize: 1 * SizeConfig.heightMultiplier,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.3,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      labelText: 'Minimum Amount',
                      labelStyle: TextStyle(
                          color: Colors.black45,
                          letterSpacing: 1.2,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (text) {
                      amount = text;
                    },
                    style: TextStyle(
                      //fontSize: 1 * SizeConfig.heightMultiplier,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: (){
                FirebaseFirestore.instance.collection('PromoCodes').doc().set({
                  'name':name,
                  'code':code,
                  'validity':_selectedDate.substring(0,10),
                  'minimumAmount':amount,
                  'discount':discount,
                });
                Navigator.pop(context);
              },
              child: Container(
                height: MediaQuery.of(context).size.height*0.1,
                width: MediaQuery.of(context).size.width*0.3,
                decoration: kBoxDecoration.copyWith(color: Colors.redAccent),
                child: Center(
                  child: Text("Apply Promo",style: kBigText.copyWith(color: Colors.white,fontSize: 30),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

