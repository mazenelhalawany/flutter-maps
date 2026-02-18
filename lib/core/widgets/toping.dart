import 'package:flutter/material.dart';
import '../constants/colors.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onAdd;
  final bool isSelected;

  const ProductCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onAdd,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(15),
      elevation: 5,
      shadowColor: Colors.grey,
      child: SizedBox(
        width: 100,
        height: 120,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            /// Card background
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.foodCard,
                border: isSelected
                    ? Border.all(
                        color: AppColors.blue,
                        width: 2,
                      )
                    : null,
              ),
            ),

            /// Selected overlay
            if (isSelected)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black.withOpacity(0.1),
                  ),
                ),
              ),

            /// Image
            Positioned(
              top: -5,
              left: 0,
              right: 0,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(imagePath),
                ),
              ),
            ),

            /// Title
            Positioned(
              bottom: 12,
              left: 5,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            /// Add / Selected Button
            Positioned(
              bottom: 10,
              right: 5,
              child: GestureDetector(
                onTap: onAdd,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.green : Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isSelected ? Icons.check : Icons.add,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
