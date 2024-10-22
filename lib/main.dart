import "package:crypto_prices/data/home/repository/home_repository_impl.dart";
import "package:crypto_prices/presentation/home/bloc_way/cubit/view/home_view.dart";
import "package:crypto_prices/presentation/home/flutter_way/view/home_view.dart";
import "package:crypto_prices/presentation/home/getx/controller/home_view_controller.dart";
import "package:crypto_prices/presentation/home/getx/view/getx_home_view.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

void main() => runApp(const CubitApp());

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

class CubitApp extends StatelessWidget {
  const CubitApp({super.key});

  @override
  Widget build(final BuildContext context) => MaterialApp(
        title: "Crypto App",
        theme: ThemeData.dark(),
        home: const CubitHomeView(),
        initialRoute: "/",
      );
}

class GetxApp extends StatelessWidget {
  const GetxApp({super.key});

  @override
  Widget build(final BuildContext context) {
    Get.put(HomeViewController(repository: HomeRepositoryImpl()));
    return GetMaterialApp(
      title: "Crypto App",
      theme: ThemeData.dark(),
      home: const GetxHomeView(),
      initialRoute: "/",
    );
  }
}

/// Clean Architecture, Clean Code
/// Чистая архитектура
/// SOLID
