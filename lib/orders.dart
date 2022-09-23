import 'package:flutter/material.dart';
import 'constants.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  var orders = <Map<String, dynamic>>[
    {
      "user": "43",
      "orderId": "1",
      "items": ["sugar", "salt", "irish"],
      "additionalInfo": "iwant rice",
      "orderDate": "2019"
    },
    {
      "user": "43",
      "orderId": "1",
      "items": ["sugar", "salt", "irish"],
      "additionalInfo": "iwant rice",
      "orderDate": "2019"
    },
    {
      "user": "43",
      "orderId": "1",
      "items": ["sugar", "salt", "irish"],
      "additionalInfo": "iwant rice",
      "orderDate": "2019"
    },
  ];
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
            color: Colors.orange,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                  Text("Order Date"),
                ],
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
