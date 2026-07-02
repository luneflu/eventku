import 'package:flutter/services.dart';
import 'package:forui/forui.dart';

final noirGoldColors = FColors(
  brightness: Brightness.dark,
  systemOverlayStyle: SystemUiOverlayStyle.light,
  barrier: const Color(0x7A000000),
  background: const Color(0xFF12110F), // Primary / Background: Obsidian `#12110F`
  foreground: const Color(0xFFF5F0E8), // Primary text: Ivory `#F5F0E8`
  primary: const Color(0xFFC9A84C), // Accent / CTA / Active: Gold `#C9A84C`
  primaryForeground: const Color(0xFF12110F), // Text on gold: Obsidian
  secondary: const Color(0xFF1E1C18), // Surface / Card bg: Charcoal `#1E1C18`
  secondaryForeground: const Color(0xFFF5F0E8),
  muted: const Color(0xFF2D2A23), // Elevated surface: Ash `#2D2A23`
  mutedForeground: const Color(0xFF9E9484), // Secondary text: Dust `#9E9484`
  destructive: const Color(0xFFE05252), // Error / Sold out: Crimson `#E05252`
  destructiveForeground: const Color(0xFFF5F0E8),
  error: const Color(0xFFE05252),
  errorForeground: const Color(0xFFF5F0E8),
  card: const Color(0xFF1E1C18),
  border: const Color(0xFF3A3629), // Dividers / borders: Smoke `#3A3629`
);

final noirGoldTheme = FThemeData(
  colors: noirGoldColors,
  touch: true,
);
