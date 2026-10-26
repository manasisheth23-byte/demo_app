import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/models.dart';
import '../widgets/common_widgets.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  final UserModel user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notifications = true;
  bool _claudeBriefing = true;
  bool _voiceQueries = false;
  bool _biometric = false;

  final List<Map<String, dynamic>> _modules = const [
    {'name': 'CCPM',  'color': AppColors.modCCPM},
    {'name': 'DDMRP', 'color': AppColors.modDDMRP},
    {'name': 'DBR',   'color': AppColors.modDBR},
    {'name': 'MES',   'color': AppColors.modMES},
    {'name': 'ERP',   'color': AppColors.modERP},
  ];

  void _onSignOut() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.bgCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: const Text('Sign Out', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700)),
        content: const Text('Are you sure you want to sign out?',
          style: TextStyle(color: AppColors.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppColors.textMuted)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            child: const Text('Sign Out', style: TextStyle(color: AppColors.c9Red, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgScreen,
      body: SafeArea(
        child: Column(children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: const BoxDecoration(
              color: AppColors.hdrProfile, // Navy Blue
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(0)),
            ),
            child: Column(
              children: [
                // Top row: Title and logo
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: AppColors.borderCard)),
                  ),
                  child: Row(
                    children: const [
                      Text(
                        'Profile ',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: AppColors.bgPage,
                        ),
                      ),
                      Spacer(),
                      Cloud9Logo(fontSize: 16),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // User avatar and details row
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      // Avatar
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: widget.user.avatarBg,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: widget.user.avatarFg.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            widget.user.initials,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: widget.user.avatarFg,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 14),

                      // User details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.user.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.user.roleTitle,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              widget.user.scope,
                              style: const TextStyle(
                                fontSize: 10.5,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),


          // Content
          Expanded(
            child: ListView(
              children: [
                // ── User profile ────────────────────────────────


                // ── Module access ───────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Card(
                    elevation: 3, // Shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: AppColors.borderCard, width: 1), // Border
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionTitle(title: 'Module Access'),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: _modules.map((m) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: (m['color'] as Color).withOpacity(0.12),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: (m['color'] as Color).withOpacity(0.28)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    m['name'] as String,
                                    style: TextStyle(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.w700,
                                      color: m['color'] as Color,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(Icons.check_circle, size: 12, color: m['color'] as Color),
                                ],
                              ),
                            )).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Card(
                    elevation: 3, // Shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: AppColors.borderCard, width: 1), // Card border
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionTitle(title: 'Settings'),
                          const SizedBox(height: 8),
                          _ToggleRow(
                            label: 'Push notifications',
                            sub: 'Red-zone alerts, CCR penetration',
                            value: _notifications,
                            onChanged: (v) => setState(() => _notifications = v),
                          ),
                          _ToggleRow(
                            label: 'Claude AI morning briefing',
                            sub: 'Daily summary at 8:00 AM',
                            value: _claudeBriefing,
                            onChanged: (v) => setState(() => _claudeBriefing = v),
                          ),
                          _ToggleRow(
                            label: 'Voice queries',
                            sub: 'Ask Claude by voice',
                            value: _voiceQueries,
                            onChanged: (v) => setState(() => _voiceQueries = v),
                          ),
                          _ToggleRow(
                            label: 'Biometric login',
                            sub: 'Face ID / Fingerprint',
                            value: _biometric,
                            onChanged: (v) => setState(() => _biometric = v),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),


                // ── App info ────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Card(
                    elevation: 3, // Shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: AppColors.borderCard, width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // App version row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'App version',
                                    style: TextStyle(fontSize: 13, color: AppColors.textPrimary),
                                  ),
                                  Text(
                                    'Cloud9 v4.2.1 · Flutter build 2026.05',
                                    style: TextStyle(fontSize: 10.5, color: AppColors.textMuted),
                                  ),
                                ],
                              ),
                              Text(
                                'Latest ✓',
                                style: TextStyle(fontSize: 10.5, color: AppColors.c9Green),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Company row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Company',
                                style: TextStyle(fontSize: 13, color: AppColors.textPrimary),
                              ),
                              Text(
                                'Cloud9 eBiz Pvt. Ltd.',
                                style: TextStyle(fontSize: 10.5, color: AppColors.textMuted),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // ── Sign out ────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: OutlinedButton(
                    onPressed: _onSignOut,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.c9Red.withOpacity(0.3)),
                      backgroundColor: AppColors.c9Red.withOpacity(0.10),
                      foregroundColor: AppColors.c9Red,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const SizedBox(
                      width: double.infinity,
                      child: Text('Sign Out',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text('© 2026 Cloud9 eBiz Pvt. Ltd.',
                    style: TextStyle(fontSize: 9.5, color: AppColors.textMuted)),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final String label;
  final String sub;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleRow({
    required this.label,
    required this.sub,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
      child: Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textPrimary)),
          Text(sub, style: const TextStyle(fontSize: 10.5, color: AppColors.textMuted)),
        ])),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.c9Blue,
          activeTrackColor: AppColors.c9Blue.withOpacity(0.4),
          inactiveThumbColor: AppColors.textMuted,
          inactiveTrackColor: AppColors.bgCard,
        ),
      ]),
    );
  }
}
