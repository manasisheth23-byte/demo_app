import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../models/models.dart';

// ═══════════════════════════════════════════════════════════════════════════
// Cloud9 Common Widgets — v2 (Light Theme)
// All widgets updated to use AppColors v2 tokens.
//
// STRUCTURE — same as v1, colors updated:
//   Cloud9Logo       — unchanged (always was colored)
//   C9AppBar         — updated: per-module header color via AppColors.moduleHeader()
//   BufferBar        — updated: marker now dark navy (was white) on light zone bars
//   FeverBar         — updated: same marker change
//   StatCard         — updated: white card, dark text, light border
//   ModuleTile       — updated: white bg, light dot colors
//   ActionItemCard   — updated: white card, colored left border
//   ClaudeAICard     — updated: light lavender bg (was near-black)
//   SectionTitle     — updated: dark text on light bg
//   BufferItemCard   — updated: white card, navy marker
//   PillSelector     — updated: light bg, dark text
//   Badge            — updated: colored light tint + dark text (no more glow)
//   LeftBorderCard   — NEW: extracted pattern used throughout screens
//   HdrStatBox       — NEW: semi-transparent stat box used inside dark headers
// ═══════════════════════════════════════════════════════════════════════════

// ── Cloud9 Logo ──────────────────────────────────────────────────────────
class Cloud9Logo extends StatelessWidget {
  final double fontSize;
  const Cloud9Logo({super.key, this.fontSize = 52});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            style: GoogleFonts.dmSans(
              fontSize: fontSize,
              fontWeight: FontWeight.w800,
              letterSpacing: -2,
              height: 1.0,
            ),
            children: const [
              TextSpan(text: 'c', style: TextStyle(color: AppColors.c9Red)),
              TextSpan(text: 'l', style: TextStyle(color: AppColors.c9OrangeRed)),
              TextSpan(text: 'o', style: TextStyle(color: AppColors.c9Orange)),
              TextSpan(text: 'u', style: TextStyle(color: AppColors.c9Green)),
            ],
          ),
        ),
        const SizedBox(width: 2),
        _D9Block(fontSize: fontSize),
      ],
    );
  }
}

class _D9Block extends StatelessWidget {
  final double fontSize;
  const _D9Block({required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        fontSize * 0.12, fontSize * 0.04,
        fontSize * 0.32, fontSize * 0.06,
      ),
      decoration: BoxDecoration(
        color: AppColors.c9Blue,
        borderRadius: BorderRadius.circular(fontSize * 0.16),
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Text('D', style: GoogleFonts.dmSans(
            fontSize: fontSize, fontWeight: FontWeight.w800,
            color: Colors.white, height: 1.0,
          )),
          Positioned(
            right: 0,
            child: Text('9', style: GoogleFonts.dmSans(
              fontSize: fontSize * 0.50, fontWeight: FontWeight.w800,
              color: Colors.white.withOpacity(0.88), height: 1.0,
            )),
          ),
        ],
      ),
    );
  }
}

// ── C9 App Bar ────────────────────────────────────────────────────────────
// v2 change: header background comes from AppColors.moduleHeader(module)
// Each module screen passes its own color — CCPM=green, DBR=orange, etc.
class C9AppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final Color? headerColor;      // if null, defaults to AppColors.hdrHome
  final Color? titleColor;       // always white on dark headers
  final Color? subtitleColor;    // use AppColors.moduleHeaderSub()
  final Widget? trailing;
  final bool showBack;

  const C9AppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.headerColor,
    this.titleColor,
    this.subtitleColor,
    this.trailing,
    this.showBack = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final bg = headerColor ?? AppColors.hdrHome;
    return Container(
      color: bg,
      child: SafeArea(
        bottom: false,
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(children: [
            if (showBack) ...[
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 30, height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new,
                      color: Colors.white, size: 16),
                ),
              ),
              const SizedBox(width: 10),
            ],
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.dmSans(
                    fontSize: 20, fontWeight: FontWeight.w600,
                    color: titleColor ?? Colors.white,
                    letterSpacing: -0.3,
                  )),
                  if (subtitle != null)
                    Text(subtitle!, style: GoogleFonts.dmSans(
                      fontSize: 11.5,
                      color: subtitleColor ?? Colors.white.withOpacity(0.55),
                    )),
                ],
              ),
            ),
            if (trailing != null) trailing!,
          ]),
        ),
      ),
    );
  }
}

// ── Header Stat Box (used inside dark colored module headers) ──────────────
// Semi-transparent white box that sits in the dark header area
class HdrStatBox extends StatelessWidget {
  final String value;
  final String label;
  final Color valueColor;

  const HdrStatBox({
    super.key,
    required this.value,
    required this.label,
    this.valueColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 4),
        decoration: BoxDecoration(
          color: AppColors.hdrStatBg,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Column(children: [
          Text(value, style: GoogleFonts.dmSans(
            fontSize: 20, fontWeight: FontWeight.w700, color: valueColor,
          )),
          const SizedBox(height: 2),
          Text(label, style: GoogleFonts.dmSans(
            fontSize: 9.5, color: Colors.white.withOpacity(0.55),
          ), textAlign: TextAlign.center),
        ]),
      ),
    );
  }
}

// ── Buffer Bar ─────────────────────────────────────────────────────────────
// v2 change: marker color changed from white to navy (AppColors.bufMarker)
// because the zone bars are now lighter and a white marker wouldn't show
class BufferBar extends StatelessWidget {
  final double nfpPercent;
  final double height;

  const BufferBar({super.key, required this.nfpPercent, this.height = 8});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final totalWidth = constraints.maxWidth;
      final markerLeft = ((nfpPercent / 100.0) * totalWidth).clamp(0.0, totalWidth - 3);
      return SizedBox(
        height: height + 10,
        child: Stack(clipBehavior: Clip.none, children: [
          Positioned(
            top: 5, left: 0, right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Row(children: [
                // Red zone (left — most urgent)
                Expanded(child: Container(
                  height: height,
                  color: AppColors.bufRed,
                )),
                // Yellow zone (middle — warning)
                Expanded(child: Container(
                  height: height,
                  color: AppColors.bufAmber,
                )),
                // Green zone (right — safe)
                Expanded(child: Container(
                  height: height,
                  color: AppColors.bufGreen,
                )),
              ]),
            ),
          ),
          // NFP position marker — navy on light background
          Positioned(
            top: 0,
            left: markerLeft,
            child: Container(
              width: 3,
              height: height + 10,
              decoration: BoxDecoration(
                color: AppColors.bufMarker,
                borderRadius: BorderRadius.circular(2),
                boxShadow: [BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 3,
                )],
              ),
            ),
          ),
        ]),
      );
    });
  }
}

// ── Fever Bar ──────────────────────────────────────────────────────────────
// CCPM project buffer — direction is Green→Yellow→Red (left to right)
// v2 change: same as BufferBar — marker is now navy
class FeverBar extends StatelessWidget {
  final double consumedPercent;
  final double height;

  const FeverBar({super.key, required this.consumedPercent, this.height = 10});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final totalWidth = constraints.maxWidth;
      final markerLeft = ((consumedPercent / 100.0) * totalWidth).clamp(0.0, totalWidth - 3);
      return SizedBox(
        height: height + 10,
        child: Stack(clipBehavior: Clip.none, children: [
          Positioned(
            top: 5, left: 0, right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Row(children: [
                Expanded(child: Container(height: height, color: AppColors.bufFevGreen)),
                Expanded(child: Container(height: height, color: AppColors.bufFevAmber)),
                Expanded(child: Container(height: height, color: AppColors.bufFevRed)),
              ]),
            ),
          ),
          Positioned(
            top: 0,
            left: markerLeft,
            child: Container(
              width: 3,
              height: height + 10,
              decoration: BoxDecoration(
                color: AppColors.bufMarker,
                borderRadius: BorderRadius.circular(2),
                boxShadow: [BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 3,
                )],
              ),
            ),
          ),
        ]),
      );
    });
  }
}

// ── Stat Card ──────────────────────────────────────────────────────────────
// v2 change: white card with light border (was dark surface1)
class StatCard extends StatelessWidget {
  final String number;
  final String label;
  final Color? accentColor;
  final VoidCallback? onTap;

  const StatCard({
    super.key,
    required this.number,
    required this.label,
    this.accentColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.bgStatBox,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.borderCard, width: 0.5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Column(children: [
          Text(number, style: GoogleFonts.dmSans(
            fontSize: 22, fontWeight: FontWeight.w600,
            color: accentColor ?? AppColors.textPrimary,
          )),
          const SizedBox(height: 2),
          Text(label, style: GoogleFonts.dmSans(
            fontSize: 9.5, fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ), textAlign: TextAlign.center),
        ]),
      ),
    );
  }
}

// ── Section Title ─────────────────────────────────────────────────────────
// v2 change: dark text on light background (was muted on dark)
class SectionTitleCard extends StatelessWidget {
  final String title;
  final String? badge;
  final Color? badgeColor;

  const SectionTitleCard({super.key, required this.title, this.badge, this.badgeColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3, // Shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
        side: BorderSide(color: AppColors.borderCard, width: 1), // Border
      ),
      margin: const EdgeInsets.symmetric(vertical: 18),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Text(
              title.toUpperCase(),
              style: GoogleFonts.dmSans(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textLabel,
                letterSpacing: 0.5,
              ),
            ),
            if (badge != null) ...[
              const SizedBox(width: 8),
              Text(
                badge!,
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: badgeColor ?? AppColors.zoneRed,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
// ── C9 Badge ──────────────────────────────────────────────────────────────
// v2 change: light tint background + dark text (was opaque dark bg)
class C9Badge extends StatelessWidget {
  final String label;
  final String zone; // 'red', 'amber', 'green', 'blue', 'orange', 'gray', 'purple'
  final double fontSize;

  const C9Badge({super.key, required this.label, this.zone = 'gray', this.fontSize = 11});

  @override
  Widget build(BuildContext context) {
    final (bg, text) = AppColors.badgeColors(zone);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(label, style: GoogleFonts.dmSans(
        fontSize: fontSize, fontWeight: FontWeight.w600,
        color: text, letterSpacing: 0.2,
      )),
    );
  }
}

// ── Left Border Card ──────────────────────────────────────────────────────
// v2: standard white card with a 3px colored left border
// Used for: priority actions, buffer items, job cards, task rows
class LeftBorderCard extends StatelessWidget {
  final Color borderColor;
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets padding;

  const LeftBorderCard({
    super.key,
    required this.borderColor,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.borderCard,
            width: 0.5,
          ),
        ),
        child: Row(
          children: [
            // Left colored strip
            Container(
              width: 3,
              decoration: BoxDecoration(
                color: borderColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: padding,
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Module Tile (Home screen health tiles) ────────────────────────────────
// v2 change: white bg, light colored dots
class ModuleTile extends StatelessWidget {
  final ModuleStatusModel module;
  final VoidCallback onTap;

  const ModuleTile({super.key, required this.module, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Color dotColor;
    switch (module.status) {
      case BufferZone.red:    dotColor = AppColors.zoneRed; break;
      case BufferZone.yellow: dotColor = AppColors.zoneAmber; break;
      case BufferZone.green:  dotColor = AppColors.zoneGreen; break;
    }

    Color tileBg;
    Color tileBorder;
    switch (module.status) {
      case BufferZone.red:
        tileBg = AppColors.bgStatRed; tileBorder = AppColors.borderRed; break;
      case BufferZone.yellow:
        tileBg = AppColors.bgStatAmber; tileBorder = AppColors.borderAmber; break;
      case BufferZone.green:
        tileBg = AppColors.bgStatGreen; tileBorder = AppColors.borderGreen; break;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
        decoration: BoxDecoration(
          color: tileBg,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(color: tileBorder, width: 0.5),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 6, height: 6, margin: const EdgeInsets.only(right: 6),
              decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle)),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(module.name, style: GoogleFonts.dmSans(
              fontSize: 10.5, fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            )),
            Text(module.statusLabel, style: GoogleFonts.dmSans(
              fontSize: 9.5, color: dotColor, fontWeight: FontWeight.w500,
            )),
          ]),
        ]),
      ),
    );
  }
}

// ── Action Item Card ──────────────────────────────────────────────────────
// v2 change: white card with colored left border (was dark surface card)
class ActionItemCard extends StatelessWidget {
  final ActionItemModel action;
  final VoidCallback? onTap;

  const ActionItemCard({super.key, required this.action, this.onTap});

  @override
  Widget build(BuildContext context) {
    final borderColor = action.isCritical ? AppColors.lcardRed : AppColors.lcardAmber;

    return LeftBorderCard(
      borderColor: borderColor,
      onTap: onTap,
      child: Row(children: [
        Text('${action.priority}', style: GoogleFonts.dmSans(
          fontSize: 10, fontWeight: FontWeight.w600,
          color: AppColors.textMuted,
        )),
        const SizedBox(width: 9),
        // Module badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.bgStatBlue,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(action.module, style: GoogleFonts.dmSans(
            fontSize: 9.5, fontWeight: FontWeight.w700,
            color: AppColors.navyPrimary,
          )),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(action.title, style: GoogleFonts.dmSans(
              fontSize: 12.5, fontWeight: FontWeight.w500,
              color: AppColors.textPrimary, height: 1.35,
            )),
            const SizedBox(height: 2),
            Text(action.tag, style: GoogleFonts.dmSans(
              fontSize: 10.5, color: AppColors.textSecondary,
            )),
          ]),
        ),
        const SizedBox(width: 8),
        Container(
          width: 6, height: 6,
          decoration: BoxDecoration(
            color: borderColor,
            shape: BoxShape.circle,
          ),
        ),
      ]),
    );
  }
}

// ── Claude AI Card ────────────────────────────────────────────────────────
// v2 MAJOR CHANGE:
//   Old: dark near-black background (#100D18), coral border
//   New: light lavender background (#FAF5FF), purple border (#E9D5FF)
//   Text is now dark (#0F172A) on a light background
class ClaudeAICard extends StatelessWidget {
  final String text;
  final String? actionLabel;
  final VoidCallback? onActionTap;

  const ClaudeAICard({
    super.key,
    required this.text,
    this.actionLabel,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgCardPurple,               // ← was #100D18 (dark)
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderPurple), // ← was coral border
      ),
      padding: const EdgeInsets.all(12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          _PulseDot(),
          const SizedBox(width: 6),
          Text('CLAUDE AI', style: GoogleFonts.dmSans(
            fontSize: 9.5, fontWeight: FontWeight.w700,
            color: AppColors.claude, letterSpacing: 1,
          )),
        ]),
        const SizedBox(height: 5),
        Text(text, style: GoogleFonts.dmSans(
          fontSize: 12, color: AppColors.textPrimary, // ← was light text on dark
          height: 1.6,
        )),
        if (actionLabel != null) ...[
          const SizedBox(height: 7),
          GestureDetector(
            onTap: onActionTap,
            child: Text('$actionLabel →', style: GoogleFonts.dmSans(
              fontSize: 11, color: AppColors.claude, fontWeight: FontWeight.w500,
            )),
          ),
        ],
      ]),
    );
  }
}

// ── Pulse dot for Claude AI card ──────────────────────────────────────────
class _PulseDot extends StatefulWidget {
  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);
    _anim = Tween<double>(begin: 1.0, end: 0.35).animate(_ctrl);
  }
  @override void dispose() { _ctrl.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Opacity(
        opacity: _anim.value,
        child: Container(
          width: 6, height: 6,
          decoration: const BoxDecoration(
            color: AppColors.claude, shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

// ── Buffer Item Card (DDMRP screen) ──────────────────────────────────────
// v2 change: white card with colored left border
class BufferItemCard extends StatelessWidget {
  final BufferItemModel item;
  final VoidCallback? onTap;

  const BufferItemCard({super.key, required this.item, this.onTap});

  Color get _borderColor {
    switch (item.zone) {
      case BufferZone.red:    return AppColors.lcardRed;
      case BufferZone.yellow: return AppColors.lcardAmber;
      case BufferZone.green:  return AppColors.lcardGreen;
    }
  }

  Color get _valueColor {
    switch (item.zone) {
      case BufferZone.red:    return AppColors.zoneRedDark;
      case BufferZone.yellow: return AppColors.zoneAmberDark;
      case BufferZone.green:  return AppColors.zoneGreenDark;
    }
  }

  String get _actionLabel {
    if (item.zone == BufferZone.red) return item.hasOpenPO ? 'EXPEDITE' : 'RAISE PO';
    if (item.zone == BufferZone.yellow) return 'MONITOR';
    return 'OK';
  }

  String get _badgeZone {
    switch (item.zone) {
      case BufferZone.red:    return 'red';
      case BufferZone.yellow: return 'yellow';
      case BufferZone.green:  return 'green';
    }
  }

  @override
  Widget build(BuildContext context) {
    return LeftBorderCard(
      borderColor: _borderColor,
      onTap: onTap,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(item.name, style: GoogleFonts.dmSans(
              fontSize: 12.5, fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            )),
            Text('${item.code} · ${item.cell}', style: GoogleFonts.dmMono(
              fontSize: 10, color: AppColors.textMuted,
            )),
          ])),
          C9Badge(label: item.plant, zone: 'gray'),
        ]),
        const SizedBox(height: 7),
        BufferBar(nfpPercent: item.nfpPercent),
        const SizedBox(height: 5),
        Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('NFP ${item.nfpPercent.toStringAsFixed(0)}%', style: GoogleFonts.dmSans(
              fontSize: 11.5, fontWeight: FontWeight.w700, color: _valueColor,
            )),
            Text('${item.coverage.toStringAsFixed(1)}d coverage · PO: ${item.onOrder}',
                style: GoogleFonts.dmSans(fontSize: 10, color: AppColors.textSecondary)),
          ])),
          C9Badge(label: _actionLabel, zone: _badgeZone, fontSize: 10),
        ]),
      ]),
    );
  }
}

// ── Pill Selector (filter dropdown) ──────────────────────────────────────
// v2 change: light semi-transparent bg on dark header
class PillSelector extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool onDarkHeader;   // true = use semi-transparent white; false = light bg

  const PillSelector({
    super.key,
    required this.label,
    this.onTap,
    this.onDarkHeader = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: onDarkHeader
              ? Colors.white.withOpacity(0.15)
              : AppColors.bgCard,
          borderRadius: BorderRadius.circular(20),
          border: onDarkHeader
              ? null
              : Border.all(color: AppColors.borderCard, width: 0.5),
        ),
        child: Text(label, style: GoogleFonts.dmSans(
          fontSize: 11,
          color: onDarkHeader ? Colors.white : AppColors.textPrimary,
          fontWeight: FontWeight.w500,
        )),
      ),
    );
  }
}

// ── Icon Button (on dark headers) ─────────────────────────────────────────
class HdrIconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const HdrIconBtn({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32, height: 32,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}

// ── Progress Bar ──────────────────────────────────────────────────────────
class C9ProgressBar extends StatelessWidget {
  final double value; // 0.0 to 1.0
  final Color? color;
  final double height;

  const C9ProgressBar({
    super.key,
    required this.value,
    this.color,
    this.height = 6,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.pfBlue;
    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: LinearProgressIndicator(
        value: value.clamp(0.0, 1.0),
        minHeight: height,
        backgroundColor: AppColors.pfTrack,
        valueColor: AlwaysStoppedAnimation(c),
      ),
    );
  }
}

// ── Cell Status Card (MES screen) ─────────────────────────────────────────
// v2 change: colored tinted background instead of dark bg with accent
class CellStatusCard extends StatelessWidget {
  final String name;
  final String description;
  final double percentOfPlan;
  final BufferZone status;

  const CellStatusCard({
    super.key,
    required this.name,
    required this.description,
    required this.percentOfPlan,
    required this.status,
  });

  Color get _bg {
    switch (status) {
      case BufferZone.red:    return AppColors.bgStatRed;
      case BufferZone.yellow: return AppColors.bgStatAmber;
      case BufferZone.green:  return AppColors.bgStatGreen;
    }
  }

  Color get _barColor {
    switch (status) {
      case BufferZone.red:    return AppColors.zoneRed;
      case BufferZone.yellow: return AppColors.zoneAmber;
      case BufferZone.green:  return AppColors.zoneGreen;
    }
  }

  Color get _valueColor {
    switch (status) {
      case BufferZone.red:    return AppColors.zoneRedDark;
      case BufferZone.yellow: return AppColors.zoneAmberDark;
      case BufferZone.green:  return AppColors.zoneGreenDark;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(children: [
        // Left color bar
        Container(
          width: 4, height: 40,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: _barColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(name, style: GoogleFonts.dmSans(
            fontSize: 12.5, fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          )),
          Text(description, style: GoogleFonts.dmSans(
            fontSize: 10.5, color: AppColors.textSecondary,
          )),
        ])),
        Text('${percentOfPlan.toStringAsFixed(0)}%', style: GoogleFonts.dmSans(
          fontSize: 20, fontWeight: FontWeight.w700, color: _valueColor,
        )),
      ]),
    );
  }
}

// ── Toggle Switch Row (Profile settings) ─────────────────────────────────
class ToggleRow extends StatelessWidget {
  final String label;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const ToggleRow({
    super.key,
    required this.label,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: GoogleFonts.dmSans(
          fontSize: 13, fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        )),
        Text(subtitle, style: GoogleFonts.dmSans(
          fontSize: 10.5, color: AppColors.textSecondary,
        )),
      ])),
      Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.toggleThumb,
        activeTrackColor: AppColors.toggleActive,
        inactiveThumbColor: AppColors.toggleThumb,
        inactiveTrackColor: AppColors.toggleInactive,
      ),
    ]);
  }
}

// ── Notification Banner (exception alerts on Home) ────────────────────────
// v2: light red tinted card (was dark red glow)
class ExceptionBanner extends StatelessWidget {
  final int count;
  final String sub;

  const ExceptionBanner({super.key, required this.count, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgCardRed,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderRed, width: 0.5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      child: Row(children: [
        _BlinkDot(),
        const SizedBox(width: 9),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text('$count', style: GoogleFonts.dmSans(
                fontSize: 20, fontWeight: FontWeight.w700,
                color: AppColors.zoneRedDark,
              )),
              const SizedBox(width: 7),
              Text('items need attention', style: GoogleFonts.dmSans(
                fontSize: 12, fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              )),
            ],
          ),
          Text(sub, style: GoogleFonts.dmSans(
            fontSize: 10, color: AppColors.textSecondary,
          )),
        ])),
      ]),
    );
  }
}

class _BlinkDot extends StatefulWidget {
  @override
  State<_BlinkDot> createState() => _BlinkDotState();
}

class _BlinkDotState extends State<_BlinkDot> with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _a;
  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);
    _a = Tween<double>(begin: 1.0, end: 0.3).animate(_c);
  }
  @override void dispose() { _c.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _a,
      builder: (_, __) => Opacity(
        opacity: _a.value,
        child: Container(
          width: 9, height: 9,
          decoration: const BoxDecoration(
            color: AppColors.zoneRedDark, shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

// ── Divider line ──────────────────────────────────────────────────────────
class C9Divider extends StatelessWidget {
  const C9Divider({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5, margin: const EdgeInsets.symmetric(vertical: 7),
      color: AppColors.borderDivider,
    );
  }
}
