import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/models.dart';
import '../services/api_service.dart';
import '../widgets/common_widgets.dart';
import 'claude_screen.dart';
import 'home_screen.dart';

class ERPScreen extends StatefulWidget {
  final UserModel user;
  const ERPScreen({super.key, required this.user});

  @override
  State<ERPScreen> createState() => _ERPScreenState();
}

class _ERPScreenState extends State<ERPScreen> {
  List<OrderModel> _orders = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    ApiService.getOrders().then((o) {
      if (mounted) setState(() { _orders = o; _loading = false; });
    });
  }

  @override
  Widget build(BuildContext context) {
    final atRisk = _orders.where((o) => o.status == BufferZone.red || o.status == BufferZone.yellow).toList();
    final ready  = _orders.where((o) => o.status == BufferZone.green).toList();

    return Scaffold(
      backgroundColor: AppColors.bgScreen,
      appBar: C9AppBar(
        title: 'ERP',
        titleColor: AppColors.bgPage,
        subtitle: 'Orders · Dispatch · OTD tracking',
          headerColor: AppColors.erp
      ),


      body: _loading
    ? const Center(child: CircularProgressIndicator(color: AppColors.modDDMRP))
        : Column(
    children: [
    // Add any widget above the ListView
      Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.erp, // background color for the stat row
            borderRadius: BorderRadius.circular(0), // optional rounded corners
          ),
          child:    Row(children: [
        Expanded(child: StatCard(number: '47', label: 'Open orders')),
        const SizedBox(width: 8),
        Expanded(child: StatCard(number: '4', label: 'At risk', accentColor: AppColors.zoneAmber)),
        const SizedBox(width: 8),
        Expanded(child: StatCard(number: '8', label: 'Dispatch today', accentColor: AppColors.zoneGreen)),
      ])),

    // Expanded wraps ListView so it fills remaining space
    Expanded(
    child: ListView(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      children: [


        // ── Summary stats ─────────────────────────────────

        const SizedBox(height: 12),

        // ── OTD performance ───────────────────────────────
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderCard),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('84.6% OTD',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.zoneGreen)),
              const Text('Target: 90%',
                  style: TextStyle(fontSize: 10.5, color: AppColors.textMuted)),
            ]),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Stack(children: [
                Container(height: 8, color: AppColors.bgCard),
                FractionallySizedBox(
                  widthFactor: 0.846,
                  child: Container(height: 8, color: AppColors.zoneGreen.withOpacity(0.7)),
                ),
              ]),
            ),
            const SizedBox(height: 6),
            const Text('↓ 5.4% below target — impacted by K2 CCR penetration',
                style: TextStyle(fontSize: 10.5, color: AppColors.zoneAmber)),
          ]),
        ),
        const SizedBox(height: 12),

        // ── At-risk orders ────────────────────────────────
        SectionTitle(
          title: 'At-risk orders',
          badge: '₹18L+ exposure',
          badgeColor: AppColors.zoneRedDark,
        ),
        ...atRisk.map((o) => _OrderCard(order: o)),
        const SizedBox(height: 12),

        // ── Ready for dispatch ────────────────────────────
        const SectionTitle(title: 'Ready for dispatch today'),
        ...ready.map((o) => _OrderCard(order: o)),
        const SizedBox(height: 12),

        // ── Claude AI ─────────────────────────────────────
        ClaudeAICard(
          text: 'OTD at 84.6% is 5.4% below target. Root cause traces entirely to K2 CCR penetration impacting 4 orders. If today\'s re-sequencing recovers SO-4856, OTD recovers to 88.7%. SO-4901 needs escalation to Godrej Interio today.',
          actionLabel: 'Ask about OTD recovery plan',
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

class _OrderCard extends StatelessWidget {
  final OrderModel order;
  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderCard),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(order.customer, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            Text('${order.orderNum} · ${order.plant}',
              style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
          ])),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text('₹${order.valueInLakhs.toStringAsFixed(1)}L',
              style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: AppColors.zoneGreen)),
            const SizedBox(height: 2),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                color: order.statusColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: order.statusColor.withOpacity(0.28)),
              ),
              child: Text(order.statusLabel,
                style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w700, color: order.statusColor)),
            ),
          ]),
        ]),
        const SizedBox(height: 8),
        Text(order.description, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: Stack(children: [
            Container(height: 5, color: AppColors.bgCard),
            FractionallySizedBox(
              widthFactor: order.progressPercent / 100,
              child: Container(height: 5, color: order.statusColor.withOpacity(0.7)),
            ),
          ]),
        ),
        const SizedBox(height: 5),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Promised: ${order.promisedDate}',
            style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
          Text('${order.progressPercent.toStringAsFixed(0)}% complete',
            style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
        ]),
      ]),
    );
  }
}
