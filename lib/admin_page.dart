import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<dynamic> transactions = [];

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  Future<void> _fetchTransactions() async {
    final response = await http.get(
        Uri.parse('http://192.168.18.4/sertifikasi_jmp/get_transactions.php'));

    if (response.statusCode == 200) {
      setState(() {
        transactions = json.decode(response.body);
      });
    } else {
      // Handle errors
      print('Failed to load transactions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return ListTile(
            title: Text('Name: ${transaction['name']}'),
            subtitle: Text(
                'Address: ${transaction['address']}\nPhone: ${transaction['phone']}\nLat: ${transaction['latitude']}, Lon: ${transaction['longitude']}'
                '\nFood ID: ${transaction['food_id']} - Quantity: ${transaction['quantity']} - Total Price: ${transaction['total_price']}'),
            trailing: Text('Date: ${transaction['created_at']}'),
          );
        },
      ),
    );
  }
}
