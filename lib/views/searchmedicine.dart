import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/helper/constants.dart';
import 'package:pharmacy/helper/helperfunctions.dart';
import 'package:pharmacy/views/homePage.dart';
import 'package:pharmacy/widgets/widget.dart';

class SearchMedicine extends StatefulWidget {
  @override
  _SearchMedicineState createState() => _SearchMedicineState();
}

class _SearchMedicineState extends State<SearchMedicine> {


  final firestoreInstance = Firestore.instance;

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async{
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
  }
  bool test = false;
  getData(){
        firestoreInstance.collection("medicineStatus").where("users",isEqualTo:Constants.myName).getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((result){
        setState(() {
          print(result.data["Status"]);
          test = result.data["Status"];
        });

      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Column(
        children: <Widget>[
          Container(
            child: getData(),
          ),
          Container(
           child: test? FinishPacking():Wait(),
          )
        ],
      ),
      );
  }
}
