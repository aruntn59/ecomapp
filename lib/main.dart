import 'package:ecomapp/view/home_screen.dart';
import 'package:ecomapp/view/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'Data/api_service.dart';
import 'block/cart_block.dart'; // Import CartBloc here
import 'block/product_block.dart'; // Import ProductBloc here


// Ensure you're using correct Bloc types and events
Future<void> main() async {
  final apiService = ApiService();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDuX0lcVH6XjSYpXA0jKoY23obGgJjfR1Q",
          appId: "1:881417700027:android:813f34dd7dbd5d9245df9e",
          messagingSenderId: "881417700027",
          projectId: "whitematrix-2a97f")
  );
  runApp(MyApp(apiService: apiService));
}

class MyApp extends StatelessWidget {
  final ApiService apiService;

  MyApp({required this.apiService});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (_) => ProductBloc(apiService)..add(FetchProducts()),
        ),
        BlocProvider<CartBloc>(
          create: (_) => CartBloc()..add(FetchCart()), // Ensure CartBloc is created correctly
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splashscreen(),
        navigatorObservers: [FlutterSmartDialog.observer],
        // here
        builder: FlutterSmartDialog.init(),
      ),
    );
  }
}
