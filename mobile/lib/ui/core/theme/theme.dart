import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';

final friendlyLightColors = FColors(
  brightness: Brightness.light,
  systemOverlayStyle: SystemUiOverlayStyle.dark,
  barrier: const Color(0x7A000000),
  background: const Color(0xFFFFFFFF),
  foreground: const Color(0xFF111827),
  primary: const Color(0xFF111827),
  primaryForeground: const Color(0xFFFFFFFF),
  secondary: const Color(0xFFF9FAFB),
  secondaryForeground: const Color(0xFF111827),
  muted: const Color(0xFFF3F4F6),
  mutedForeground: const Color(0xFF4B5563),
  destructive: const Color(0xFFE05252),
  destructiveForeground: const Color(0xFFFFFFFF),
  error: const Color(0xFFE05252),
  errorForeground: const Color(0xFFFFFFFF),
  card: const Color(0xFFFFFFFF),
  border: const Color(0xFFE5E7EB),
);

final friendlyDarkColors = FColors(
  brightness: Brightness.dark,
  systemOverlayStyle: SystemUiOverlayStyle.light,
  barrier: const Color(0x7A000000),
  background: const Color(0xFF030712),
  foreground: const Color(0xFFFFFFFF),
  primary: const Color(0xFFFFFFFF),
  primaryForeground: const Color(0xFF030712),
  secondary: const Color(0xFF101828),
  secondaryForeground: const Color(0xFFFFFFFF),
  muted: const Color(0xFF1E2939),
  mutedForeground: const Color(0xFF9CA3AF),
  destructive: const Color(0xFFE05252),
  destructiveForeground: const Color(0xFFFFFFFF),
  error: const Color(0xFFE05252),
  errorForeground: const Color(0xFFFFFFFF),
  card: const Color(0xFF101828),
  border: const Color(0xFF1E2939),
);

final friendlyRadii = FBorderRadius(
  xs2: BorderRadius.circular(8),
  xs: BorderRadius.circular(8),
  sm: BorderRadius.circular(9999),
  md: BorderRadius.circular(9999),
  lg: BorderRadius.circular(48),
  xl: BorderRadius.circular(24),
  xl2: BorderRadius.circular(24),
  xl3: BorderRadius.circular(24),
  pill: BorderRadius.circular(9999),
);

final _baseLight = FThemeData(colors: friendlyLightColors, touch: true);
final friendlyLightTheme = FThemeData(
  colors: friendlyLightColors,
  touch: true,
  style: _baseLight.style.copyWith(borderRadius: friendlyRadii),
);

final _baseDark = FThemeData(colors: friendlyDarkColors, touch: true);
final friendlyDarkTheme = FThemeData(
  colors: friendlyDarkColors,
  touch: true,
  style: _baseDark.style.copyWith(borderRadius: friendlyRadii),
);
