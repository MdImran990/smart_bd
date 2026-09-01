import 'package:flutter/material.dart';

class ServiceButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ServiceButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(
                    alpha: 0.10,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 25,
                  color: colorScheme.primary,
                ),
              ),

              const SizedBox(height: 10),

              Flexible(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}