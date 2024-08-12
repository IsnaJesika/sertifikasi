import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart'; // Import geolocator
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'home_page.dart';

class PaymentPage extends StatefulWidget {
  final Food food;
  final int quantity;

  const PaymentPage({required this.food, required this.quantity, super.key});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  Future<void> _getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          // ignore: deprecated_member_use
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _latitudeController.text = position.latitude.toString();
        _longitudeController.text = position.longitude.toString();
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MapScreen(
              location: LatLng(position.latitude, position.longitude)),
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to get GPS location: $e'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _submitTransaction() async {
    // Pastikan alamat IP ini adalah alamat IP lokal dari komputer yang menjalankan server backend
    final url = 'http://192.168.18.4/sertifikasi_jmp/submit_transaction.php';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'food_id': widget.food.id,
          'quantity': widget.quantity,
          'total_price':
              widget.food.price * widget.quantity * 15000, // Harga dalam rupiah
          'name': _nameController.text,
          'address': _addressController.text,
          'phone': _phoneController.text,
          'latitude': _latitudeController.text,
          'longitude': _longitudeController.text,
        }),
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['success']) {
          // Jika transaksi berhasil, kembali ke halaman Home
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else {
          _showErrorDialog('Failed to save transaction: ${result['error']}');
        }
      } else {
        _showErrorDialog('Failed to connect to server.');
      }
    } catch (e) {
      _showErrorDialog('An error occurred: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  String formatRupiah(double amount) {
    final formatter = NumberFormat.simpleCurrency(locale: 'id_ID', name: 'Rp');
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Alamat'),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'No Telepon'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Detail Pembelian:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _getUserLocation,
              child: Text('Ambil Lokasi Sekarang'),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: Image.network(
                widget.food.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(widget.food.name),
              subtitle: Text(
                'Harga: ${formatRupiah(widget.food.price * 15000)}\nJumlah: ${widget.quantity}',
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty &&
                    _addressController.text.isNotEmpty &&
                    _phoneController.text.isNotEmpty &&
                    _latitudeController.text.isNotEmpty &&
                    _longitudeController.text.isNotEmpty) {
                  _submitTransaction();
                } else {
                  _showErrorDialog('Semua field harus diisi');
                }
              },
              child: const Text('Simpan Transaksi'),
            ),
          ],
        ),
      ),
    );
  }
}

class MapScreen extends StatelessWidget {
  final LatLng location;

  const MapScreen({required this.location, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lokasi Acak'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: location,
          zoom: 12,
        ),
        markers: {
          Marker(
            markerId: MarkerId('random_location'),
            position: location,
          ),
        },
      ),
    );
  }
}
