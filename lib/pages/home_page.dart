import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../data/car_data.dart';
import '../widgets/car_card.dart';
import '../models/car_model.dart';
import 'detail_page.dart';
import 'profile_page.dart';
import '../chat/chat_page.dart';
import '../theme/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'Semua';
  String searchQuery = '';
  final List<String> categories = ['Semua', 'Sedan', 'SUV', 'Electric'];

  @override
  Widget build(BuildContext context) {
    List<CarModel> filteredCars = mercedesCars.where((car) {
      final matchCategory =
          selectedCategory == 'Semua' || car.type == selectedCategory;
      final matchSearch =
          car.name.toLowerCase().contains(searchQuery.toLowerCase());
      return matchCategory && matchSearch;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite, // Background Putih
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        title: const Text('Mercedes-Benz',
            style: TextStyle(
                color: AppColors.gunmetal, // Teks Gelap
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5)),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.chat_bubble,
                color: AppColors.gunmetal),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const ChatPage())),
          ),
          IconButton(
            icon: const Icon(CupertinoIcons.person_crop_circle,
                color: AppColors.gunmetal, size: 28),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const ProfilePage())),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Banner
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: AssetImage('assets/images/car_s500.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black38,
                    BlendMode.darken), // Overlay sedikit gelap biar teks kebaca
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.gunmetal
                      .withValues(alpha: 0.15), // Shadow elegan
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('The Best or Nothing.',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0)),
                  SizedBox(height: 8),
                  Text('Dapatkan penawaran spesial bulan ini.',
                      style: TextStyle(
                          color: AppColors.champagne,
                          fontSize: 14,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Search Bar
          TextField(
            style: const TextStyle(color: AppColors.gunmetal),
            decoration: InputDecoration(
              hintText: 'Cari mobil impianmu...',
              hintStyle:
                  const TextStyle(color: AppColors.textGrey, fontSize: 14),
              prefixIcon:
                  const Icon(CupertinoIcons.search, color: AppColors.textGrey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: AppColors.surfaceGrey, // Abu-abu sangat muda
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onChanged: (value) => setState(() => searchQuery = value),
          ),
          const SizedBox(height: 20),

          // Kategori Filter
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final cat = categories[index];
                final isSelected = selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (selected) =>
                        setState(() => selectedCategory = cat),
                    selectedColor:
                        AppColors.moonstone, // Biru Pastel jika dipilih
                    backgroundColor: AppColors.backgroundWhite,
                    labelStyle: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textGrey,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                            color: isSelected
                                ? AppColors.moonstone
                                : AppColors.borderGrey)),
                    showCheckmark: false,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),

          // Daftar Mobil
          const Text('Daftar Mobil',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: AppColors.gunmetal)),
          const SizedBox(height: 12),

          if (filteredCars.isEmpty)
            const Center(
                child: Padding(
              padding: EdgeInsets.all(40.0),
              child: Text('Mobil tidak ditemukan.',
                  style: TextStyle(color: AppColors.textGrey)),
            ))
          else
            ...filteredCars.map((car) {
              return CarCard(
                car: car,
                onFavoriteTap: () =>
                    setState(() => car.isFavorite = !car.isFavorite),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => DetailPage(car: car))),
              );
            }),

          const SizedBox(height: 30),

          // Layanan Purna Jual
          const Text('Layanan Purna Jual',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: AppColors.gunmetal)),
          const SizedBox(height: 12),
          ...afterSalesServices.map((service) {
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              color: AppColors.backgroundWhite,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side:
                    BorderSide(color: AppColors.borderGrey), // Garis tipis abu
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.champagne, // Kotak ikon Champagne
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(service['icon'],
                      color: AppColors.gunmetal, size: 24),
                ),
                title: Text(service['title'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.gunmetal)),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(service['desc'],
                      style: const TextStyle(
                          color: AppColors.textGrey, fontSize: 13)),
                ),
              ),
            );
          }),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
