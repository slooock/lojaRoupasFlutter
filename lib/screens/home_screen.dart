import 'package:flutter/material.dart';
import 'package:flutter_app/tabs/home_tab.dart';
import 'package:flutter_app/tabs/oders_tab.dart';
import 'package:flutter_app/tabs/places_tab.dart';
import 'package:flutter_app/tabs/products_tab.dart';
import 'package:flutter_app/widgets/CustomDrawer.dart';
import 'package:flutter_app/widgets/cart_button.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          floatingActionButton: CartButton(),
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Lojas"),
            centerTitle: true,
          ),
          body: PlacesTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Meus Pedidos"),
            centerTitle: true,
          ),
          body: OrdersTab(),
          drawer: CustomDrawer(_pageController),
        )
      ],
    );
  }
}

