// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// // import 'package:path_provider/path_provider.dart';
// import 'package:open_file/open_file.dart';
// import 'package:provider/provider.dart';
//
// import '../Data/cart_provider.dart';
// // import '../providers/cart_provider.dart';
//
// class CheckoutScreen extends StatelessWidget {
//   static const routeName = '/checkout';
//
//   Future<void> _generateReceipt(BuildContext context) async {
//     final cart = Provider.of<CartProvider>(context, listen: false).cart;
//
//     final pdf = pw.Document();
//
//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) => pw.Column(
//           children: [
//             pw.Text('Receipt'),
//             pw.ListView.builder(
//               itemCount: cart.items.length,
//               itemBuilder: (context, index) {
//                 return pw.Text(
//                     '${cart.items[index].name} x ${cart.items[index].quantity} = \$${cart.items[index].price * cart.items[index].quantity}');
//               },
//             ),
//             pw.Text('Total: \$${cart.totalAmount}'),
//             pw.Text('Transaction ID: XYZ123'),
//             pw.Text('Date of Purchase: ${DateTime.now().toString()}'),
//           ],
//         ),
//       ),
//     );
//
//     final output = await getTemporaryDirectory();
//     final file = File("${output.path}/receipt.pdf");
//
//     await file.writeAsBytes(await pdf.save());
//     OpenFile.open(file.path);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Checkout'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => _generateReceipt(context),
//           child: Text('Generate Receipt'),
//         ),
//       ),
//     );
//   }
// }
