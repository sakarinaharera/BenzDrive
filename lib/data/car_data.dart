import 'package:flutter/material.dart';
import '../models/car_model.dart';

final List<CarModel> mercedesCars = [
  CarModel(
    id: '1',
    name: 'Mercedes-Benz C200',
    type: 'Sedan',
    price: 'Rp 950.000.000',
    image: 'assets/images/car_c200.png',
    description: 'Sedan mewah dengan teknologi terkini.',
    year: 2024,
    engine: '2.0L Turbo',
    availableColors: ['Hitam', 'Putih', 'Merah'],
    colorHexCodes: [Colors.black, Colors.white, Colors.red],
  ),
  CarModel(
    id: '2',
    name: 'Mercedes-Benz E300',
    type: 'Sedan',
    price: 'Rp 1.450.000.000',
    image: 'assets/images/car_e300.png',
    description: 'Sedan eksekutif dengan performa seimbang.',
    year: 2024,
    engine: '2.0L Turbo Hybrid',
    availableColors: ['Hitam', 'Biru', 'Silver'],
    colorHexCodes: [Colors.black, Colors.blue[900]!, Colors.grey],
  ),
  CarModel(
    id: '3',
    name: 'Mercedes-Benz S500',
    type: 'Luxury Sedan',
    price: 'Rp 3.200.000.000',
    image: 'assets/images/car_s500.png',
    description: 'Sedan flagship dengan kemewahan tanpa kompromi.',
    year: 2024,
    engine: '3.0L Inline-6 Turbo',
    availableColors: ['Hitam', 'Putih Mutiara', 'Emas'],
    colorHexCodes: [Colors.black, Colors.white, Colors.amber],
  ),
  CarModel(
    id: '4',
    name: 'Mercedes-Benz e63 AMG',
    type: 'SUV',
    price: 'Rp 5.800.000.000',
    image: 'assets/images/car_e63.png',
    description: 'SUV ikonik dengan performa AMG ganas.',
    year: 2024,
    engine: '4.0L V8 Biturbo',
    availableColors: ['Abu-abu AMG', 'Hitam Doff', 'Merah'],
    colorHexCodes: [Colors.blueGrey, Colors.black, Colors.red],
  ),
  CarModel(
    id: '5',
    name: 'Mercedes-Benz EQS 450',
    type: 'Electric',
    price: 'Rp 2.900.000.000',
    image: 'assets/images/car_eqs.png',
    description: 'Sedan listrik mewah dengan MBUX Hyperscreen.',
    year: 2024,
    engine: 'Electric Motor 333 HP',
    availableColors: ['Putih', 'Silver', 'Biru Elektrik'],
    colorHexCodes: [Colors.white, Colors.grey, Colors.lightBlue],
  ),
  CarModel(
    id: '6',
    name: 'Mercedes-Benz G-Class',
    type: 'SUV Electric',
    price: 'Rp 5.900.000.000',
    image: 'assets/images/car_gclass.png',
    description:
        'SUV legendaris kini hadir versi listrik dengan EQ Technology.',
    year: 2024,
    engine: 'Electric Motor 579 HP',
    availableColors: ['Hitam', 'Hijau Army', 'Silver'],
    colorHexCodes: [Colors.black, Colors.green[900]!, Colors.grey],
  ),
];

final List<Map<String, dynamic>> afterSalesServices = [
  {
    'icon': Icons.build_circle,
    'title': 'Servis Berkala',
    'desc': 'Perawatan rutin dengan teknisi bersertifikat resmi.'
  },
  {
    'icon': Icons.shield,
    'title': 'Garansi Resmi',
    'desc': 'Jaminan suku cadang asli dan garansi hingga 3 tahun.'
  },
  {
    'icon': Icons.handshake,
    'title': 'Asuransi All Risk',
    'desc': 'Perlindungan menyeluruh untuk kendaraan Anda.'
  },
];
