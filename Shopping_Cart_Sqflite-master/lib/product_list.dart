import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cartt/Model/cart_model.dart';
import 'package:shopping_cartt/cart-provider.dart';
import 'package:shopping_cartt/cart_screen.dart';
import 'package:shopping_cartt/db_helper.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  DBHelper? dbHelper = DBHelper();
  List<String> productName = [
    'Shoes',
    'Dress',
    'Nike Shoes',
    'Pents',
    'Nike Shoes',
    'Jeans',
    'Jeans Top',
  ];
  List<String> productUnit = [
    'Single',
    'Single',
    'Single',
    'Single',
    'Single',
    'Single',
    'Single',
  ];
  List<int> productPrice = [10, 20, 30, 40, 50, 60, 70];
  List<String> productImage = [
    'assets/images/shoes.jpg',
    'assets/images/jeans.jpg',
    'assets/images/bshoes.jpg',
    'assets/images/pent.jpg',
    'assets/images/bshoes.jpg',
    'assets/images/pent.jpg',
    'assets/images/jeans.jpg',

    // 'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg?auto=compress&cs=tinysrgb&w=600',
    // 'https://images.pexels.com/photos/1633578/pexels-photo-1633578.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    // 'https://images.pexels.com/photos/718742/pexels-photo-718742.jpeg',
    // 'https://images.pexels.com/photos/1893555/pexels-photo-1893555.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    // 'https://images.pexels.com/photos/1291712/pexels-photo-1291712.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    // 'https://images.pexels.com/photos/1624487/pexels-photo-1624487.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    // 'https://images.pexels.com/photos/718742/pexels-photo-718742.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Shopping Cart'),
        centerTitle: true,
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CartScreen()));
            },
            child: Center(
              child: Badge(
                label: Text(cart.counter.toString()),
                // label: Consumer<CartProvider>(
                //   builder: (context, value, child) {
                //     return Text(
                //     value.getCounter().toString(),
                //     style: TextStyle(color: Colors.white),
                //   );
                //   },

                // ),
                // alignment: AlignmentDirectional.topStart,
                //  animationDuration: Duration(seconds: 2),

                backgroundColor: Colors.redAccent,
                child: const Icon(
                  Icons.shopping_bag_outlined,
                  size: 32.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 16.0,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: productImage.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40)),
                                  child: Image(
                                      fit: BoxFit.fill,
                                      height: 120,
                                      width: 155,
                                      image: AssetImage(
                                          productImage[index].toString())
                                      // image: NetworkImage(
                                      //     productImage[index].toString())
                                      ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        productName[index].toString(),
                                        style: const TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        productUnit[index].toString() +
                                            " " +
                                            r"$" +
                                            productPrice[index].toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                          onTap: () {
                                            dbHelper!
                                                .insert(Cart(
                                                    productId: index.toString(),
                                                    productName:
                                                        productName[index]
                                                            .toString(),
                                                    unitTag: productUnit[index],
                                                    image: productImage[index]
                                                        .toString(),
                                                    id: index,
                                                    initialPrice:
                                                        productPrice[index],
                                                    productPrice:
                                                        productPrice[index],
                                                    quantity: 1))
                                                .then((value) {
                                              print('Product is added to cart');
                                              cart.addTotalPrice(double.parse(
                                                  productPrice[index]
                                                      .toString()));
                                              cart.addCounter();
                                            }).onError((error, stackTrace) {
                                              Text(error.toString());
                                            });
                                          },
                                          child: Container(
                                            height: 35,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: const Center(
                                              child: Text(
                                                'Add to Cart',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.5,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}
