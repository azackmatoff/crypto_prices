import "package:crypto_prices/presentation/home/view/home_view.dart";
import "package:flutter/material.dart";

void main() => runApp(const MyApp());

BuildContext? testContext;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) => MaterialApp(
        title: "Crypto App",
        theme: ThemeData.dark(),
        home: const HomeView(),
        initialRoute: "/",
      );
}
