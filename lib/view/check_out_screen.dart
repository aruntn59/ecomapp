
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

import '../block/CheckoutBloc.dart';
import '../block/checkoutevent.dart';
import '../constants/colors.dart';
import '../models/Invoice Model.dart';


class CheckoutScreen extends StatelessWidget {
  final double total; // The total passed from CartScreen

  CheckoutScreen({required this.total
  });

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text  (
          'Checkout Addresss',
          style: GoogleFonts.palanquinDark(
              color: ColorConstant.red,
              fontSize: 30,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              height: 700,
              width: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: ColorConstant.red.withOpacity(0.9),
                    spreadRadius: 1,
                    blurRadius: 5,
                    // offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(26.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(labelText: 'Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(labelText: 'Address'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _pinCodeController,
                        decoration: InputDecoration(labelText: 'Pin Code'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your pin code';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _mobileController,
                        decoration: InputDecoration(labelText: 'Mobile Number'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your mobile number';
                          }
                          return null;
                        },
                      ),
        
                      SizedBox(height: 30),
                      Text(
                        'Total: \$${total.toStringAsFixed(2)}', // Display the total
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      BlocConsumer<CheckoutBloc, CheckoutState>(
                        listener: (context, state) {
                          if (state is CheckoutSuccess) {
                            _showInvoicePopup(context, state.invoice);
                          } else if (state is CheckoutFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(state.error),
                              backgroundColor:ColorConstant.red,
                            ));
                          }
                        },
                        builder: (context, state) {
                          if (state is CheckoutLoading) {
                            return CircularProgressIndicator();
                          }
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:ColorConstant.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<CheckoutBloc>().add(
                                  SubmitCheckout(
                                    name: _nameController.text,
                                    address: _addressController.text,
                                    pinCode: _pinCodeController.text,
                                    mobile: _mobileController.text, total: '$total.text',
                                    // total: total, // Passing the total value to the event
                                  ),
                                );
                              }
                            },
                            child: Text('plcace your order',style: TextStyle(fontWeight: FontWeight.w800,color: Colors.white,fontSize: 18),),
                          );
        
                        },
                      ),
                      Container(
                        width:1000, // Set the desired width
                        height: 280,
                        child: Lottie.asset("assets/animation/shipping.json", fit: BoxFit.fill),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showInvoicePopup(BuildContext context, Invoice invoice) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invoice Generated'),
          content: Text('Invoice for ${invoice.name} has been generated.'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();

                // Generate PDF with bill design
                final pdf = pw.Document();
                pdf.addPage(
                  pw.Page(
                    build: (pw.Context context) {
                      return _buildBillPdf(invoice);
                    },
                  ),
                );

                // Save PDF to a file
                final directory = await getApplicationDocumentsDirectory();
                final file = File('${directory.path}/invoice.pdf');
                await file.writeAsBytes(await pdf.save());

                // Convert file path to XFile and share it
                final xfile = XFile(file.path);
                Share.shareXFiles([xfile], text: 'Invoice for ${invoice.name}');
              },
              child: Text('Share Invoice'),
            ),
            TextButton(
              onPressed: () async {
                await Printing.layoutPdf(
                  onLayout: (PdfPageFormat format) async {
                    final pdf = pw.Document();
                    pdf.addPage(
                      pw.Page(
                        pageFormat: format,
                        build: (pw.Context context) {
                          return _buildBillPdf(invoice);
                        },
                      ),
                    );
                    return pdf.save();
                  },
                );
                Navigator.of(context).pop();
              },
              child: Text('Print'),
            ),
            TextButton(
              onPressed: () async {
                final pdf = pw.Document();
                pdf.addPage(
                  pw.Page(
                    build: (pw.Context context) {
                      return _buildBillPdf(invoice);
                    },
                  ),
                );

                final directory = await getApplicationDocumentsDirectory();
                final file = File('${directory.path}/invoice.pdf');
                await file.writeAsBytes(await pdf.save());

                Navigator.of(context).pop();
              },
              child: Text('Download'),
            ),
          ],
        );
      },
    );
  }

  pw.Widget _buildBillPdf(Invoice invoice) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'INVOICE',
          style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 20),
        pw.Text('Bill To:'),
        pw.Text(invoice.name, style: pw.TextStyle(fontSize: 16)),
        pw.Text(invoice.address, style: pw.TextStyle(fontSize: 16)),
        pw.Text('Pin: ${invoice.pinCode}', style: pw.TextStyle(fontSize: 16)),
        pw.SizedBox(height: 20),
        pw.Text('Date: ${DateTime.now()}'),
        pw.SizedBox(height: 20),
        pw.Divider(),
        pw.SizedBox(height: 10),

        // Table for products
        pw.Table.fromTextArray(
          headers: ['Product', 'Quantity', 'Price'],
          data: invoice.items.map((item) {
            return [item.productName, item.quantity.toString(), '\$${item.price}'];
          }).toList(),
        ),
        pw.SizedBox(height: 20),

        // Total amount section
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Total Amount:', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
            pw.Text('\$${invoice.totalAmount}', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Divider(),
        pw.Text('Thank you for your purchase!'),
      ],
    );
  }
}
