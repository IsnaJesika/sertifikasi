import 'package:flutter/material.dart';
import 'home_page.dart';

class BookmarkPage extends StatelessWidget {
  final String name;
  final String address;
  final Food food;

  const BookmarkPage({
    required this.name,
    required this.address,
    required this.food,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                food.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(food.name),
            subtitle: Text(
              'Harga: Rp${(food.price * 15000).toStringAsFixed(0)}\nNama: $name\nAlamat: $address',
            ),
          ),
        ],
      ),
    );
  }
}
