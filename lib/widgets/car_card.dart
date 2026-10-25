import 'package:flutter/material.dart';
import '../models/car_model.dart';
import '../theme/app_colors.dart';

class CarCard extends StatelessWidget {
  final CarModel car;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  const CarCard(
      {super.key,
      required this.car,
      required this.onTap,
      required this.onFavoriteTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderGrey),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 4))
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                car.image,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                    width: 100,
                    height: 100,
                    color: AppColors.surfaceGrey,
                    child: const Icon(Icons.directions_car,
                        size: 50, color: AppColors.textGrey)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(car.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppColors.gunmetal),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis)),
                      IconButton(
                        icon: Icon(
                            car.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: car.isFavorite
                                ? Colors.red
                                : AppColors.textGrey),
                        onPressed: onFavoriteTap,
                      ),
                    ],
                  ),
                  Text('${car.type} • ${car.year}',
                      style: const TextStyle(
                          color: AppColors.textGrey, fontSize: 13)),
                  const SizedBox(height: 10),
                  Text(car.price,
                      style: const TextStyle(
                          color: AppColors.moonstone,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)), // Harga Moonstone
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
