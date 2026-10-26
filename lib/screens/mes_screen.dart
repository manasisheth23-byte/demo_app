import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/models.dart';
import '../services/api_service.dart';
import '../widgets/common_widgets.dart';
import 'claude_screen.dart';
import 'home_screen.dart';

class MESScreen extends StatefulWidget {
  final UserModel user;
  const MESScreen({super.key, required this.user});

  @override
  State<MESScreen> createState() => _MESScreenState();
}

class _MESScreenState extends State<MESScreen> {
  List<CellModel> _cells = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    ApiService.getCells().then((c) {
      if (mounted) setState(() { _cells = c; _loading = false; });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgScreen,
      appBar: C9AppBar(
        title: 'MES',
        titleColor: AppColors.bgPage,
        subtitle: 'Shop floor execution · K2 Khalapur · Today',
          headerColor: AppColors.mes
      ),

      body: _loading
          ? const Center(child: CircularProgressIndicator(color: AppColors.modDDMRP))
          : Column(
        children: [
          // Add any widget above the ListView
          // ── Summary stats ─────────────────────────────────
          Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.mes, // background color for the stat row
                borderRadius: BorderRadius.circular(0), // optional rounded corners
              ),
              child:   Row(children: [
            Expanded(child: StatCard(number: '74%', label: 'vs Plan', accentColor: AppColors.zoneAmber)),
            const SizedBox(width: 8),
            Expanded(child: StatCard(number: '18', label: 'Jobs active')),
            const SizedBox(width: 8),
            Expanded(child: StatCard(number: '3', label: 'Delayed', accentColor: AppColors.zoneRedDark)),
          ])),

          // Expanded wraps ListView so it fills remaining space
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              children: [



                const SizedBox(height: 12),

                // ── Cell status ───────────────────────────────────
                const SectionTitle(title: 'Cell status · K2 floor'),
                ..._cells.map((c) => _CellCard(cell: c)),
                const SizedBox(height: 12),

                // ── Active jobs ───────────────────────────────────
                const SectionTitle(title: 'Active jobs · Priority order'),
                _ActiveJob(
                  title: 'SO-4901 Lab Workstation — Fabrication stage',
                  tag: 'CELL-07 · Expedite · Feeds CCR',
                  zone: BufferZone.red,
                ),
                _ActiveJob(
                  title: 'SO-4856 Healthcare Bed Frame — Paint stage',
                  tag: 'Paint Shop · In progress · 68% done',
                  zone: BufferZone.yellow,
                ),
                _ActiveJob(
                  title: 'SO-4821 Office Table Set — Finishing',
                  tag: 'CELL-03 · Dispatch by EOD',
                  zone: BufferZone.green,
                ),
                const SizedBox(height: 12),

                // ── Claude AI ─────────────────────────────────────
                ClaudeAICard(
                  text: 'CELL-07 delay is the single point of failure today. CELL-09 is running above plan and has capacity to absorb 2 of the pending CELL-07 jobs. Re-routing will recover the Paint Shop queue by ~1.5 hours and protect dispatch for SO-4856.',
                  actionLabel: 'Ask Claude about re-routing',
                  onActionTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ClaudeScreen(user: widget.user))),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),

    );
  }
}

class _CellCard extends StatelessWidget {
  final CellModel cell;
  const _CellCard({required this.cell});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 7),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderCard),
      ),
      child: Row(children: [
        Container(
          width: 4, height: 40,
          decoration: BoxDecoration(color: cell.statusColor, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(cell.name, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 2),
          Text(cell.description, style: const TextStyle(fontSize: 10.5, color: AppColors.textMuted)),
        ])),
        Text('${cell.percentOfPlan.toStringAsFixed(0)}%',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700, color: cell.statusColor)),
      ]),
    );
  }
}

class _ActiveJob extends StatelessWidget {
  final String title;
  final String tag;
  final BufferZone zone;

  const _ActiveJob({
    required this.title,
    required this.tag,
    required this.zone,
  });

  @override
  Widget build(BuildContext context) {
    final color = zone == BufferZone.red
        ? AppColors.zoneRed
        : zone == BufferZone.yellow
        ? AppColors.zoneAmber
        : AppColors.zoneGreen;

    final label = zone == BufferZone.red
        ? 'RED'
        : zone == BufferZone.yellow
        ? 'YLW'
        : 'GRN';

    return Container(
      margin: const EdgeInsets.only(bottom: 7),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderCard),
      ),
      child: Row(
        children: [
          // ✅ Left color strip (separate container)
          Container(
            width: 4,
            height: 52,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
          ),

          const SizedBox(width: 10),

          // ✅ Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    tag,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 8),

          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
