import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jwm2/Classes/Constants.dart';
import 'package:jwm2/Classes/Orders.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    getOrders();
  }

  List<Orders> pastOrders = [];
  List<Orders> ongoingOrders = [];
  FirebaseAuth mAuth = FirebaseAuth.instance;

  getOrders() async {
    pastOrders.clear();
    ongoingOrders.clear();
    final FirebaseUser user = await mAuth.currentUser();
    DatabaseReference orderRef =
        FirebaseDatabase.instance.reference().child('Orders').child(user.uid);
    orderRef.once().then((DataSnapshot snapshot) async {
      Map<dynamic, dynamic> values = await snapshot.value;
      values.forEach((key, values) async {
        Orders newOrder = Orders();
        newOrder.orderAmount = values['orderAmount'];
        print(newOrder.orderAmount);
        newOrder.itemsName = List<String>.from(values['itemsName']);
        newOrder.itemsQty = List<int>.from(values['itemsQty']);
        newOrder.dateTime = values['DateTime'];
        print(newOrder.dateTime);
        newOrder.completedTime = values['CompletedTime'];
        print(newOrder.completedTime);
        newOrder.shippedTime = values['ShippedTime'];
        newOrder.status = values['Status'];
        print(newOrder.status);
        print(newOrder.shippedTime);
        print(newOrder.itemsQty);
        print(newOrder.itemsName);
        if (values['isCompleted'] == false) {
          print('Ongoing');
          ongoingOrders.add(newOrder);
        } else {
          print('Past');
          pastOrders.add(newOrder);
        }

        setState(() {
          pastOrders;
          ongoingOrders;
          print('An order fetched');
        });
      });
    });

    print(ongoingOrders.length);
    print(pastOrders.length);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.watch_later,
                  color: Colors.white,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.check_circle,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          physics: ScrollPhysics(),
          children: <Widget>[
            ongoingOrders.length == 0
                ? SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: Text('You have no ongoing orders'),
                      ),
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: ongoingOrders.length,
                    itemBuilder: (context, index) {
                      var item = ongoingOrders[index];
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          height: 350,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  'Order ${index + 1}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      fontFamily: 'Cabin'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Item Name',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          fontFamily: 'Cabin'),
                                    ),
                                    Text(
                                      'Quantity',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          fontFamily: 'Cabin'),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  height: 100,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: item.itemsName.length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              item.itemsName[index],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  fontFamily: 'Cabin'),
                                            ),
                                            Text(
                                              item.itemsQty[index].toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  fontFamily: 'Cabin'),
                                            )
                                          ],
                                        );
                                      }),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                      child: Divider(
                                        color: Colors.white,
                                        thickness: 0.8,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Order Status',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              fontFamily: 'Cabin'),
                                        ),
                                        Text(
                                          ' ${item.status}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              fontFamily: 'Cabin'),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Order placed at',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              fontFamily: 'Cabin'),
                                        ),
                                        Text(
                                          ' ${item.dateTime}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              fontFamily: 'Cabin'),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Order shipped',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              fontFamily: 'Cabin'),
                                        ),
                                        Text(
                                          ' ${item.shippedTime}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              fontFamily: 'Cabin'),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Order Completed',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              fontFamily: 'Cabin'),
                                        ),
                                        Text(
                                          ' ${item.completedTime}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              fontFamily: 'Cabin'),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Order Amount',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              fontFamily: 'Cabin'),
                                        ),
                                        Text(
                                          'Rs. ${item.orderAmount.toString()}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              fontFamily: 'Cabin'),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
            pastOrders.length == 0
                ? SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: Text('You have no completed orders'),
                      ),
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: pastOrders.length,
                    itemBuilder: (context, index) {
                      var item = pastOrders[index];
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          height: 350,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  'Order ${index + 1}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      fontFamily: 'Cabin'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Item Name',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          fontFamily: 'Cabin'),
                                    ),
                                    Text(
                                      'Quantity',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          fontFamily: 'Cabin'),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: item.itemsName.length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              item.itemsName[index],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  fontFamily: 'Cabin'),
                                            ),
                                            Text(
                                              item.itemsQty[index].toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  fontFamily: 'Cabin'),
                                            )
                                          ],
                                        );
                                      }),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                        child: Divider(
                                          color: Colors.white,
                                          thickness: 0.8,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Order Status',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily: 'Cabin'),
                                          ),
                                          Text(
                                            ' ${item.status}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily: 'Cabin'),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Order placed at',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily: 'Cabin'),
                                          ),
                                          Text(
                                            ' ${item.dateTime}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily: 'Cabin'),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Order shipped',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily: 'Cabin'),
                                          ),
                                          Text(
                                            ' ${item.shippedTime}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily: 'Cabin'),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Order Completed',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily: 'Cabin'),
                                          ),
                                          Text(
                                            ' ${item.completedTime}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily: 'Cabin'),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Order Amount',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily: 'Cabin'),
                                          ),
                                          Text(
                                            'Rs. ${item.orderAmount.toString()}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily: 'Cabin'),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
          ],
        ),
      ),
    );
  }
}

//class OngoingOrders extends StatefulWidget {
//  @override
//  _OngoingOrdersState createState() => _OngoingOrdersState();
//}
//
//class _OngoingOrdersState extends State<OngoingOrders> {
//  @override
//  Widget build(BuildContext context) {
//    widget.ongoingOrders.length == 0
//        ? Container(
//            child: Center(
//              child: Text('You have no ongoing orders'),
//            ),
//          )
//        : Column(
//            children: <Widget>[
//              ListView.builder(
//                  itemCount: widget.ongoingOrders.length,
//                  itemBuilder: (context, index) {
//                    var item = widget.ongoingOrders[index];
//                    return Container(
//                      decoration: BoxDecoration(
//                        color: Color(0xFF900c3f),
//                        borderRadius: BorderRadius.circular(15),
//                      ),
//                      child: Column(
//                        children: <Widget>[
//                          Text(
//                            'Order ${index + 1}',
//                            style: TextStyle(
//                                color: Colors.white,
//                                fontWeight: FontWeight.bold,
//                                fontSize: 18,
//                                fontFamily: 'sf_pro'),
//                          ),
//                        ],
//                      ),
//                    );
//                  }),
//            ],
//          );
//  }
//}
