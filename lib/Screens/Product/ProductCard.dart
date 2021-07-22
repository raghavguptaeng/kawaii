import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kawaii/constants.dart';
class ProductCard extends StatelessWidget {
  ProductCard({this.img,required this.price,required this.name});
  var img;
  String name,price;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: ksecColor,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [kcolor1,kcolor2],
                    ),
                  ),
                  child: Image.network(img),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Align(
                      alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                          color: kbackColor,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft:  Radius.circular(50))
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.65,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(height: 50,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(name,style: LoginFontStyle.copyWith(color: LoginColor),),
                                Text(price,style: LoginFontStyle,)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
