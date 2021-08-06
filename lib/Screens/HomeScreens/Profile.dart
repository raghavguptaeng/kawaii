import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kawaii/Screens/Auth/Login.dart';
import 'package:kawaii/Screens/User/AddorEditAddress.dart';
import 'package:kawaii/Screens/User/orders.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TopProfileSection(),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, Orders.id);
            },
            child: ProfileCards(
              name: "My Orders",
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Address(add: false)));
            },
            child: ProfileCards(
              name: "Shipping Addresses",
            ),
          ),
          // GestureDetector(
          //   onTap: (){
          //     showModalBottomSheet(
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.only(
          //               topLeft: Radius.circular(30),
          //               topRight: Radius.circular(30)),
          //         ),
          //         context: context,
          //         //backgroundColor: Colors.grey,
          //         builder: (context) {
          //           return StreamBuilder<QuerySnapshot>(
          //             stream: FirebaseFirestore.instance
          //                 .collection('PromoCodes')
          //                 .snapshots(),
          //             builder: (context, snapshot) {
          //               var data = snapshot.data!.docs;
          //               return ListView.builder(
          //                 itemCount: data.length,
          //                 itemBuilder: (context, index) {
          //                   {
          //                     return Container(
          //                       margin: EdgeInsets.all(15),
          //                       height: MediaQuery.of(context)
          //                           .size
          //                           .height *
          //                           0.15,
          //                       width: MediaQuery.of(context)
          //                           .size
          //                           .width *
          //                           0.7,
          //                       decoration: cardDecoration,
          //                       child: Row(
          //                         mainAxisAlignment:
          //                         MainAxisAlignment
          //                             .spaceBetween,
          //                         children: [
          //                           Container(
          //                             height: MediaQuery.of(context)
          //                                 .size
          //                                 .height *
          //                                 0.15,
          //                             width: MediaQuery.of(context)
          //                                 .size
          //                                 .width *
          //                                 0.30,
          //                             padding: EdgeInsets.all(10),
          //                             decoration: BoxDecoration(
          //                                 color: Color(0xFFC61510),
          //                                 borderRadius:
          //                                 BorderRadius.circular(
          //                                     20)),
          //                             child: Center(
          //                                 child: Text(
          //                                   data[index]['discount'] +
          //                                       ' % off',
          //                                   style:
          //                                   LoginFontStyle.copyWith(
          //                                       color:
          //                                       Colors.white),
          //                                 )),
          //                           ),
          //                           Column(
          //                             mainAxisAlignment:
          //                             MainAxisAlignment
          //                                 .spaceEvenly,
          //                             children: [
          //                               Text(
          //                                 data[index]['name'],
          //                                 style: LoginFontStyle
          //                                     .copyWith(
          //                                     fontSize: 25),
          //                               ),
          //                               Text(
          //                                 data[index]['code'],
          //                                 style: LoginFontStyle
          //                                     .copyWith(
          //                                     fontSize: 15),
          //                               )
          //                             ],
          //                           ),
          //                           Padding(
          //                             padding:
          //                             const EdgeInsets.all(8.0),
          //                             child: Column(
          //                               children: [
          //                                 Text("Valid Till " +
          //                                     data[index]['validity'],
          //                                 ),
          //                               ],
          //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                             ),
          //                           )
          //                         ],
          //                       ),
          //                     );
          //                   }
          //                 },
          //               );
          //             },
          //           );
          //         });
          //   },
          //   child: ProfileCards(
          //     name: "Promo codes",
          //   ),
          // ),
          ProfileCards(
            name: "Contact Us",
          ),
          GestureDetector(
              onTap: () async {
                await launch('http://raghavguptaeng.github.io/');
              },
              child: Text("Made by Raghav Technologies"))
        ],
      ),
    );
  }
}

class ProfileCards extends StatelessWidget {
  ProfileCards({required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      padding: EdgeInsets.only(left: 20, right: 20),
      decoration: cardDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: LoginFontStyle.copyWith(fontSize: 20),
          ),
          Icon(
            CupertinoIcons.right_chevron,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}

class TopProfileSection extends StatelessWidget {
  const TopProfileSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "My Profile",
          style: LoginFontStyle.copyWith(color: LoginColor),
        ),
        GestureDetector(
          onTap: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacementNamed(context, Login.id);
          },
          child: Text(
            "Logout",
            style: TextStyle(color: ksecColor, fontWeight: FontWeight.bold,fontSize: 20),
          ),
        )
      ],
    );
  }
}
