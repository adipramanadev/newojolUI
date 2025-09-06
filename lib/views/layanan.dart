import 'package:flutter/material.dart';
import 'package:newojol/model/service.dart';
import 'package:newojol/views/ridepage.dart';

class ServicesGrid extends StatelessWidget {
  final _items = [
    Service(
      icon: Icons.motorcycle,
      label: 'Ride',
      color: const Color(0xFFE8F7EA),
    ),
    Service(
      icon: Icons.fastfood,
      label: 'Food',
      color: const Color(0xFFFFF6E6),
    ),
    Service(
      icon: Icons.local_shipping,
      label: 'Send',
      color: const Color(0xFFE6F3FF),
    ),
    Service(icon: Icons.store, label: 'Mart', color: const Color(0xFFF1E8FF)),
    Service(
      icon: Icons.receipt_long,
      label: 'Bills',
      color: const Color(0xFFEAF2F8),
    ),
    Service(
      icon: Icons.more_horiz,
      label: 'More',
      color: const Color(0xFFF2F2F2),
    ),
  ];

  ServicesGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _items.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisExtent: 92,
      ),
      itemBuilder: (context, i) {
        final s = _items[i];
        return InkWell(
          onTap: () {
            // Handle tap
            print('Tapped on ${s.label}');
            if (s.label == 'Ride') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => RidePage()),
              );
            }
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              Container(
                height: 58,
                width: 58,
                decoration: BoxDecoration(
                  color: s.color,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(s.icon, size: 28, color: Colors.black87),
              ),
              const SizedBox(height: 6),
              Text(
                s.label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
