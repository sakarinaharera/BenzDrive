import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class BookingPage extends StatefulWidget {
  final String type;
  final String carName;
  const BookingPage({super.key, required this.type, required this.carName});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _carYearController = TextEditingController();
  final _carModelController = TextEditingController();
  DateTime? _selectedDate;

  void _submit() {
    if (_nameController.text.isEmpty || _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama dan No. HP wajib diisi'),
          backgroundColor: Colors.red, // Pakai warna merah standar
        ),
      );
      return;
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.backgroundWhite,
        title: Text('${widget.type} Berhasil',
            style: const TextStyle(
                color: AppColors.gunmetal, fontWeight: FontWeight.bold)),
        content: Text(
          'Permintaan ${widget.type} untuk ${widget.carName} telah dikirim. Tim kami akan menghubungi Anda.',
          style: const TextStyle(color: AppColors.textGrey),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK',
                style: TextStyle(
                    color: AppColors.moonstone, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isTradeIn = widget.type == 'Trade-In';

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite, // Background Putih
      appBar: AppBar(
        title: Text(widget.type,
            style: const TextStyle(color: AppColors.gunmetal)),
        backgroundColor: AppColors.backgroundWhite,
        foregroundColor: AppColors.gunmetal,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Formulir ${widget.type}',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.gunmetal)),
            const SizedBox(height: 8),
            Text('Mobil: ${widget.carName}',
                style: const TextStyle(color: AppColors.textGrey)),
            const SizedBox(height: 24),
            _buildTextField(_nameController, 'Nama Lengkap'),
            const SizedBox(height: 16),
            _buildTextField(_phoneController, 'Nomor HP/WhatsApp',
                isNumber: true),
            const SizedBox(height: 16),
            if (!isTradeIn) ...[
              InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 30)));
                  if (date != null) setState(() => _selectedDate = date);
                },
                child: InputDecorator(
                  decoration: _inputDecoration('Pilih Tanggal Test Drive'),
                  child: Text(
                      _selectedDate == null
                          ? 'Pilih Tanggal'
                          : _selectedDate.toString().split(' ')[0],
                      style: const TextStyle(color: AppColors.gunmetal)),
                ),
              ),
            ],
            if (isTradeIn) ...[
              const Text('Data Mobil Lama Anda:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.moonstone)),
              const SizedBox(height: 8),
              _buildTextField(
                  _carModelController, 'Merek & Model (Cth: Toyota Avanza)'),
              const SizedBox(height: 16),
              _buildTextField(_carYearController, 'Tahun Kendaraan',
                  isNumber: true),
            ],
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.moonstone, // Tombol Biru Pastel
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                onPressed: _submit,
                child: Text('KIRIM PENGAJUAN ${widget.type.toUpperCase()}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: const TextStyle(color: AppColors.gunmetal),
      decoration: _inputDecoration(label),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: AppColors.textGrey),
      filled: true,
      fillColor: AppColors.surfaceGrey, // Kotak abu-abu sangat muda
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.borderGrey)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.moonstone)),
    );
  }
}
