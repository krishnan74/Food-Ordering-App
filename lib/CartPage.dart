import 'package:epicure_intern_task/main.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import './Helpers/Fetchers.dart';
import './Models/FoodCartModel.dart';
import './Widgets/CartItemCard.dart';
import 'Helpers/Utils.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key, required this.supabase}) : super(key: key);

  final SupabaseClient supabase;

  @override
  State<CartPage> createState() => _CartPageState();
}


class _CartPageState extends State<CartPage> {
  late final SupabaseClient supabase;
  late Future<List<FoodCart>> cartItems = Future.value([]);
  double checkOutPrice = 0;

  @override
  void initState() {
    super.initState();
    supabase = widget.supabase;
    refreshCartItems();
  }

  Future<void> refreshCartItems() async {
    final items = await getCartItems(supabase);
    double totalPrice = 0;
    for (var item in items) {
      totalPrice += item.totalPrice;
    }
    setState(() {
      cartItems = Future.value(items);
      checkOutPrice = totalPrice;
    });
  }

  void removeCartItem(int cartItemId, SupabaseClient supabase) async {
    await removeFromCart(cartItemId, supabase);
    refreshCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: FutureBuilder<List<FoodCart>>(
        future: cartItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) => SizedBox(height: 20.0),
              itemBuilder: (context, index) {
                final cartItem = snapshot.data![index];
                return CartItemCard(
                  cartItem: cartItem,
                  onTap: () => removeCartItem(cartItem.id, supabase),
                );
              },
            );
          } else {
            return Center(child: Text('No Cart Items available'));
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: Colors.white,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Price: \$${checkOutPrice.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  checkOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage(title: 'Home Page')),
                  );
                },
                child: Text(
                  'Check out',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  backgroundColor: Color.fromRGBO(251, 127, 107, 1.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
