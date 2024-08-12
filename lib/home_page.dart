import 'package:flutter/material.dart';
import 'product_detail_page.dart';

class Food {
  final String name;
  final String imageUrl;
  final double price;

  Food({required this.name, required this.imageUrl, required this.price});

  get id => null;
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Food> foodList = [
      Food(
          name: 'Croissant',
          imageUrl:
              'https://e00-telva.uecdn.es/assets/multimedia/imagenes/2020/10/05/16018972663315.jpg',
          price: 2.99),
      Food(
          name: 'Donut',
          imageUrl:
              'https://tse3.mm.bing.net/th?id=OIP.3J3sElUXatuGQ3oWLQgSYgHaEK&pid=Api&P=0&h=180',
          price: 1.99),
      Food(
          name: 'Sourdough',
          imageUrl:
              'https://i1.wp.com/homesteadandchill.com/wp-content/uploads/2019/02/simple-sourdough-bread-recipe-homestead-feature.jpeg?resize=1140,1069&ssl=1g',
          price: 3.49),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Roti'),
        backgroundColor: Colors.deepPurple,
      ),
      body: _RotiListScreen(foodList: foodList),
    );
  }
}

// Membuat class _RotiListScreen untuk menampilkan daftar roti
class _RotiListScreen extends StatelessWidget {
  final List<Food> foodList;

  const _RotiListScreen({required this.foodList});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: foodList.map((food) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    food.imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  food.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Text(
                  'Rp${(food.price * 15000).toStringAsFixed(0)}',
                  style: TextStyle(
                    color: Colors.green[700],
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(food: food),
                    ),
                  );
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
