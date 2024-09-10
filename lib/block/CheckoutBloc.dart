import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../models/Invoice Model.dart';
// import '../models/InvoiceModel.dart'; // Ensure the correct model is imported
import 'checkoutevent.dart'; // Import your event definitions

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutInitial()) {
    on<SubmitCheckout>(_onSubmitCheckout);
  }

  Future<void> _onSubmitCheckout(SubmitCheckout event, Emitter<CheckoutState> emit) async {
    emit(CheckoutLoading());

    try {
      // Create invoice data (this could be based on cart contents)
      final invoice = Invoice(
        name: event.name,
        address: event.address,
        pinCode: event.pinCode,
        // mobile: event.mobile,
        totalAmount: 200.0, // Example total amount
        items: [ // Include items in the invoice if needed
          InvoiceItem(productName: 'Product 1', quantity: 2, price: 50.0),
          InvoiceItem(productName: 'Product 2', quantity: 1, price: 100.0),
        ],
      );

      // Generate PDF
      final pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Center(
            child: pw.Text(
              'Invoice for ${invoice.name}\nTotal: \$${invoice.totalAmount}',
              style: pw.TextStyle(fontSize: 18),
            ),
          ),
        ),
      );

      // Save PDF to local storage
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/invoice.pdf');
      await file.writeAsBytes(await pdf.save());

      emit(CheckoutSuccess(invoice));
    } catch (e) {
      emit(CheckoutFailure("Failed to generate invoice: ${e.toString()}"));
    }
  }
}
