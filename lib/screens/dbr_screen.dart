import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/models.dart';
import '../services/api_service.dart';
import '../widgets/common_widgets.dart';
import 'claude_screen.dart';
import 'home_screen.dart';

class DBRScreen extends StatelessWidget {
  final UserModel user;
  const DBRScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final schedule = ApiService.getDrumSchedule();
    final penetration = ApiService.getCCRPenetration();
    final utilization = ApiService.getCCRUtilization();
    final queueJobs   = ApiService.getCCRQueueJobs();

    return Scaffold(
      backgroundColor: AppColors.bgPage,
      appBar: C9AppBar(

        title: 'DBR',
        titleColor: AppColors.bgPage,
        subtitle: 'Drum-Buffer-Rope · K2 Khalapur',
        trailing: const PillSelector(label: 'K2 ▾'),
          headerColor: AppColors.dbr
      ),
      body:
      Column(
    children: [
    // Add any widget above the ListView
      Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.dbr, // background color for the stat row
            borderRadius: BorderRadius.circular(0), // optional rounded corners
          ),
          child:   Row(children: [
        _CCRStat(value: '${penetration.toStringAsFixed(0)}%', label: 'Buffer penetration', color: AppColors.zoneRed),
        const SizedBox(width: 12),
        _CCRStat(value: '${utilization.toStringAsFixed(0)}%', label: 'Utilization today', color: AppColors.zoneAmber),
        const SizedBox(width: 12),
        _CCRStat(value: '$queueJobs', label: 'Jobs in queue', color: AppColors.zoneGreen),
      ])),

    // Expanded wraps ListView so it fills remaining space
    Expanded(
    child: ListView(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      children: [
        const SizedBox(height: 12),

        // ── CCR Card ────────────────────────────────────────
        Container(
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.borderCard),
          ),
          padding: const EdgeInsets.all(14),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('DRUM / CCR',
                style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w700, color: AppColors.textMuted, letterSpacing: 0.8)),
            const SizedBox(height: 4),
            const Text('Paint Shop — K2 Khalapur',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 12),

            // Three stats
            Row(children: [
              _CCRStat(value: '${penetration.toStringAsFixed(0)}%', label: 'Buffer penetration', color: AppColors.zoneRed),
              const SizedBox(width: 12),
              _CCRStat(value: '${utilization.toStringAsFixed(0)}%', label: 'Utilization today', color: AppColors.zoneAmber),
              const SizedBox(width: 12),
              _CCRStat(value: '$queueJobs', label: 'Jobs in queue', color: AppColors.zoneGreen),
            ]),
            const SizedBox(height: 12),

            const Text('BUFFER PENETRATION',
                style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w700, color: AppColors.textMuted, letterSpacing: 0.8)),
            const SizedBox(height: 5),

            // Penetration bar
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Stack(children: [
                Container(height: 12, color: AppColors.bgCard),
                FractionallySizedBox(
                  widthFactor: penetration / 100,
                  child: Container(
                    height: 12,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.zoneGreen, AppColors.zoneAmber, AppColors.zoneRed],
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 4),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('0% Protected', style: TextStyle(fontSize: 9.5, color: AppColors.textMuted)),
              Text('${penetration.toStringAsFixed(0)}% Current',
                  style: const TextStyle(fontSize: 9.5, color: AppColors.zoneRed, fontWeight: FontWeight.w700)),
              const Text('100% Exhausted', style: TextStyle(fontSize: 9.5, color: AppColors.textMuted)),
            ]),
            const SizedBox(height: 12),

            // Warning
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.zoneRed.withOpacity(0.10),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.zoneRed.withOpacity(0.25)),
              ),
              child: const Text(
                '⚠  At current pace, 3 committed orders will miss dispatch without schedule re-sequencing.',
                style: TextStyle(fontSize: 11.5, color: AppColors.textPrimary),
              ),
            ),
          ]),
        ),
        const SizedBox(height: 12),

        // ── Today's drum schedule ────────────────────────────
        const SectionTitle(title: "Today's drum schedule"),
        Container(
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderCard),
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            children: schedule.map((s) => _ScheduleItem(data: s)).toList(),
          ),
        ),
        const SizedBox(height: 12),

        // ── Jobs in red buffer zone ──────────────────────────
        const SectionTitle(title: 'Jobs in red buffer zone', badge: '5', badgeColor: AppColors.zoneRed),
        _JobItem(title: 'SO-4901 Lab Workstation — paint stage overdue', tag: 'CELL-07 delay feeding CCR · Expedite tag required', isCritical: true),
        _JobItem(title: 'SO-4856 Healthcare Bed — buffer 68% consumed', tag: 'On track but watch — no slack left', isCritical: false),
        _JobItem(title: 'SO-4788 Office Table ×8 — pre-paint delayed', tag: 'MS Pipe shortage impacting assembly', isCritical: true),
        const SizedBox(height: 12),

        // ── Claude AI ─────────────────────────────────────────
        ClaudeAICard(
          text: 'The Paint Shop buffer penetration of 34% is directly caused by CELL-07 falling 2.5 hours behind due to MS Pipe shortage. Re-sequencing SO-4921 ahead of SO-4901 will protect the CCR and recover 2 of the 3 at-risk orders today.',
          actionLabel: 'Ask Claude to simulate re-sequence',
          onActionTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ClaudeScreen(user: user))),
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

class _CCRStat extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  const _CCRStat({required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(children: [
        Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: color)),
        Text(label, style: const TextStyle(fontSize: 9.5, color: AppColors.textMuted), textAlign: TextAlign.center),
      ]),
    );
  }
}

class _ScheduleItem extends StatelessWidget {
  final Map<String, dynamic> data;
  const _ScheduleItem({required this.data});

  @override
  Widget build(BuildContext context) {
    final zone = data['zone'] as BufferZone;
    final progress = data['progress'] as double;
    Color barColor = zone == BufferZone.red ? AppColors.zoneRed
        : zone == BufferZone.yellow ? AppColors.zoneAmber : AppColors.zoneGreen;
    String status = data['status'] as String;
    Color statusColor = zone == BufferZone.red ? AppColors.zoneRed
        : zone == BufferZone.yellow ? AppColors.zoneAmber : AppColors.zoneGreen;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child: Text('${data['so']} · ${data['desc']}',
              style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
              overflow: TextOverflow.ellipsis),
          ),
          Text(status, style: TextStyle(fontSize: 10.5, color: statusColor, fontWeight: FontWeight.w600)),
        ]),
        const SizedBox(height: 3),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Stack(children: [
            Container(height: 8, color: AppColors.bgCard),
            FractionallySizedBox(
              widthFactor: progress,
              child: Container(height: 8, color: barColor.withOpacity(0.7)),
            ),
          ]),
        ),
      ]),
    );
  }
}

class _JobItem extends StatelessWidget {
  final String title;
  final String tag;
  final bool isCritical;

  const _JobItem({
    required this.title,
    required this.tag,
    required this.isCritical,
  });

  @override
  Widget build(BuildContext context) {
    final bc = isCritical ? AppColors.zoneRed : AppColors.zoneAmber;

    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            border: Border(
              left: BorderSide(color: bc, width: 2.5),
              top: const BorderSide(color: AppColors.borderCard),
              right: const BorderSide(color: AppColors.borderCard),
              bottom: const BorderSide(color: AppColors.borderCard),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
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
    );
  }
}
