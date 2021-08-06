import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kawaii/Components/Home%20Screen/CartComponents.dart';
import 'package:kawaii/Components/Home%20Screen/FavoriteComponents.dart';
import 'package:kawaii/Screens/User/AddorEditAddress.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../constants.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool isEmpty = false;

  int amount = 0;
  var razorpay;
  String address = '';
  String RazorpayId = '';
  String phone = '';
  String city = '',state = '';
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance.collection('Admin').doc('Details').get().then((value){
      RazorpayId = value['Razorpay'];
    });
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay.on(Razorpay.PAYMENT_CANCELLED.toString(), handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }
  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  String month(int m){
    if(m==1)
      return 'January';
    if(m==2)
      return 'February';
    if(m==3)
      return 'March';
    if(m==4)
      return 'April';
    if(m==5)
      return "May";
    if(m==6)
      return 'June';
    if(m==7)
      return 'July';
    if(m==8)
      return 'August';
    if(m==9)
      return 'September';
    if(m==10)
      return 'October';
    if(m==11)
      return 'November';
    return 'December';
  }
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  void handlePaymentSuccess(PaymentSuccessResponse response) {
    // print("Success");
    FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).collection('cart').get().then((snapshot) {
      var ds = snapshot.docs;
      var orderId = getRandomString(10);
      var items = [];
      for(int i=0 ; i<ds.length ; ++i){
        items.add( {
          'Name':ds[i]['Name'],
          // 'color':ds[i]['color'],
          'pid':ds[i]['pid'],
          'price':ds[i]['Price'],
          // 'size':ds[i]['size'],
          'qty':ds[i]['qty'],
          'ImageUrl':ds[i]['Image'],
          'orderId':orderId,
        });
      }
      FirebaseFirestore.instance.collection('orders').doc(orderId).set({
        'uid':FirebaseAuth.instance.currentUser!.uid.toString(),
        'total':amount.toString(),
        'date':DateTime.now().day.toString()+'-'+month(DateTime.now().month)+'-'+DateTime.now().year.toString(),
        'status':'order placed',
        'orderId':orderId,
        'items':items,
        'address':address,
        'phone':phone,
        'city':city,
        'state':state,
      });
    });
    // Fluttertoast.showToast(msg: response.toString());
    // Navigator.pushReplacementNamed(context, Success.id);
  }

  void handlePaymentError(PaymentSuccessResponse response) {
    // Fluttertoast.showToast(msg: 'fail');
    // Navigator.pushReplacementNamed(context, Faliure.id);
    print("faliure");
  }

  void handleExternalWallet(PaymentSuccessResponse response) {
    // Fluttertoast.showToast(msg: 'error');
    // Navigator.pushReplacementNamed(context, Faliure.id);
  }
  void checkout() {
    //todo:implement is finally
    var options = {
      'key': RazorpayId,//RazorpayKey,
      'amount': amount * 100, //in the smallest currency sub-unit.
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      razorpay.open(options);
    } catch (e) {
      print("Error = " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'My Cart',
            style: LoginFontStyle,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('User')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('cart')
                .snapshots(),
            builder: (context, snapshot) {
              var data = snapshot.data!.docs;
              if (data.length == 0) {
                isEmpty = true;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    Image.asset(
                      'assets/Images/touch.png',
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          "Touch our heart by adding those items to your cart !",
                          style: ksmallFontStyle.copyWith(color: Colors.black),
                        ))
                  ],
                );
              }
              isEmpty = false;
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView.builder(
                  itemCount: data.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return CartCard(data: data[index]);
                  },
                ),
              );
            },
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('User')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('cart')
                .snapshots(),
            builder: (context, snapshot) {
              var data = snapshot.data!.docs;
              if (data.length == 0) {
                return Container();
              }
              isEmpty = false;
              return checkoutButton(context);
            },
          )
        ],
      ),
    );
  }

  GestureDetector checkoutButton(BuildContext context) {
    return GestureDetector(
      onTap: () => CheckoutModalSheet(context),
      child: Container(
        decoration: ksubCard.copyWith(color: kPurpleLight),
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(),
            Row(
              children: [
                Text(
                  "Checkout",
                  style: ksmallFontStyle.copyWith(
                      color: Colors.white, fontSize: 15),
                ),
                Icon(
                  CupertinoIcons.right_chevron,
                  color: Colors.white,
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.05,
              child: Center(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('User')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('cart')
                      .snapshots(),
                  builder: (context, snapshot) {
                    amount = 0;
                    var data = snapshot.data!.docs;
                    for (int i = 0; i < data.length; ++i) {
                      int qty = int.parse(data[i]['qty']);
                      int price = int.parse(
                          data[i]['Price'].toString().replaceAll('₹', ''));
                      amount += (qty * price);
                    }
                    return Text(
                      amount.toString() + " ₹",
                      style: TextStyle(color: Colors.white),
                    );
                  },
                ),
              ),
              decoration: BoxDecoration(
                  color: kPurpleDark, borderRadius: BorderRadius.circular(5)),
            )
          ],
        ),
      ),
    );
  }

  void CheckoutModalSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: kbackColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0)),
      ),
      context: context,
      builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            children: [
              ModalTopSection(context),
              AddressSection(context),
              // PromoCode(context),
              TotalCost(context),
              TermsCard(context),
              GestureDetector(
                onTap: checkout,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.08,
                  decoration: ksubCard.copyWith(color: kPurpleLight),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.truck,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "PLACE ORDER",
                        style: ksmallFontStylewithStyle.copyWith(
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Center TermsCard(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.08,
        child: Center(
          child: Text(
            "By Placing an Order you agree to our Terms And Conditions",
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Container AddressSection(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.5, color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Address',
            style: ksmallFontStylewithStyle.copyWith(color: Colors.black),
          ),
          Row(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('User')
                    .doc(FirebaseAuth.instance.currentUser!.uid).collection('Address').where('isSelected',isEqualTo: true).snapshots(),
                builder: (context,snapshot){
                  if(snapshot.data!.docs.length==0)
                    return Text(
                      'Select Address',
                      style: ksmallFontStylewithStyle.copyWith(
                        color: kcolor1,
                      ),
                    );
                  address = snapshot.data!.docs[0]['address'];
                  phone = snapshot.data!.docs[0]['number'];
                  city = snapshot.data!.docs[0]['city'];
                  state = snapshot.data!.docs[0]['state'];
                  return Text(
                    snapshot.data!.docs[0]['address'].toString().substring(0,20),
                    style: ksmallFontStylewithStyle.copyWith(
                      color: kcolor1,
                    ),
                  );
                },
              ),
              GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Address(add: false))),
                  child: Icon(
                    CupertinoIcons.right_chevron,
                    color: kcolor1,
                  ))
            ],
          )
        ],
      ),
    );
  }

  Container PromoCode(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.5, color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Promo Code',
            style: ksmallFontStylewithStyle.copyWith(color: Colors.black),
          ),
          Row(
            children: [
              Text(
                'Pick Discount',
                style: ksmallFontStylewithStyle.copyWith(
                  color: kcolor1,
                ),
              ),
              Icon(
                CupertinoIcons.right_chevron,
                color: kcolor1,
              )
            ],
          )
        ],
      ),
    );
  }

  Container TotalCost(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.5, color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total Cost',
            style: ksmallFontStylewithStyle.copyWith(color: Colors.black),
          ),
          Text(
            amount.toString() + " ₹",
            style: ksmallFontStylewithStyle.copyWith(
              color: kcolor1,
            ),
          )
        ],
      ),
    );
  }

  Container ModalTopSection(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.08,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.5, color: Colors.grey.shade300),
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Checkout",
              style: ksmallFontStyle.copyWith(color: Colors.black),
            ),
            GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.cancel_outlined,
                  color: Colors.grey,
                ))
          ],
        ),
      ),
    );
  }
}
