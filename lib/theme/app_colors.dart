import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// Cloud9 eBiz Pvt. Ltd. — Design System v2 (Light Theme)
// Matched to CCPM HTML design reference — May 2026
//
// WHAT CHANGED FROM v1:
//   v1 was a dark theme (bg: #0A0D14, cards: #131920, text: #E2E8F0)
//   v2 is a light theme (bg: #E8ECF2, cards: #FFFFFF, text: #0F172A)
//   All screen logic, models, services — unchanged.
//   Only this file + app_theme.dart + common_widgets.dart changed.
// ═══════════════════════════════════════════════════════════════════════════

class AppColors {
  AppColors._();

  // ── Cloud9 Logo Brand Colors ─────────────────────────────────────────────
  // Extracted from the Cloud9 logo — unchanged from v1
  static const Color c9Red       = Color(0xFFE5231A); // letter 'c'
  static const Color c9OrangeRed = Color(0xFFF05A24); // letter 'l'
  static const Color c9Orange    = Color(0xFFF7941D); // letter 'o'
  static const Color c9Green     = Color(0xFF39B54A); // letter 'u'
  static const Color c9Blue      = Color(0xFF1B75BC); // letter 'D9'
  static const Color dbr = Color(0xFF7C2D12); // deep red shade
  // ── Page & Screen Backgrounds ─────────────────────────────────────────────
  // v1: bgPrimary = 0xFF0A0D14 (near-black)
  // v2: light surfaces matching CCPM HTML reference
  static const Color bgPage      = Color(0xFFE8ECF2); // scaffold/page background
  static const Color bgScreen    = Color(0xFFF0F2F5); // individual screen background
  static const Color bgCard      = Color(0xFFFFFFFF); // white card surface
  static const Color bgStatBox   = Color(0xFFF8FAFC); // stat box (light gray)
  static const Color bgStatRed   = Color(0xFFFFF0F0); // red stat box tint
  static const Color bgStatAmber = Color(0xFFFFFBEB); // amber stat box tint
  static const Color bgStatGreen = Color(0xFFF0FDF4); // green stat box tint
  static const Color bgStatBlue  = Color(0xFFEFF6FF); // blue stat box tint
  static const Color bgInput     = Color(0xFFFFFFFF); // text input background
  static const Color bgChipActive= Color(0xFFFFFFFF); // active filter chip
  static const Color mes = Color(0xFF7C2D12); // deep red shade
  static const Color erp = Color(0xFF7F1D1D); // darker red shade

  // ── Card Tints (alert cards) ──────────────────────────────────────────────
  static const Color bgCardRed   = Color(0xFFFEF2F2);
  static const Color bgCardAmber = Color(0xFFFFFBEB);
  static const Color bgCardGreen = Color(0xFFF0FDF4);
  static const Color bgCardBlue  = Color(0xFFEFF6FF);
  static const Color bgCardPurple= Color(0xFFFAF5FF);

  // ── Border Colors ─────────────────────────────────────────────────────────
  static const Color borderCard  = Color(0xFFE2E8F0); // default card border
  static const Color borderRed   = Color(0xFFFECACA);
  static const Color borderAmber = Color(0xFFFDE68A);
  static const Color borderGreen = Color(0xFFBBF7D0);
  static const Color borderBlue  = Color(0xFFBFDBFE);
  static const Color borderPurple= Color(0xFFE9D5FF);
  static const Color borderDivider = Color(0xFFE2E8F0);

  // ── Text Colors ───────────────────────────────────────────────────────────
  // v1: textPrimary = 0xFFE2E8F0 (light on dark)
  // v2: textPrimary = 0xFF0F172A (dark on light)
  static const Color textPrimary   = Color(0xFF0F172A); // headings, values
  static const Color textSecondary = Color(0xFF64748B); // subtitles, metadata
  static const Color textMuted     = Color(0xFF94A3B8); // hints, timestamps
  static const Color textLabel     = Color(0xFF334155); // uppercase section labels

  // ── Navigation & Primary UI ───────────────────────────────────────────────
  static const Color navyPrimary   = Color(0xFF1A2744); // nav active, primary btn
  static const Color navItemBg     = Color(0xFFEFF6FF); // active nav item bg
  static const Color navIconInact  = Color(0xFF94A3B8); // inactive nav icon/label
  static const Color navBar        = Color(0xFFFFFFFF); // bottom nav bar bg
  static const navy = Color(0xFF1A2744);
  static const navyDark = Color(0xFF0F3460);
  // ── Module Header Colors ──────────────────────────────────────────────────
  // Each module has its own dark header colour — core to the CCPM design language
  static const Color hdrHome    = Color(0xFF1A2744); // Home + Login (navy)
  static const Color hdrHomeEnd = Color(0xFF0F3460); // gradient end for home header
  static const Color hdrCCPM   = Color(0xFF064E3B); // CCPM (dark green)
  static const Color hdrDDMRP  = Color(0xFF1E3A5F); // DDMRP (dark blue)
  static const Color hdrDBR    = Color(0xFF7C2D12); // DBR (dark orange)
  static const Color hdrMES    = Color(0xFF7C2D12); // MES (dark orange)
  static const Color hdrERP    = Color(0xFF7F1D1D); // ERP (dark red)
  static const Color hdrClaude = Color(0xFF3B0764); // Claude AI (deep purple)
  static const Color hdrProfile = Color(0xFF134E4A); // Profile (dark teal)

  // ── Header Sub-text Colors (on dark headers) ──────────────────────────────
  static const Color hdrSubNavy   = Color(0xFF7FA3D9); // on navy header
  static const Color hdrSubBlue   = Color(0xFF93C5FD); // on DDMRP blue header
  static const Color hdrSubGreen  = Color(0xFF6EE7B7); // on CCPM green header
  static const Color hdrSubOrange = Color(0xFFFDBA74); // on DBR/MES orange header
  static const Color hdrSubRed    = Color(0xFFFCA5A5); // on ERP red header
  static const Color hdrSubPurple = Color(0xFFC4B5FD); // on Claude purple header
  static const Color hdrSubTeal   = Color(0xFF99F6E4); // on Profile teal header

  // ── Header Stat Box (semi-transparent, on dark headers) ──────────────────
  static const Color hdrStatBg    = Color(0x1AFFFFFF); // rgba(255,255,255,0.10)

  // ── TOC Status / Zone Colors ──────────────────────────────────────────────
  static const Color zoneRed    = Color(0xFFEF4444); // buffer/fever red zone
  static const Color zoneAmber  = Color(0xFFF59E0B); // buffer/fever yellow zone
  static const Color zoneGreen  = Color(0xFF22C55E); // buffer/fever green zone
  static const Color zoneRedDark    = Color(0xFFDC2626); // darker red for text/value
  static const Color zoneAmberDark  = Color(0xFFD97706); // darker amber for text/value
  static const Color zoneGreenDark  = Color(0xFF16A34A); // darker green for text/value
  static const Color zoneBlueDark   = Color(0xFF1D4ED8); // blue for value text

  // ── Buffer Bar Zone Fill Colors (45% opacity look) ───────────────────────
  // Used in BufferBar and FeverBar widgets
  static const Color bufRed   = Color(0x72EF4444); // ~45% opacity red
  static const Color bufAmber = Color(0x72F59E0B); // ~45% opacity amber
  static const Color bufGreen = Color(0x7222C55E); // ~45% opacity green
  static const Color bufFevGreen = Color(0x7F22C55E); // fever bar green (left)
  static const Color bufFevAmber = Color(0x7FF59E0B); // fever bar amber (middle)
  static const Color bufFevRed   = Color(0x7FEF4444); // fever bar red (right)

  // ── Buffer Bar Marker ─────────────────────────────────────────────────────
  static const Color bufMarker = Color(0xFF1A2744); // dark navy marker (on light bg)

  // ── Progress Bar Fill Colors ──────────────────────────────────────────────
  static const Color pfRed   = Color(0xFFEF4444);
  static const Color pfAmber = Color(0xFFF59E0B);
  static const Color pfGreen = Color(0xFF22C55E);
  static const Color pfBlue  = Color(0xFF3B82F6);
  static const Color pfNavy  = Color(0xFF1A2744);
  static const Color pfTrack = Color(0xFFE2E8F0); // progress bar background track
  static const Color ddmpr = Color(0xFF1E3A5F); // deep navy blue for StatCard row
  // ── Badge Background / Text Pairs ─────────────────────────────────────────
  // Badge BG = light tint. Badge text = dark shade of same hue.
  static const Color badgeRedBg     = Color(0xFFFEE2E2); static const Color badgeRedText   = Color(0xFF991B1B);
  static const Color badgeAmberBg   = Color(0xFFFEF3C7); static const Color badgeAmberText = Color(0xFF92400E);
  static const Color badgeGreenBg   = Color(0xFFDCFCE7); static const Color badgeGreenText = Color(0xFF166534);
  static const Color badgeBlueBg    = Color(0xFFDBEAFE); static const Color badgeBlueText  = Color(0xFF1E40AF);
  static const Color badgeNavyBg    = Color(0xFFE0E7FF); static const Color badgeNavyText  = Color(0xFF3730A3);
  static const Color badgeGrayBg    = Color(0xFFF1F5F9); static const Color badgeGrayText  = Color(0xFF475569);
  static const Color badgeOrangeBg  = Color(0xFFFFEDD5); static const Color badgeOrangeText= Color(0xFF9A3412);
  static const Color badgePurpleBg  = Color(0xFFF3E8FF); static const Color badgePurpleText= Color(0xFF6B21A8);
  static const Color badgeTealBg    = Color(0xFFCCFBF1); static const Color badgeTealText  = Color(0xFF0F766E);

  // ── Left-border Card Accent Colors ───────────────────────────────────────
  static const Color lcardRed   = Color(0xFFEF4444);
  static const Color lcardAmber = Color(0xFFF59E0B);
  static const Color lcardGreen = Color(0xFF22C55E);
  static const Color lcardBlue  = Color(0xFF3B82F6);

  // ── Claude AI Color ───────────────────────────────────────────────────────
  static const Color claude = Color(0xFFFF6B47);

  // ── Phone Frame (for mockups) ─────────────────────────────────────────────
  static const Color phoneFrame   = Color(0xFF1C2333);
  static const Color phoneNotch   = Color(0xFF0D1117);

  // ── Module Brand Colors (for accent bars on module grid cards) ─────────────
  static const Color modCCPM  = Color(0xFF16A34A); // green
  static const Color modDDMRP = Color(0xFF1B75BC); // c9 blue
  static const Color modDBR   = Color(0xFFEA580C); // orange
  static const Color modMES   = Color(0xFFF05A24); // c9 orange-red
  static const Color modERP   = Color(0xFFE5231A); // c9 red

  // ── Toggle switch ────────────────────────────────────────────────────────
  static const Color toggleActive   = Color(0xFF1A2744);
  static const Color toggleInactive = Color(0xFFE2E8F0);
  static const Color toggleThumb    = Color(0xFFFFFFFF);

  // ── Checkbox ─────────────────────────────────────────────────────────────
  static const Color checkboxDone   = Color(0xFF16A34A);
  static const Color checkboxBorder = Color(0xFFCBD5E1);

  // ── Button Colors ─────────────────────────────────────────────────────────
  static const Color btnNavy   = Color(0xFF1A2744);
  static const Color btnSuccess= Color(0xFF16A34A);
  static const Color btnDanger = Color(0xFFDC2626);

  // ── Avatar Role Colors ─────────────────────────────────────────────────────
  static const Color avatarCEOBg    = Color(0xFF1D4A7A);
  static const Color avatarCEOFg    = Color(0xFF93C5FD);
  static const Color avatarDirBg    = Color(0xFF1E3A5F);
  static const Color avatarDirFg    = Color(0xFF93C5FD);
  static const Color avatarPHBg     = Color(0xFF450A0A);
  static const Color avatarPHFg     = Color(0xFFFCA5A5);
  static const Color avatarBorder   = Color(0xFF3B82F6);
  static const Color avatarBorderRed= Color(0xFFEF4444);

  static const Color puple = Color(0xFF3B0764); // updated to new dark purple
  static const Color ccpm = Color(0xFF064E3B); // dark green shade  // ══ HELPER METHODS ════════════════════════════════════════════════════════

  /// Returns the correct header color for each module screen.
  static Color moduleHeader(String module) {
    switch (module.toLowerCase()) {
      case 'ccpm':    return hdrCCPM;
      case 'ddmrp':   return hdrDDMRP;
      case 'dbr':     return hdrDBR;
      case 'mes':     return hdrMES;
      case 'erp':     return hdrERP;
      case 'claude':  return hdrClaude;
      case 'profile': return hdrProfile;
      default:        return hdrHome;
    }
  }

  /// Returns the correct sub-text color for a given header color.
  static Color moduleHeaderSub(String module) {
    switch (module.toLowerCase()) {
      case 'ccpm':    return hdrSubGreen;
      case 'ddmrp':   return hdrSubBlue;
      case 'dbr':     return hdrSubOrange;
      case 'mes':     return hdrSubOrange;
      case 'erp':     return hdrSubRed;
      case 'claude':  return hdrSubPurple;
      case 'profile': return hdrSubTeal;
      default:        return hdrSubNavy;
    }
  }

  /// Returns the zone color for a BufferZone enum value.
  static Color bufferZoneColor(String zone) {
    switch (zone.toLowerCase()) {
      case 'red':    return zoneRed;
      case 'yellow': return zoneAmber;
      default:       return zoneGreen;
    }
  }

  /// Returns the left-border color for a priority/zone card.
  static Color leftBorderColor(String zone) {
    switch (zone.toLowerCase()) {
      case 'red':    return lcardRed;
      case 'yellow': return lcardAmber;
      case 'blue':   return lcardBlue;
      default:       return lcardGreen;
    }
  }

  /// Returns badge background and text color pair for a zone.
  static (Color bg, Color text) badgeColors(String zone) {
    switch (zone.toLowerCase()) {
      case 'red':    return (badgeRedBg, badgeRedText);
      case 'yellow': return (badgeAmberBg, badgeAmberText);
      case 'green':  return (badgeGreenBg, badgeGreenText);
      case 'blue':   return (badgeBlueBg, badgeBlueText);
      case 'orange': return (badgeOrangeBg, badgeOrangeText);
      case 'purple': return (badgePurpleBg, badgePurpleText);
      default:       return (badgeGrayBg, badgeGrayText);
    }
  }

  // ── Login gradient ────────────────────────────────────────────────────────
  static const LinearGradient loginGradient = LinearGradient(
    colors: [c9Red, c9Orange, c9Green, c9Blue],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient homeHeaderGradient = LinearGradient(
    colors: [hdrHome, hdrHomeEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
