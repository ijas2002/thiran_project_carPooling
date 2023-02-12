import 'package:flutter/material.dart';

import 'creditCard.dart';

class cardListView extends StatefulWidget {
  const cardListView({Key? key}) : super(key: key);

  @override
  State<cardListView> createState() => _cardListViewState();
}

class _cardListViewState extends State<cardListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF725BBC),
          title: Text("CHOOSE THE PAYMENT METHOD"),
        ),
        body: Container(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: [
                Container(padding:EdgeInsets.only(top: 5,bottom: 10),width:300,height:300,child: Image(width:200,image: AssetImage('assets/card.jpg'),)),
                SizedBox(height: 150,),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>CreditCard()));
                  },
                  child: Container(
                    color: Color(0xFF725BBC).withOpacity(0.7),
                    alignment: Alignment.center,
                    height: 100,
                    child: Text("Credit Card",style: TextStyle(fontSize: 30),),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                MaterialButton(
                  onPressed: () {},
                  child: Container(
                    color: Color(0xFF725BBC).withOpacity(0.7),
                    alignment: Alignment.center,
                    height: 100,
                    child: Text("Debit Card",style: TextStyle(fontSize: 30),),
                  ),
                )
              ],
            )));
  }
}
