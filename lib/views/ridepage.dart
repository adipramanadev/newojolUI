import 'package:flutter/material.dart';

class RidePage extends StatefulWidget {
  const RidePage({super.key});

  @override
  State<RidePage> createState() => _RidePageState();
}

class _RidePageState extends State<RidePage> {
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  @override
  void dispose() {
    _pickupController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const brandColor = Color(0xFFFF6600);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesan Ride'),
        backgroundColor: brandColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Lokasi penjemputan
            TextField(
              controller: _pickupController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade100,
                prefixIcon: const Icon(Icons.my_location),
                hintText: 'Lokasi penjemputan',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Lokasi tujuan
            TextField(
              controller: _destinationController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade100,
                prefixIcon: const Icon(Icons.place),
                hintText: 'Lokasi tujuan',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Simulasi info estimasi (dummy)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.motorcycle, color: Colors.orange),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Estimasi biaya: Rp 12.000 - Rp 15.000\nWaktu tempuh: 15 menit',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),

            // Tombol pesan
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: brandColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  // TODO: Handle pemesanan ride
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ride dipesan!')),
                  );
                },
                icon: const Icon(Icons.check),
                label: const Text('Pesan Sekarang'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
