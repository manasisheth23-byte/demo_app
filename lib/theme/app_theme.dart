import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

// ═══════════════════════════════════════════════════════════════════════════
// Cloud9 App Theme — v2 Light Theme
// Font: DM Sans (Google Fonts) — matches CCPM HTML reference exactly
//
// WHAT CHANGED FROM v1:
//   brightness: Brightness.dark  →  brightness: Brightness.light
//   All surface/background colors updated to light tokens
//   Font switched from system sans-serif to DM Sans
// ═══════════════════════════════════════════════════════════════════════════

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    // Base DM Sans text theme
    final dmSansBase = GoogleFonts.dmSansTextTheme(ThemeData.light().textTheme);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,                        // ← changed from dark
      scaffoldBackgroundColor: AppColors.bgScreen,        // ← was bgPrimary (0xFF0A0D14)
      colorScheme: const ColorScheme.light(
        primary: AppColors.navyPrimary,
        secondary: AppColors.c9Green,
        surface: AppColors.bgCard,
        error: AppColors.zoneRed,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimary,
        onError: Colors.white,
      ),

      // ── App Bar ────────────────────────────────────────────────────────
      // Module screens use custom colored headers — see C9AppBar widget.
      // This appBarTheme is only the fallback for any plain AppBar.
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.hdrHome,
        foregroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,       // white icons on dark header
          systemNavigationBarColor: AppColors.navBar,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      ),

      // ── Bottom Navigation Bar ──────────────────────────────────────────
      // v1: background was dark (0xFF131920)
      // v2: white bar with navy active color — matches CCPM nav bar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.navBar,               // white
        selectedItemColor: AppColors.navyPrimary,        // navy
        unselectedItemColor: AppColors.navIconInact,     // gray
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontSize: 9, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontSize: 9, fontWeight: FontWeight.w500),
        elevation: 0,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),

      // ── Text Theme — DM Sans ───────────────────────────────────────────
      textTheme: dmSansBase.copyWith(
        // Large titles (screen headings on dark headers)
        displayLarge: GoogleFonts.dmSans(
          fontSize: 28, fontWeight: FontWeight.w600,
          color: Colors.white, letterSpacing: -0.5,
        ),
        // Screen title in custom AppBar
        titleLarge: GoogleFonts.dmSans(
          fontSize: 20, fontWeight: FontWeight.w600,
          color: Colors.white, letterSpacing: -0.3,
        ),
        // Card headings
        titleMedium: GoogleFonts.dmSans(
          fontSize: 13, fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
        // Primary body text
        bodyLarge: GoogleFonts.dmSans(
          fontSize: 13, fontWeight: FontWeight.w400,
          color: AppColors.textPrimary,
        ),
        // Secondary body text (subtitles, metadata)
        bodyMedium: GoogleFonts.dmSans(
          fontSize: 11, fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
        ),
        // Tiny/muted text (timestamps, hints)
        bodySmall: GoogleFonts.dmSans(
          fontSize: 10, fontWeight: FontWeight.w400,
          color: AppColors.textMuted,
        ),
        // Section labels (uppercase)
        labelSmall: GoogleFonts.dmSans(
          fontSize: 11, fontWeight: FontWeight.w600,
          color: AppColors.textLabel, letterSpacing: 0.5,
        ),
      ),

      // ── Input Decoration ──────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.bgInput,
        hintStyle: GoogleFonts.dmSans(
          color: AppColors.textMuted, fontSize: 13,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.borderCard),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.borderCard),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.navyPrimary, width: 1.5),
        ),
      ),

      // ── Card Theme ────────────────────────────────────────────────────
      // v1: cards were dark (0xFF131920)
      // v2: white cards with light border
      cardTheme: CardTheme(
        color: AppColors.bgCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: AppColors.borderCard, width: 0.5),
        ),
        margin: EdgeInsets.zero,
      ),

      // ── Divider ───────────────────────────────────────────────────────
      dividerTheme: const DividerThemeData(
        color: AppColors.borderDivider,
        thickness: 0.5,
        space: 0,
      ),

      // ── Icon Theme ────────────────────────────────────────────────────
      iconTheme: const IconThemeData(
        color: AppColors.navIconInact, size: 22,
      ),

      // ── Progress Indicator ────────────────────────────────────────────
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.navyPrimary,
        linearTrackColor: AppColors.pfTrack,
      ),

      // ── Switch ────────────────────────────────────────────────────────
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(AppColors.toggleThumb),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.toggleActive;
          return AppColors.toggleInactive;
        }),
      ),

      // ── Elevated Button ───────────────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.navyPrimary,
          foregroundColor: Colors.white,
          elevation: 0,
          textStyle: GoogleFonts.dmSans(
            fontSize: 14, fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),

      // ── List Tile ─────────────────────────────────────────────────────
      listTileTheme: const ListTileThemeData(
        tileColor: AppColors.bgCard,
        contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      ),
    );
  }
}
