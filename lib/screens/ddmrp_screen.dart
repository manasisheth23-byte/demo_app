import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/models.dart';
import '../services/api_service.dart';
import '../widgets/common_widgets.dart';

import 'claude_screen.dart';
import 'home_screen.dart';

class DDMRPScreen extends StatefulWidget {
  final UserModel user;
  const DDMRPScreen({super.key, required this.user});

  @override
  State<DDMRPScreen> createState() => _DDMRPScreenState();
}

class _DDMRPScreenState extends State<DDMRPScreen> {
  List<BufferItemModel> _buffers = [];
  bool _loading = true;

  final List<double> _trend = [2, 2, 3, 2, 3, 3, 3];
  final List<String> _trendLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', '', ''];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final data = await ApiService.getBuffers();
    if (mounted) setState(() { _buffers = data; _loading = false; });
  }

  int get _redCount    => _buffers.where((b) => b.zone == BufferZone.red).length;
  int get _yellowCount => _buffers.where((b) => b.zone == BufferZone.yellow).length;
  int get _greenCount  => _buffers.where((b) => b.zone == BufferZone.green).length;

  @override
  Widget build(BuildContext context) {
    final reds    = _buffers.where((b) => b.zone == BufferZone.red).toList();
    final yellows = _buffers.where((b) => b.zone == BufferZone.yellow).toList();

    return Scaffold(
      backgroundColor: AppColors.bgScreen,
      appBar: C9AppBar(
        title: 'DDMRP',
        titleColor: AppColors.bgPage,
        subtitle: 'Buffer health · Khalapur plants',
        trailing: const PillSelector(label: 'All plants ▾'),
          headerColor: AppColors.ddmpr
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: AppColors.modDDMRP))
          : Column(
        children: [
          // Add any widget above the ListView


          // ── Stat row ─────────────────────────────────────
          Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.ddmpr, // background color for the stat row
                borderRadius: BorderRadius.circular(0), // optional rounded corners
              ),
              child:   Row(children: [
            Expanded(child: StatCard(number: '$_redCount', label: 'Red', accentColor: AppColors.zoneRedDark)),
            const SizedBox(width: 8),
            Expanded(child: StatCard(number: '$_yellowCount', label: 'Yellow', accentColor: AppColors.zoneAmber)),
            const SizedBox(width: 8),
            Expanded(child: StatCard(number: '$_greenCount', label: 'Green', accentColor: AppColors.zoneGreen)),
          ])),

          // Expanded wraps ListView so it fills remaining space
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              children: [

                const SizedBox(height: 12),

                // ── 7-day trend ───────────────────────────────────
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.bgCard,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.borderCard),
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const SectionTitle(title: '7-day red zone trend'),
                    /*  SparklineChart(
                      data: _trend, color: AppColors.zoneRedDark,
                      labels: _trendLabels, height: 44,
                    ),*/
                    const SizedBox(height: 4),
                    const Text('↑ Red zone worsening — 3 new breaches since Monday',
                        style: TextStyle(fontSize: 10.5, color: AppColors.zoneRedDark)),
                  ]),
                ),
                const SizedBox(height: 12),

                // ── Claude AI insight ─────────────────────────────
                ClaudeAICard(
                  text: 'MS Pipe Asm 40mm and Caster Wheel 75mm have zero open POs and will exhaust in under 3 days. Raise purchase orders immediately before the CCR Paint Shop buffer penetrates further.',
                  actionLabel: 'Ask a follow-up on DDMRP',
                  onActionTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ClaudeScreen(user: widget.user))),
                ),
                const SizedBox(height: 14),

                // ── Red zone ──────────────────────────────────────
                SectionTitle(
                  title: 'Red zone',
                  badge: '$_redCount need action now',
                  badgeColor: AppColors.zoneRedDark,
                ),
                ...reds.map((b) => BufferItemCard(item: b)),
                const SizedBox(height: 10),

                // ── Yellow zone ───────────────────────────────────
                SectionTitle(
                  title: 'Yellow zone',
                  badge: '$_yellowCount — watch closely',
                  badgeColor: AppColors.zoneAmber,
                ),
                ...yellows.map((b) => BufferItemCard(item: b)),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
