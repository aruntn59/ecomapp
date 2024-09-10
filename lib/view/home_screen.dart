// // In product_list_screen.dart
//
// import 'dart:async';
// import 'dart:math';
//
// import 'package:ecomapp/models/product_model.dart';
// import 'package:ecomapp/view/product_details.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:google_fonts/google_fonts.dart';
// // import 'package:google_fonts/google_fonts.dart';
// import 'package:scratcher/widgets.dart';
// import '../Data/user_manager.dart';
// import '../block/cart_block.dart';
// import '../block/product_block.dart';
// import '../constants/colors.dart';
// import 'cart_screen.dart';
//
// class HomeScreen extends StatefulWidget {
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final scratchKey = GlobalKey<ScratcherState>();
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar:AppBar
//         (leading: IconButton(onPressed: () {
//         Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
//
//       },
//           icon: CircleAvatar(
//             radius: 20,
//             backgroundColor: ColorConstant.red,
//             child: Icon(Icons.home,color: Colors.white,),)),centerTitle: true,
//         title:  Text  (
//           'Shope',
//           style: GoogleFonts.palanquinDark(
//               color: ColorConstant.red,
//               fontSize: 40,
//               fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           BlocBuilder<CartBloc, CartState>(
//             builder: (context, state) {
//
//               int cartItemCount = 0;
//               if (state is CartLoaded) {
//                 cartItemCount = state.cart.length;
//               }
//               return CircleAvatar(
//                 radius: 20,
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
//
//
//       body: BlocBuilder<ProductBloc, ProductState>(
//         builder: (context, state) {
//           if (state is ProductLoading) {
//             return Center(child: CircularProgressIndicator());
//           } else if (state is ProductLoaded) {
//
//
//
//            // start(state.products);
//
//
//             return GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 childAspectRatio: 1/ 3,
//               ),
//               itemCount: state.products.length,
//               itemBuilder: (context, index) {
//                 final product = state.products[index];
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ProductDetailsScreen(product: product),
//                       ),
//                     );
//                   },
//                   child: Card(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: Image.network(
//                             product.thumbnail,
//                             fit: BoxFit.cover,
//                             width: double.infinity,
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             product.title,
//                             style: TextStyle(fontSize: 16),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                           child: Text(
//                             '\$${product.price.toStringAsFixed(2)}',
//                             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         SizedBox(height: 8),
//                         Center(
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                                 backgroundColor:ColorConstant.red,
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10)
//                                 )
//                             ),
//                             onPressed: () {
//                               context.read<CartBloc>().add(AddToCart(product));
//
//                               // Show a SnackBar when the item is added to the cart
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text('${product.title} added to cart!'),
//                                   duration: Duration(seconds: 2),
//                                 ),
//                               );
//                             },
//                             child: Text('Add to Cart',style: TextStyle(fontWeight: FontWeight.w800,color: Colors.white,fontSize: 10),),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//
//
//
//
//           } else if (state is ProductError) {
//             return Center(child: Text('Failed to load products: ${state.error}'));
//           } else {
//             return Center(child: Text('No products available.'));
//           }
//         },
//       ),
//     );
//   }
// }
//

import 'dart:async';
import 'dart:math';

import 'package:ecomapp/models/product_model.dart';
import 'package:ecomapp/view/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratcher/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../Data/user_manager.dart';
import '../block/cart_block.dart';
import '../block/product_block.dart';
import '../constants/colors.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scratchKey = GlobalKey<ScratcherState>();

  // List of banner images for the carousel slider
  final List<String> bannerImages = [
    'assets/images/b1.png',
    'assets/images/b2.png',
    'assets/images/b3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          },
          icon: CircleAvatar(
            radius: 20,
            backgroundColor: ColorConstant.red,
            child: Icon(Icons.home, color: Colors.white),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Shope',
          style: GoogleFonts.palanquinDark(
            color: ColorConstant.red,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
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
                          MaterialPageRoute(
                            builder: (context) => CartScreen(),
                          ),
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
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
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
      body: Column(
        children: [
          SizedBox(height: 10),

          // Carousel Slider
          CarouselSlider(
            options: CarouselOptions(
              height: 250.0,
              autoPlay: true,
              enlargeCenterPage: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
            ),
            items: bannerImages.map((image) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),

          SizedBox(height: 10),

          // Product Grid
          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ProductLoaded) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1 / 3,
                    ),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(product: product),
                            ),
                          );
                        },
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Image.network(
                                  product.thumbnail,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  product.title,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  '\$${product.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorConstant.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    context.read<CartBloc>().add(AddToCart(product));

                                    // Show a SnackBar when the item is added to the cart
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('${product.title} added to cart!'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Add to Cart',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is ProductError) {
                  return Center(child: Text('Failed to load products: ${state.error}'));
                } else {
                  return Center(child: Text('No products available.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
