import 'package:flutter/material.dart';
import '../../../../data/models/event.dart';
import 'package:go_router/go_router.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final int index;
  final VoidCallback? onTap;

  const EventCard({
    super.key,
    required this.event,
    required this.index,
    this.onTap,
  });

  static const List<Color> pastelColors = [
    Color(0xFFF2D9DC), // rose
    Color(0xFFD9F2D8), // mint
    Color(0xFFE0D9F1), // lavender
    Color(0xFFDAEFF8), // sky
  ];

  @override
  Widget build(BuildContext context) {
    final bgColor = pastelColors[index % pastelColors.length];

    return GestureDetector(
      onTap: onTap ?? () => context.push('/event-details', extra: event),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    event.title,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    event.status.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              event.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.black54),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    event.location,
                    style: const TextStyle(color: Colors.black54, fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(Icons.calendar_today, size: 14, color: Colors.black54),
                const SizedBox(width: 4),
                Text(
                  event.date.toString().substring(0, 10),
                  style: const TextStyle(color: Colors.black54, fontSize: 13),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
