// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:lottie/lottie.dart';
// import '../block/CheckoutBloc.dart';
// import '../block/cart_block.dart';
// import 'check_out_screen.dart';
//
// class CartScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart'),
//       ),
//       body: BlocBuilder<CartBloc, CartState>(
//         builder: (context, state) {
//           if (state is CartLoading) {
//             return Center(child: CircularProgressIndicator());
//           } else if (state is CartLoaded) {
//             final cart = state.cart;
//             return Column(
//               children: [
//
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: cart.length,
//                     itemBuilder: (context, index) {
//                       final product = cart[index];
//                       return ListTile(
//                         leading: Image.network(
//                           product.thumbnail, // Display the product image
//                           width: 50,
//                           height: 50,
//                           fit: BoxFit.cover,
//                         ),
//                         title: Text(product.title),
//                         subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
//                       );
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     'Total: \$${cart.fold(0.0, (total, product) => total + product.price).toStringAsFixed(2)}',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//
//                 Container(width: 400, // Set the desired width
//                   height: 300,
//                   child: Lottie.asset("assets/animation/cart.json",fit: BoxFit.fill),
//                 ),
//               ],
//             );
//           }
//           // else if (error) {
//           //   return Center(child: Text('Failed to load cart: ${state.error}'));
//           // }
//           else {
//             return Center(child: Text('No items in the cart.'));
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => BlocProvider(
//                 create: (context) => CheckoutBloc(),
//                 child: CheckoutScreen(),
//               ),
//             ),
//           );
//
//         },
//         child: Icon(Icons.shopping_cart),
//         tooltip: 'Go to Checkout',
//       ),
//     );
//   }
// }
//
//
//
//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
// import '../bloc/CheckoutBloc.dart';
// import '../bloc/cart_bloc.dart';
import '../block/CheckoutBloc.dart';
import '../block/cart_block.dart';
import '../constants/colors.dart';
import 'check_out_screen.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text  (
          'Cart',
          style: GoogleFonts.palanquinDark(
              color: ColorConstant.red,
              fontSize: 30,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            final cart = state.cart;
            final total = cart.fold(0.0, (total, product) => total + product.price); // Calculate total

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final product = cart[index];
                      return ListTile(
                        leading: Image.network(
                          product.thumbnail, // Display the product image
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(product.title),
                        subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Total: \$${total.toStringAsFixed(2)}', // Display total
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: 400, // Set the desired width
                  height: 300,
                  child: Lottie.asset("assets/animation/cart.json", fit: BoxFit.fill),
                ),
              ],
            );
          } else {
            return Center(child: Text('No items in the cart.'));
          }
        },
      ),
      floatingActionButton: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            final total = state.cart.fold(0.0, (total, product) => total + product.price); // Calculate total for checkout
            return
              FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => CheckoutBloc(),
                        child: CheckoutScreen(total: total), // Pass total to CheckoutScreen
                      ),
                    ),
                  );
                },
                backgroundColor: ColorConstant.red, // Set the button color to red
                icon: Icon(Icons.local_shipping,color: Colors.white), // Optional: Change the icon to a shipping icon
                label: Text(
                  'Shipping',
                  style: TextStyle(color: Colors.white), // Set the label text color to white
                ),
                tooltip: 'Shipping',
              );

          } else {
            return SizedBox.shrink(); // Hide button if cart is not loaded
          }
        },
      ),
    );
  }
}
