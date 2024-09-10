// import 'package:ecomapp/view/home_screen.dart';
// import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';
// import 'package:lottie/lottie.dart';
// import 'package:scratcher/scratcher.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../Data/api_service.dart';
// import '../block/cart_block.dart';
// import '../constants/colors.dart';
// import '../models/product_model.dart';
// import 'cart_screen.dart';
//
//
// class ScratchScreen extends StatefulWidget {
//   @override
//   _ScratchScreenState createState() => _ScratchScreenState();
// }
//
// class _ScratchScreenState extends State<ScratchScreen> {
//   Product? _randomProduct;
//   bool _scratched = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchRandomProduct();
//   }
//
//   // Function to fetch a random product from the API
//   void _fetchRandomProduct() async {
//     final apiService = ApiService();
//     final products = await apiService.fetchProducts();
//     setState(() {
//       _randomProduct = (products..shuffle()).first; // Randomly select a product
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:AppBar(leading: IconButton(onPressed: () {
//         Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
//
//       },
//           icon: CircleAvatar(
//               radius: 200,
//               backgroundColor: ColorConstant.red,
//               child: Icon(Icons.home,color: Colors.white),)),centerTitle: true,
//         title: Text("Gift card added"),
//         actions: [
//           BlocBuilder<CartBloc, CartState>(
//             builder: (context, state) {
//
//               int cartItemCount = 0;
//               if (state is CartLoaded) {
//                 cartItemCount = state.cart.length;
//               }
//               return CircleAvatar(
//                 radius: 50,
//                 backgroundColor: ColorConstant.red,
//                 child: Stack(
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.shopping_cart,color: Colors.white),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => CartScreen()),
//                         );
//                       },
//                     ),
//                     if (cartItemCount > 0)
//                       Positioned(
//                         right: 0.5,
//                         top: 1,
//                         child: CircleAvatar(
//                           radius: 10,
//                           backgroundColor: Colors.yellow,
//                           child: Text(
//                             '$cartItemCount',
//                             style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//
//
//       body: _randomProduct == null
//           ? Center(child: CircularProgressIndicator())
//           : Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(width: 200, // Set the desired width
//             height: 200,
//             child: Lottie.asset("assets/animation/gift.json",fit: BoxFit.fill),
//           ),
//
//
//           SizedBox(height: 10),
//           Center(
//             child: Scratcher(
//               color: ColorConstant.red,
//               brushSize: 200,
//               threshold: 40,
//               onThreshold: () {
//                 setState(() {
//                   _scratched = true;
//                 });
//
//                 // Add the scratched product to the cart
//                 if (_randomProduct != null) {
//                   BlocProvider.of<CartBloc>(context)
//                       .add(AddToCart(_randomProduct!));
//
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text("${_randomProduct!.title} added to cart!"),
//                     ),
//                   );
//                 }
//               },
//               child: Container(
//                 height: 500,
//                 width: 300,
//                 color: Colors.transparent,
//                 child: Column(
//                   children: [
//                     Center(
//                       child: _scratched
//                           ? Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//
//                           Image.network(
//                             _randomProduct!.thumbnail,
//                             height: 300,
//                             fit: BoxFit.fill,
//                           ),
//                           SizedBox(height: 10),
//                           Text(
//                             _randomProduct!.title,
//                             style: TextStyle(
//                               fontSize: 28,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             '\$${0.0}',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                         ],
//                       )
//                       :Text  (
//                         'Scratch Here!',
//                        )
//
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//           Text(
//             'Scratch Here!',
//
//           ),
//           SizedBox(height: 20),
//         ]
//
//         ,
//       ),
//     );
//   }
// }


import 'package:ecomapp/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:scratcher/scratcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Data/api_service.dart';
import '../block/cart_block.dart';
import '../constants/colors.dart';
import '../models/product_model.dart';
import 'cart_screen.dart';

class ScratchScreen extends StatefulWidget {
  @override
  _ScratchScreenState createState() => _ScratchScreenState();
}

class _ScratchScreenState extends State<ScratchScreen> {
  Product? _randomProduct;
  bool _scratched = false;

  @override
  void initState() {
    super.initState();
    _fetchRandomProduct();
  }

  // Function to fetch a random product from the API
  void _fetchRandomProduct() async {
    final apiService = ApiService();
    final products = await apiService.fetchProducts();
    setState(() {
      _randomProduct = (products..shuffle()).first; // Randomly select a product
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
          icon: CircleAvatar(
            radius: 20,
            backgroundColor: ColorConstant.red,
            child: Icon(Icons.home, color: Colors.white),
          ),
        ),
        centerTitle: true,
        title:
        Text  (
          'Gift card added',
          style: GoogleFonts.palanquinDark(
              color: ColorConstant.red,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              int cartItemCount = 0;
              if (state is CartLoaded) {
                cartItemCount = state.cart.length;
              }
              return CircleAvatar(
                radius: 20,
                backgroundColor: ColorConstant.red,
                child: Stack(
                  children: [
                    IconButton(
                      icon: Icon(Icons.shopping_cart, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CartScreen()),
                        );
                      },
                    ),
                    if (cartItemCount > 0)
                      Positioned(
                        right: 0.5,
                        top: 1,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.yellow,
                          child: Text(
                            '$cartItemCount',
                            style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: _randomProduct == null
          ? Center(child: CircularProgressIndicator())
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200, // Set the desired width
            height: 150,
            child: Lottie.asset("assets/animation/gift.json", fit: BoxFit.fill),
          ),
          SizedBox(height: 10),
          Center(
            child: Scratcher(
              color: ColorConstant.red,
              brushSize: 200,
              threshold: 40,
              onThreshold: () {
                setState(() {
                  _scratched = true;
                });

                // Create a new product with price 0
                if (_randomProduct != null) {
                  final scratchedProduct = Product(
                    // id: _randomProduct!.id,
                    title: _randomProduct!.title,
                    thumbnail: _randomProduct!.thumbnail,
                    price: 0.0, // Set price to 0
                  );

                  BlocProvider.of<CartBloc>(context).add(AddToCart(scratchedProduct));

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${_randomProduct!.title} added to cart with a price of \$0!"),
                    ),
                  );
                }
              },
              child: Container(
                height: 500,
                width: 300,
                color: Colors.transparent,
                child: Column(
                  children: [
                    Center(
                      child: _scratched
                          ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            _randomProduct!.thumbnail,
                            height: 300,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(height: 10),
                          Text(
                            _randomProduct!.title,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\$${0.0}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      )
                          : Text(
                        'Scratch Here!',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
