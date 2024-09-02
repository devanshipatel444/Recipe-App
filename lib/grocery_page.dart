import 'package:flutter/material.dart';
import 'package:recipe_application/models/grocery_item.dart'; // Adjust the path according to your project structure
import 'login_page.dart';

class GroceryPage extends StatefulWidget {
  const GroceryPage({super.key});

  @override
  _GroceryPageState createState() => _GroceryPageState();
}

class _GroceryPageState extends State<GroceryPage> {
  bool _showAppBar = true;
  bool _showNavBar = true;
//change
  List<GroceryItem> groceryItems = []; // List to hold grocery items
  final TextEditingController itemController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _addGroceryItem() {
    String itemName = itemController.text.trim();
    String quantityText = quantityController.text.trim();
    int quantity = 0;
    if (quantityText.isNotEmpty) {
      quantity = int.parse(quantityController.text.trim());
    }

    if ((itemName.isEmpty || quantityText.isEmpty) || quantity == 0) {
      const snackBar = SnackBar(
        content:
            Text('Please enter a valid item name or quantity greater than 0.'),
        backgroundColor: Color.fromARGB(255, 230, 135, 135),
      );
      // Show a warning message
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    setState(() {
      groceryItems.add(GroceryItem(itemName: itemName, quantity: quantity));
      itemController.clear();
      quantityController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget? bottomNavBar;
    if (_showNavBar == false) {
      bottomNavBar = null;
    }
    return Scaffold(
      /*     appBar: _showAppBar
          ? AppBar(title: Text('Groceries'))
          : AppBar(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0), */
      bottomNavigationBar: bottomNavBar,
/*      
      bottomNavigationBar: _showNavBar
          ? null
          : BottomNavigationBar(
              items: bottomNavBarItems,
            ), */
      backgroundColor: Colors.lightGreen[100],
      body: GestureDetector(
        onTap: () {
          setState(() {
            _showAppBar = false;
            _showNavBar = false;
          });
        },
        child: Stack(children: [
          Positioned(
              top: 20,
              right: 20,
              child: IconButton(
                  icon: const Icon(Icons.account_circle,
                      size: 30, color: Color.fromARGB(255, 219, 154, 214)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  })),
          Positioned(
            top: 60,
            left: 20,
            right: 20,
            child: Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: const Center(
                child: Text(
                  'Grocery List',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              top: 130,
              left: 20,
              right: 20,
              bottom: 100,
              child: Container(
                  padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: groceryItems.isEmpty
                      ? const Center(child: Text('No items yet'))
                      : ListView.builder(
                          itemCount: groceryItems.length,
                          itemBuilder: (context, index) {
                            GroceryItem item = groceryItems[index];
                            return ListTile(
                              title:
                                  Text('${item.itemName} (${item.quantity})'),
                            );
                          }))),
          Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Row(children: [
                // children ---> flex in b/w2
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: TextField(
                          controller: quantityController,
                          keyboardType: TextInputType
                              .number, // Ensure only numbers are input
                          decoration: const InputDecoration(
                            hintText: "#",
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 8.0),
                          ),
                          style: const TextStyle(fontSize: 20)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 5,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Center(
                        child: TextField(
                          controller: itemController,
                          decoration: const InputDecoration(
                              hintText: 'Item', border: InputBorder.none),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                      onPressed: () {
                        _addGroceryItem();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 219, 154, 214),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text('ADD')),
                ),
              ]))
        ]),
/*
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 130.0, top: 30),
            child: Container(
              width: 300.0,
              height: 400.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
        ), */
      ),
    );
  }
}
