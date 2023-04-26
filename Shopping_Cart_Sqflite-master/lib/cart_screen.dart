import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cartt/Model/cart_model.dart';
import 'package:shopping_cartt/cart-provider.dart';
import 'package:shopping_cartt/db_helper.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<String> productImage = [
    'assets/images/shoes.jpg',
    'assets/images/jeans.jpg',
    'assets/images/bshoes.jpg',
    'assets/images/pent.jpg',
    'assets/images/jeans.jpg',
    'assets/images/p9.jpg',

    'assets/images/pent.jpeg',

    // 'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg?auto=compress&cs=tinysrgb&w=600',
    // 'https://images.pexels.com/photos/1633578/pexels-photo-1633578.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    // 'https://images.pexels.com/photos/718742/pexels-photo-718742.jpeg',
    // 'https://images.pexels.com/photos/1893555/pexels-photo-1893555.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    // 'https://images.pexels.com/photos/1291712/pexels-photo-1291712.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    // 'https://images.pexels.com/photos/1624487/pexels-photo-1624487.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    // 'https://images.pexels.com/photos/718742/pexels-photo-718742.jpeg',
  ];
  DBHelper? dbHelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('My Products'),
          centerTitle: true,
          // ignore: prefer_const_literals_to_create_immutables
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
            FutureBuilder(
                future: cart.getData(),
                builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(40)),
                                            child: Image(
                                                fit: BoxFit.fill,
                                                height: 120,
                                                width: 155,
                                                image: AssetImage(
                                                    productImage[index]
                                                        .toString())
                                                // image: NetworkImage(snapshot
                                                //     .data![index]
                                                //     .toString())
                                                ),
                                          ),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      snapshot.data![index]
                                                          .productName
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 23,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    //!For delete item
                                                    InkWell(
                                                        onTap: () {
                                                          dbHelper!.delete(
                                                              snapshot
                                                                  .data![index]
                                                                  .id!);
                                                          cart.removeCounter();
                                                          cart.removeTotalPrice(
                                                              double.parse(snapshot
                                                                  .data![index]
                                                                  .productPrice
                                                                  .toString()));
                                                        },
                                                        child: const Icon(
                                                            Icons.delete))
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  snapshot.data![index].unitTag
                                                          .toString() +
                                                      " " +
                                                      r"$" +
                                                      snapshot.data![index]
                                                          .productPrice
                                                          .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                //!ADD TO CART
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: InkWell(
                                                    onTap: () {
                                                      int quantity = snapshot
                                                          .data![index]
                                                          .quantity!;
                                                      int price = snapshot
                                                          .data![index]
                                                          .initialPrice!;
                                                      quantity++;
                                                      if (quantity < 0) {}
                                                      int? newPrice =
                                                          price * quantity;
                                                      dbHelper!
                                                          .updateQuantity(Cart(
                                                              productId: snapshot
                                                                  .data![index]
                                                                  .productId!
                                                                  .toString(),
                                                              productName: snapshot
                                                                  .data![index]
                                                                  .productName!,
                                                              unitTag: snapshot
                                                                  .data![index]
                                                                  .unitTag!
                                                                  .toString(),
                                                              image: snapshot
                                                                  .data![index]
                                                                  .image!
                                                                  .toString(),
                                                              id: snapshot
                                                                  .data![index]
                                                                  .id!,
                                                              initialPrice: snapshot
                                                                  .data![index]
                                                                  .initialPrice!,
                                                              productPrice:
                                                                  newPrice,
                                                              quantity:
                                                                  quantity))
                                                          .then((value) {
                                                        newPrice = 0;
                                                        quantity = 0;
                                                        cart.removeTotalPrice(
                                                            snapshot
                                                                    .data![index]
                                                                    .initialPrice!
                                                                    .toString()
                                                                as double);
                                                      }).onError((error,
                                                              stackTrace) {
                                                        Text(error.toString());
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 35,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          color: Colors.black,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  int quantity = snapshot
                                                                      .data![
                                                                          index]
                                                                      .quantity!;
                                                                  int price = snapshot
                                                                      .data![
                                                                          index]
                                                                      .initialPrice!;
                                                                  quantity++;
                                                                  int?
                                                                      newPrice =
                                                                      price *
                                                                          quantity;
                                                                  dbHelper!
                                                                      .updateQuantity(Cart(
                                                                          productId: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .productId!
                                                                              .toString(),
                                                                          productName: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .productName!,
                                                                          unitTag: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .unitTag!
                                                                              .toString(),
                                                                          image: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .image!
                                                                              .toString(),
                                                                          id: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .id!,
                                                                          initialPrice: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .initialPrice!,
                                                                          productPrice:
                                                                              newPrice,
                                                                          quantity:
                                                                              quantity))
                                                                      .then(
                                                                          (value) {
                                                                    newPrice =
                                                                        0;
                                                                    quantity =
                                                                        0;
                                                                    cart.addTotalPrice(snapshot
                                                                        .data![
                                                                            index]
                                                                        .initialPrice!
                                                                        .toString() as double);
                                                                  }).onError((error,
                                                                          stackTrace) {
                                                                    Text(error
                                                                        .toString());
                                                                  });
                                                                },
                                                                child:
                                                                    const Icon(
                                                                  Icons.add,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              Text(
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .quantity
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16.5,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),

                                                              //! FOR REMOVE
                                                              InkWell(
                                                                onTap: () {
                                                                  int quantity = snapshot
                                                                      .data![
                                                                          index]
                                                                      .quantity!;
                                                                  int price = snapshot
                                                                      .data![
                                                                          index]
                                                                      .initialPrice!;
                                                                  quantity--;
                                                                  if (quantity <
                                                                      1) {}
                                                                  int?
                                                                      newPrice =
                                                                      price *
                                                                          quantity;
                                                                  dbHelper!
                                                                      .updateQuantity(Cart(
                                                                          productId: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .productId!
                                                                              .toString(),
                                                                          productName: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .productName!,
                                                                          unitTag: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .unitTag!
                                                                              .toString(),
                                                                          image: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .image!
                                                                              .toString(),
                                                                          id: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .id!,
                                                                          initialPrice: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .initialPrice!,
                                                                          productPrice:
                                                                              newPrice,
                                                                          quantity:
                                                                              quantity))
                                                                      .then(
                                                                          (value) {
                                                                    newPrice =
                                                                        0;
                                                                    quantity =
                                                                        0;
                                                                    cart.removeTotalPrice(snapshot
                                                                        .data![
                                                                            index]
                                                                        .initialPrice!
                                                                        .toString() as double);
                                                                  }).onError((error,
                                                                          stackTrace) {
                                                                    Text(error
                                                                        .toString());
                                                                  });
                                                                },
                                                                child:
                                                                    const Icon(
                                                                  Icons.remove,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ]),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }));
                  }
                  return const Text('asdfg');
                }),
            Consumer<CartProvider>(builder: (context, value, child) {
              return Visibility(
                visible: value.getTotalPrice().toStringAsFixed(2) == "0.00"
                    ? false
                    : true,
                child: Column(
                  children: [
                    ReuseableWidget(
                        title: 'Sub Total',
                        value:
                            r'$: ' + value.getTotalPrice().toStringAsFixed(2)),
                    const ReuseableWidget(
                        title: 'Discount 5%', value: '${r'$'}20'),
                    ReuseableWidget(
                        title: 'Total Price',
                        value:
                            r'$: ' + value.getTotalPrice().toStringAsFixed(2))
                  ],
                ),
              );
            })
          ],
        ));
  }
}

class ReuseableWidget extends StatelessWidget {
  final String title, value;
  const ReuseableWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: ElevatedButton(
              onPressed: () {},
              child: Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    value.toString(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              )),
        )
      ],
    );
  }
}
