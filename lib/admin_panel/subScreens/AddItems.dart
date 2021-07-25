import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../constants.dart';

class AddItems extends StatefulWidget {
  const AddItems({Key? key}) : super(key: key);
  static String id = '/addItems';
  @override
  _AddItemsState createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {

  String name = '';
  String cat = '';
  String discount = '0';
  String price = '';
  String imgUrl = '';
  bool onDiscount = false;
  bool isPopular = false;
  var pickedImage;
  uploadToStorage() {
    InputElement input = FileUploadInputElement() as InputElement
      ..accept = 'image/*';
    FirebaseStorage fs = FirebaseStorage.instance;
    input.click();
    input.onChange.listen((event) {
      final file = input.files!.first;
      final fileName = input.files!.first.name;
      final destination = 'image/$fileName';
      final reader = FileReader();
      reader.readAsDataUrl(file);
      print(input.files!.first.name);
      reader.onLoadEnd.listen((event) async {
        var snapshot = await fs.ref().child(destination).putBlob(file);
        String downloadUrl = await snapshot.ref.getDownloadURL();
        imgUrl = downloadUrl;
        setState(() {
          print("inside setstate");
          imgUrl = downloadUrl;
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.cyan,title: Text("Add New Item"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: ()async{
                uploadToStorage();
            },
              child: Container(
                width: MediaQuery.of(context).size.width*0.2,
                height: MediaQuery.of(context).size.height*0.1,
                decoration: kBoxDecoration,
                //child: pickedImage,
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
                      labelText: 'Product Name',
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
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.3,

                  child: TextFormField(
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      labelText: 'Product category',
                      labelStyle: TextStyle(
                          color: Colors.black45,
                          letterSpacing: 1.2,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (text) {
                      cat = text;
                    },
                    style: TextStyle(
                      //fontSize: 1 * SizeConfig.heightMultiplier,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
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
                      labelText: 'Price',
                      labelStyle: TextStyle(
                          color: Colors.black45,
                          letterSpacing: 1.2,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (text) {
                      price = text;
                    },
                    style: TextStyle(
                      //fontSize: 1 * SizeConfig.heightMultiplier,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.3,
                  child: Row(
                    children: [
                      Text("On Discount   ",style: TextStyle(
                          color: Colors.black45,
                          letterSpacing: 1.2,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),),
                      CupertinoSwitch(
                        onChanged: (value){
                          setState(() {
                            onDiscount = !onDiscount;
                          });
                        },
                        value: onDiscount,
                        trackColor: Colors.red,

                      ),
                    ],
                  )
                ),
              ],
            ),
            Container(
                width: MediaQuery.of(context).size.width*0.3,
                child: Row(
                  children: [
                    Text("Is Popular   ",style: TextStyle(
                        color: Colors.black45,
                        letterSpacing: 1.2,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),),
                    CupertinoSwitch(
                      onChanged: (value){
                        setState(() {
                          isPopular = !isPopular;
                        });
                      },
                      value: isPopular,
                      trackColor: Colors.red,
                    ),
                  ],
                )
            ),
            Visibility(
              visible: onDiscount,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.3,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        labelText: 'Discount %',
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
                      child: Text('',style: TextStyle(
                          color: Colors.black45,
                          letterSpacing: 1.2,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),)
                  ),
                ],
              ),
            ),
            AddProductButton(context)
          ],
        ),
      ),
    );
  }
  GestureDetector AddProductButton(BuildContext context) {
    return GestureDetector(
            onTap: () async{
                FirebaseFirestore.instance.collection('Items').doc().set({
                  'Name': name,
                  'PriceBefore': price + ' ₹',
                  'TotalDiscount': discount,
                  'Price': (int.parse(price) -
                      (int.parse(price) * 0.01 * int.parse(discount)))
                      .toString() + ' ₹',
                  'ImageUrl':imgUrl,
                  'isNew': true,
                  'onDiscount': onDiscount,
                  'Category': cat,
                  'isPopular':isPopular,
                  'outOfStock':false,
                });
              //}
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
          );
  }
}


