import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../models/models.dart';
import '../services/api_service.dart';
import '../widgets/common_widgets.dart';
import 'ddmrp_screen.dart';
import 'dbr_screen.dart';
import 'ccpm_screen.dart';
import 'mes_screen.dart';
import 'erp_screen.dart';
import 'claude_screen.dart';

class HomeScreen extends StatefulWidget {
  final UserModel user;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<ModuleStatusModel> _modules;
  late List<ActionItemModel> _actions;
  late String _briefing;

  @override
  void initState() {
    super.initState();
    _modules  = ApiService.getModulesForRole(widget.user.role);
    _actions  = ApiService.getActionsForRole(widget.user.role);
    _briefing = ApiService.getBriefingForRole(widget.user.role);
  }

  void _navigateToModule(String route) {
    final screen = switch (route) {
      '/ddmrp' => DDMRPScreen(user: widget.user),
      '/dbr'   => DBRScreen(user: widget.user),
      '/ccpm'  => CCPMScreen(user: widget.user),
      '/mes'   => MESScreen(user: widget.user),
      '/erp'   => ERPScreen(user: widget.user),
      _        => DDMRPScreen(user: widget.user),
    };
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  String get _greeting {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good Morning';
    if (h < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    final excCritical = _actions.where((a) => a.isCritical).length;

    return Scaffold(
      backgroundColor: AppColors.bgScreen,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header with Navy Blue background ─────────────
         /*   Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              decoration: BoxDecoration(
                color: const Color(0xFF0A1F44), // Navy blue
              ),
              child: Row(
                children: [
                  // Avatar
                  Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(
                      color: widget.user.avatarBg,
                      shape: BoxShape.circle,
                      border: Border.all(color: widget.user.avatarFg.withOpacity(0.3), width: 1.5),
                    ),
                    child: Center(
                      child: Text(widget.user.initials,
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: widget.user.avatarFg)),
                    ),
                  ),
                  const SizedBox(width: 11),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('$_greeting, ${widget.user.firstName}',
                          style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: Colors.white)),
                      Text(widget.user.roleTitle,
                          style: const TextStyle(fontSize: 11, color: Colors.white70)),
                      Row(children: [
                        Container(width: 5, height: 5, margin: const EdgeInsets.only(right: 4),
                            decoration: const BoxDecoration(color: AppColors.zoneGreen, shape: BoxShape.circle)),
                        Text(widget.user.scope,
                            style: const TextStyle(fontSize: 10, color: Colors.white60)),
                      ]),
                    ]),
                  ),
                  // Notification bell
                  Stack(children: [
                    Container(
                      width: 32, height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFF152B5C),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.notifications_outlined, size: 18, color: Colors.white),
                    ),
                    Positioned(
                      top: 4, right: 4,
                      child: Container(
                        width: 8, height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.zoneRedDark,
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF0A1F44), width: 1.5),
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),*/
            Container(

              width: double.infinity,

              padding:
              const EdgeInsets.fromLTRB(
                  20,
                  18,
                  20,
                  22),

              decoration: const BoxDecoration(

                gradient: LinearGradient(

                  colors: [

                    Color(0xFF1A2744),

                    Color(0xFF0F3460),
                  ],

                  begin: Alignment.topLeft,

                  end: Alignment.bottomRight,
                ),
              ),

              child: Row(

                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

                children: [

                  /// LEFT TEXT
                  Column(

                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      Text(

                        "Good Morning",

                        style: TextStyle(

                          fontFamily: "DMSans",

                          color:
                          Color(0xFF7FA3D9),

                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(

                        "${ "Rajesh "} 👋",

                        style: TextStyle(

                          fontFamily: "DMSans",

                          color: Colors.white,

                          fontSize: 24,

                          fontWeight:
                          FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(

                        "Fri. 23/2/2026",
                        style: const TextStyle(

                          fontFamily: "DMSans",

                          color:
                          Color(0xFF7FA3D9),

                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),

                  /// PROFILE
                  Stack(

                    children: [

                      Container(

                        width: 46,

                        height: 46,

                        decoration: BoxDecoration(

                          color:
                          const Color(0xFFE0F2FE),

                          borderRadius:
                          BorderRadius.circular(
                              50),
                        ),

                        child:  Center(

                          child: Text(

                             "R",

                            style: TextStyle(

                              fontFamily: "DMSans",

                              color:Color(0xFF1A2744)
                             ,

                              fontWeight:
                              FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                      Positioned(

                        top: 0,

                        right: 0,

                        child: Container(

                          width: 12,

                          height: 12,

                          decoration:
                          BoxDecoration(

                            color: AppColors.zoneRed,

                            border: Border.all(

                              color:
                              AppColors.navy,

                              width: 2,
                            ),

                            borderRadius:
                            BorderRadius.circular(
                                50),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
             SizedBox(height: 12),

            // ── Top Metrics ──────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  _MetricCard(title: 'Exceptions', value: '${widget.user.exceptionCount}', color: AppColors.zoneRedDark),
                  _MetricCard(title: 'DDMRP Red', value: '3', color: AppColors.zoneRed),
                  _MetricCard(title: 'OTD', value: '84.6%', color: AppColors.zoneAmber),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ── Scrollable content ───────────────────────────────
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                children: [
                  // Exception banner
                  _ExceptionBanner(
                    sub: 'MS Pipe Asm 40mm exhausts in 1.8 days — no PO raised\nPaint Shop CCR buffer at 34% penetration',
                    count: widget.user.exceptionCount,
                    criticalCount: excCritical,
                  ),
                  const SizedBox(height: 14),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical:
                    10,horizontal: 10),
                    decoration: const BoxDecoration(
                      color: Colors.white, // Navy Blue
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(0),
                      ),
                    ),
                    child: Column(
                      children:  [
                         SectionTitle(title: 'Module Health'),
                        Wrap(
                          spacing: 6, runSpacing: 6,
                          children: _modules.map((m) => ModuleTile(
                            module: m,
                            onTap: () => _navigateToModule(m.route),
                          )).toList(),
                        ),
                      ],
                    ),
                  ),
                  // Module health

                  const SizedBox(height: 14),

                  // Priority actions
                  SectionTitle(
                    title: 'Priority Actions — Today',
                    badge: '$excCritical critical',
                    badgeColor: AppColors.zoneRedDark,
                  ),
                  ..._actions.map((a) => ActionItemCard(
                    action: a,
                    onTap: () => _navigateToModule(a.route),
                  )),
                  const SizedBox(height: 14),

                  // Claude AI briefing
                  ClaudeAICard(
                    text: _briefing,
                    actionLabel: 'Ask a follow-up',
                    onActionTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ClaudeScreen(user: widget.user)),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final String? badge;
  final Color? badgeColor;

  const SectionTitle({super.key, required this.title, this.badge, this.badgeColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(children: [
        Text(title.toUpperCase(), style: GoogleFonts.dmSans(
          fontSize: 11, fontWeight: FontWeight.w600,
          color: AppColors.textLabel, letterSpacing: 0.5,
        )),
        if (badge != null) ...[
          const SizedBox(width: 8),
          Text(badge!, style: GoogleFonts.dmSans(
            fontSize: 11, fontWeight: FontWeight.w600,
            color: badgeColor ?? AppColors.zoneRed,
          )),
        ],
      ]),
    );
  }
}

// ── Metric Card ──────────────────────────────────────────
class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  const _MetricCard({required this.title, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.4)),
        ),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
            const SizedBox(height: 6),
            Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }
}

// ── Exception Banner ─────────────────────────────────────
class _ExceptionBanner extends StatelessWidget {
  final int count;
  final String sub;
  final int criticalCount;

  const _ExceptionBanner({required this.count, required this.sub, required this.criticalCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.hdrSubRed,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.zoneRedDark.withOpacity(0.28)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      child: Row(children: [
        _AnimatedDot(),
        const SizedBox(width: 9),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('$count Critical Exceptions',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.zoneRedDark)),
            const SizedBox(height: 2),
            Text(sub, style: const TextStyle(fontSize: 13, color: AppColors.zoneRedDark)),
          ]),
        ),
       /* Column(crossAxisAlignment: CrossAxisAlignment.end, children: const [
          Text('Updated', style: TextStyle(fontSize: 10, color: AppColors.zoneRedDark)),
          Text('just now', style: TextStyle(fontSize: 10, color: AppColors.zoneRedDark)),
        ]),*/
      ]),
    );
  }
}

// ── Animated Dot ─────────────────────────────────────────
class _AnimatedDot extends StatefulWidget {
  @override
  State<_AnimatedDot> createState() => _AnimatedDotState();
}

class _AnimatedDotState extends State<_AnimatedDot> with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _a;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
    _a = Tween<double>(begin: 1.0, end: 0.3).animate(_c);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _a,
      builder: (_, __) => Opacity(
        opacity: _a.value,
        child: Container(
          width: 8, height: 8,
          decoration: const BoxDecoration(color: AppColors.zoneRedDark, shape: BoxShape.circle),
        ),
      ),
    );
  }
}