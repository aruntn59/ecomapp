class Invoice {
  final String name;
  final String address;
  final String pinCode;
  final List<InvoiceItem> items; // List of items in the invoice
  final double totalAmount;

  Invoice({
    required this.name,
    required this.address,
    required this.pinCode,
    required this.items,
    required this.totalAmount,
  });
}

class InvoiceItem {
  final String productName;
  final int quantity;
  final double price;

  InvoiceItem({
    required this.productName,
    required this.quantity,
    required this.price,
  });
}
