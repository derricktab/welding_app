import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  var orders = ["hello"];

  getOrders() async {
    var user = FirebaseAuth.instance.currentUser!.uid;
    var orders = await FirebaseFirestore.instance
        .collection("orders")
        .where("user", isEqualTo: user)
        .get();

    var _orders;

    orders.docs.forEach((element) {
      _orders = element.data();
    });

    setState(() {
      orders = _orders;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              size: 38,
            )),
        title: const Text("ORDERS"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: orders.isEmpty
          ? Column(
              children: [
                Image.asset("assets/images/empty.jpg"),

                const SizedBox(height: 30),

                const Text(
                  "YOU HAVE NOT MADE ANY ORDERS YET",
                  style: TextStyle(fontSize: 18),
                ),

                const SizedBox(height: 50),

                //PLACE ORDER BUTTON
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "services");
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text("PLACE ORDER"),
                    ),
                  ),
                ),
              ],
            )
          : OrderList(orders: orders),
    );
  }
}

class OrderList extends StatefulWidget {
  final List orders;

  const OrderList({super.key, required this.orders});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: widget.orders.map((order) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color.fromARGB(255, 213, 183, 127),
          ),
          margin: const EdgeInsets.only(top: 15, right: 15, left: 15),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Row(
            children: [
              Image.asset(
                "assets/images/b3.png",
                height: 70,
              ),
              const SizedBox(width: 50),
              Column(
                children: const [
                  Text(
                    "Order ID",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(height: 10),
                  Text(
                    "Order Date",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
