import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../models/car_model.dart';
import '../chat/chat_page.dart';
import 'booking_page.dart';
import '../theme/app_colors.dart';

class DetailPage extends StatefulWidget {
  final CarModel car;
  const DetailPage({super.key, required this.car});
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int selectedColorIndex = 0;

  void _showCreditSimulation(BuildContext context) {
    String priceStr = widget.car.price.replaceAll(RegExp(r'[^0-9]'), '');
    double price = double.parse(priceStr);
    double dp = price * 0.3;
    double loan = price - dp;
    double tenor = 36;
    double totalLoan = loan + (loan * 0.05 * (tenor / 12));
    double monthly = totalLoan / tenor;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.backgroundWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Simulasi Kredit',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: AppColors.gunmetal)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Harga OTR: ${widget.car.price}',
                style: const TextStyle(color: AppColors.textGrey)),
            const SizedBox(height: 8),
            Text('DP 30%: Rp ${dp.toStringAsFixed(0)}',
                style: const TextStyle(color: AppColors.textGrey)),
            const SizedBox(height: 8),
            const Text('Tenor: 36 Bulan',
                style: TextStyle(color: AppColors.textGrey)),
            const Divider(color: AppColors.borderGrey),
            Text('Estimasi Cicilan: Rp ${monthly.toStringAsFixed(0)}/bln',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.moonstone,
                    fontSize: 16)),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup',
                  style: TextStyle(color: AppColors.moonstone)))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.gunmetal),
        title: Text(widget.car.name,
            style: const TextStyle(
                color: AppColors.gunmetal,
                fontWeight: FontWeight.bold,
                fontSize: 18)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 260,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.gunmetal.withValues(alpha: 0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 8))
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(widget.car.image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                        color: AppColors.surfaceGrey,
                        child: const Icon(Icons.directions_car,
                            size: 80, color: AppColors.textGrey))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.car.name,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.gunmetal)),
                  const SizedBox(height: 8),
                  Text(widget.car.price,
                      style: const TextStyle(
                          fontSize: 20,
                          color: AppColors.moonstone,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 24),
                  const Text('Pilih Warna:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.gunmetal)),
                  const SizedBox(height: 12),
                  Row(
                    children:
                        List.generate(widget.car.colorHexCodes.length, (index) {
                      return GestureDetector(
                        onTap: () => setState(() => selectedColorIndex = index),
                        child: Container(
                          margin: const EdgeInsets.only(right: 16),
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: selectedColorIndex == index
                                    ? AppColors.moonstone
                                    : Colors.transparent,
                                width: 2),
                          ),
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: widget.car.colorHexCodes[index],
                            child: selectedColorIndex == index
                                ? const Icon(Icons.check,
                                    size: 18, color: Colors.white)
                                : null,
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 24),
                  const Divider(color: AppColors.borderGrey),
                  _buildInfoRow('Tipe', widget.car.type),
                  _buildInfoRow('Tahun', widget.car.year.toString()),
                  _buildInfoRow('Mesin', widget.car.engine),
                  _buildInfoRow(
                      'Warna', widget.car.availableColors[selectedColorIndex]),
                  const SizedBox(height: 24),
                  const Text('Deskripsi',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.gunmetal)),
                  const SizedBox(height: 8),
                  Text(widget.car.description,
                      style: const TextStyle(
                          color: AppColors.textGrey, height: 1.5)),
                  const SizedBox(height: 30),

                  // Tombol Test Drive & Trade-In
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.car_rental, size: 20),
                          label: const Text('Test Drive'),
                          style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.gunmetal,
                              side:
                                  const BorderSide(color: AppColors.borderGrey),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BookingPage(
                                      type: 'Test Drive',
                                      carName: widget.car.name))),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(CupertinoIcons.arrow_2_circlepath,
                              size: 20),
                          label: const Text('Trade-In'),
                          style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.gunmetal,
                              side:
                                  const BorderSide(color: AppColors.borderGrey),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BookingPage(
                                      type: 'Trade-In',
                                      carName: widget.car.name))),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Tombol Kredit
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.champagne,
                          foregroundColor: AppColors.gunmetal,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      onPressed: () => _showCreditSimulation(context),
                      child: const Text('Simulasi Kredit',
                          style: TextStyle(
                              letterSpacing: 1, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Tombol WA
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF25D366),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      icon: const Icon(CupertinoIcons.chat_bubble_text_fill),
                      label: const Text('Hubungi Seller via WhatsApp',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  ChatPage(carName: widget.car.name))),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
              width: 100,
              child: Text(label,
                  style: const TextStyle(
                      color: AppColors.textGrey, fontSize: 14))),
          Text(': $value',
              style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.gunmetal,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
