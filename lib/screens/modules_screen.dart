import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/models.dart';
import '../widgets/common_widgets.dart';
import 'ddmrp_screen.dart';
import 'dbr_screen.dart';
import 'ccpm_screen.dart';
import 'mes_screen.dart';
import 'erp_screen.dart';

class ModulesScreen extends StatelessWidget {
  final UserModel user;
  const ModulesScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final modules = [
      _ModuleCard(
        title: 'CCPM', description: 'Project buffer health, fever chart, critical chain tracking',
        color: AppColors.modCCPM, icon: Icons.timeline,
        statusLabel: '2 red · 1 green', statusColor: AppColors.zoneAmber,
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CCPMScreen(user: user))),
      ),
      _ModuleCard(
        title: 'DDMRP', description: 'Buffer health, replenishment signals, inventory zones',
        color: AppColors.modDDMRP, icon: Icons.inventory_2_outlined,
        statusLabel: '3 red · 7 yellow', statusColor: AppColors.c9Red,
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DDMRPScreen(user: user))),
      ),
      _ModuleCard(
        title: 'DBR', description: 'Drum-Buffer-Rope, CCR scheduling, buffer penetration',
        color: AppColors.modDBR, icon: Icons.access_time,
        statusLabel: '34% penetrated', statusColor: AppColors.c9Red,
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DBRScreen(user: user))),
      ),
      _ModuleCard(
        title: 'MES', description: 'Shop floor execution, cell tracking, job progress',
        color: AppColors.modMES, icon: Icons.precision_manufacturing_outlined,
        statusLabel: '74% of plan', statusColor: AppColors.zoneAmber,
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MESScreen(user: user))),
      ),
      _ModuleCard(
        title: 'ERP', description: 'Sales orders, dispatch pipeline, OTD tracking',
        color: AppColors.modERP, icon: Icons.receipt_long_outlined,
        statusLabel: '4 orders at risk', statusColor: AppColors.zoneAmber,
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ERPScreen(user: user))),
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.bgScreen,
      body: SafeArea(
        child: Column(children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
                color: AppColors.navy,
                border: Border(bottom: BorderSide(color: AppColors.borderCard))),
            child: Row(children: [
              const Cloud9Logo(fontSize: 22),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.bgCard,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.borderCard),
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Container(width: 5, height: 5, margin: const EdgeInsets.only(right: 5),
                    decoration: const BoxDecoration(color: AppColors.zoneGreen, shape: BoxShape.circle)),
                  Text(user.roleTitle.split(' — ').first,
                    style: const TextStyle(fontSize: 10.5, color: AppColors.textPrimary)),
                ]),
              ),
            ]),
          ),

          // Grid
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(14),
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text('Tap a module to view details',
                    style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.95,
                  children: [
                    ...modules.map((m) => m),
                    // Add module placeholder
                    _AddModulePlaceholder(),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

// ── Module Card ───────────────────────────────────────────────

class _ModuleCard extends StatelessWidget {
  final String title;
  final String description;
  final Color color;
  final IconData icon;
  final String statusLabel;
  final Color statusColor;
  final VoidCallback onTap;

  const _ModuleCard({
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
    required this.statusLabel,
    required this.statusColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.borderCard),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Color accent bar
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 8),
              Text(title,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              const SizedBox(height: 4),
              Text(description,
                style: const TextStyle(fontSize: 10.5, color: AppColors.textMuted, height: 1.4),
                maxLines: 3, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 8),
              Row(children: [
                Container(
                  width: 6, height: 6,
                  margin: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
                ),
                Flexible(
                  child: Text(statusLabel,
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: statusColor),
                    overflow: TextOverflow.ellipsis),
                ),
              ]),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _AddModulePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderCard, style: BorderStyle.solid),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
        Icon(Icons.add, color: AppColors.textMuted, size: 28),
        SizedBox(height: 8),
        Text('Add Module',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textMuted)),
        SizedBox(height: 4),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('Contact Cloud9 eBiz to enable additional modules',
            style: TextStyle(fontSize: 9.5, color: AppColors.textMuted),
            textAlign: TextAlign.center),
        ),
      ]),
    );
  }
}
