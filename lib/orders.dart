import 'package:cached_network_image/cached_network_image.dart';
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
  List<Map<String, dynamic>> orders = [];

  getOrders() async {
    var user = FirebaseAuth.instance.currentUser!.uid;
    var order = await FirebaseFirestore.instance
        .collection("orders")
        .where("user", isEqualTo: user)
        .get();

    List<Map<String, dynamic>> _orders = [];

    order.docs.forEach((element) {
      _orders.add(element.data());
    });

    var orderDate = _orders[0]["items"][0];
    print(orderDate);

    setState(() {
      orders = _orders;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getOrders();
    print("INIT");
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
        var orderDate = order["orderDate"];
        print(orderDate);
        DateTime dt = (orderDate as Timestamp).toDate();

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color.fromARGB(94, 20, 250, 200),
          ),
          margin: const EdgeInsets.only(top: 15, right: 15, left: 15),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Expanded(
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: order["items"][0]["image"].toString(),
                  placeholder: (context, url) {
                    return Image.asset("assets/images/placeholder.gif");
                  },
                  height: 70,
                ),
                const SizedBox(width: 15),
                Column(
                  children: [
                    // ORDER ID
                    Row(
                      children: [
                        const Text(
                          "ORDER ID: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        Text(
                          order["orderId"].toString(),
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 10),

                    // ORDER DATE
                    Row(
                      children: [
                        const Text(
                          "DATE: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "$dt",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
