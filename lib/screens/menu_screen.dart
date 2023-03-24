import 'dart:math';

import 'package:eatnbeat/providers/order_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../providers/menu_repository.dart';
import '../providers/table_operations.dart';
import '../usermodels/category.dart';
import '../usermodels/menu.dart';
import '../usermodels/orders_summary.dart';
import '../usermodels/product.dart';

class Menu extends StatefulWidget {
  final User user;

  const Menu({super.key, required this.user});

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late User _currentUser;
  late String _userUID;
  late String userName;
  final List<String> items = List<String>.generate(3, (i) => '$i');
  CategoriesRepository categoryRepository = CategoriesRepository();
  TableOperations tableOperations = TableOperations();
  List<Menus> selectedMenus = [];
  List<Product> selectedProducts = [];// list to keep track of selected menus
  OrderMenu orderMenu = OrderMenu();


  @override
  void initState() {
    _currentUser = widget.user;
    _userUID = _currentUser.uid;
    userName = widget.user.displayName!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.lightGreen[50],
          shadowColor: Colors.transparent,
          title: Text(
            'Menus',
            style: TextStyle(color: Colors.green[600]),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(150),
            child: Container(
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.fromLTRB(15, 0, 5, 15),
              child: ListTile(
                title: Text(
                  'Welcome $userName !',
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 20,
                      letterSpacing: 0.1,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<Categories>>(
              future: categoryRepository.getCategories(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Categories> categories = snapshot.data!;
                  return Column(
                    children: categories.map((category) {
                      return Column(
                        children: [
                          Center(
                            child: Text(
                              '${category.category_id} - ${category.category_name}',
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 20,
                                letterSpacing: 0.1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (category.iscategory_product == 1)
                            FutureBuilder<List<Product>>(
                              future: categoryRepository
                                  .getProductsByCategory(category.category_id),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<Product> products = snapshot.data!;
                                  return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: products.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (selectedProducts
                                                .contains(products[index])) {
                                              selectedProducts.remove(products[index]);
                                            } else {
                                              selectedProducts.add(products[index]);
                                            }
                                          });
                                        },
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor:
                                            const Color(0xff764abc),
                                            child: Text(
                                                products[index].product_id.toString()),
                                          ),
                                          title: Text(products[index].name),
                                          subtitle: Text(
                                              'Price: \$${products[index].price.toStringAsFixed(2)}'),
                                          trailing: selectedProducts
                                              .contains(products[index])
                                              ? Icon(Icons.check_box)
                                              : Icon(
                                              Icons.check_box_outline_blank),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          if (category.iscategory_product == 0)
                            FutureBuilder<List<Menus>>(
                              future: categoryRepository
                                  .getMenusByCategoryID(category.category_id),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<Menus> menus = snapshot.data!;
                                  return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: menus.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (selectedMenus
                                                .contains(menus[index])) {
                                              selectedMenus
                                                  .remove(menus[index]);
                                            } else {
                                              selectedMenus.add(menus[index]);
                                            }
                                          });
                                        },
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor:
                                                const Color(0xff764abc),
                                            child: Text(menus[index]
                                                .menu_id
                                                .toString()),
                                          ),
                                          title: Text(menus[index].name),
                                          subtitle: Text(
                                              'Price: \$${menus[index].price.toStringAsFixed(2)}'),
                                          trailing: selectedMenus
                                                  .contains(menus[index])
                                              ? Icon(Icons.check_box)
                                              : Icon(Icons
                                                  .check_box_outline_blank),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                        ],
                      );
                    }).toList(),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            SizedBox(height: 20),
            Text('Order Summary:', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: selectedMenus.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    setState(() {
                      selectedMenus.removeAt(index);
                    });
                  },
                  background: Container(
                    color: Colors.red,
                    child: Icon(Icons.delete, color: Colors.white),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                  ),
                  child: ListTile(
                    title: Text(selectedMenus[index].name),
                    subtitle: Text(
                        'Price: \$${selectedMenus[index].price.toStringAsFixed(2)}'),
                  ),
                );
              },
            ),
            ElevatedButton(
              onPressed: () async {
                final generatedId = await orderMenu.saveOrderSummary(
                    context,
                    OrderSummary(
                      timeIn: DateTime.now(),
                      date: DateTime.now(),
                    ));

                // Get available tables
                final availableTables =
                    await tableOperations.getAvailableTables();

                // Show the table selection dialog
                final selectedTable = await showDialog<int>(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      title: const Text('Select a table'),
                      children: availableTables.map((table) {
                        return SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, table['table_id']);
                          },
                          child: Text('Table ${table['table_id']}'),
                        );
                      }).toList(),
                    );
                  },
                );

                if (selectedTable != null) {
                  // Place orders for the selected menus
                  for (final menu in selectedMenus) {
                    orderMenu.placeOrderMenus(generatedId, menu.menu_id);
                  }

                  // Update the table record to mark it as occupied
                  await tableOperations.updateTable(
                      selectedTable, generatedId, false);

                  // Clear the selectedMenus list after placing the orders
                  setState(() {
                    selectedMenus.clear();
                  });
                }
              },
              child: Text('Order'),
            ),
          ],
        ),
      ),
    );
  }
}
