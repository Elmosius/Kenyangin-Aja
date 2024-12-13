import 'package:flutter/material.dart';
import 'package:main/data/models/food.dart';

class FoodDetailPage extends StatelessWidget {
  final Food food;

  const FoodDetailPage({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    final location = food.locations.isNotEmpty ? food.locations.first : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(food.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (food.imageUrl.isNotEmpty)
              Center(
                child: Image.network(
                  food.imageUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 16),
            Text(
              'Name:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              food.name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'Description:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              food.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            if (location != null) ...[
              Text(
                'City:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                location.city,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              Text(
                'Address:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                location.address,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              if (location.url != null)
                Text(
                  'Google Map:',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              if (location.url != null)
                GestureDetector(
                  onTap: () {
                    // Buka URL Google Map
                  },
                  child: Text(
                    location.url!,
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
            ],
            const SizedBox(height: 16),
            Text(
              'Rating:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              food.rating.toStringAsFixed(1),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            if (food.tiktokRef != null)
              Text(
                'TikTok Reference:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            if (food.tiktokRef != null)
              GestureDetector(
                onTap: () {
                  // Buka TikTok Video
                },
                child: Text(
                  food.tiktokRef!,
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
