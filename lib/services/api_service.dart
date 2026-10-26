import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme/app_colors.dart';

/// ApiService — Provides mock data for all modules.
/// Replace each method with a real HTTP call to your backend API.
/// Example: final response = await http.get(Uri.parse('\$baseUrl/ddmrp/buffers'));

class ApiService {
  ApiService._();
  static const String baseUrl = 'https://api.cloud9ebiz.com/v1';

  // ── DDMRP ────────────────────────────────────────────────────

  static Future<List<BufferItemModel>> getBuffers({String plant = 'all'}) async {
    await Future.delayed(const Duration(milliseconds: 400)); // simulate network
    return [
      const BufferItemModel(name: 'MS Pipe Asm 40mm', code: 'MSP-40-GI', cell: 'CELL-07', plant: 'K2', nfpPercent: 12, onHand: 45, onOrder: 0, demandPerDay: 60, coverage: 1.8, zone: BufferZone.red, hasOpenPO: false, trend: '↓'),
      const BufferItemModel(name: 'Fabric Panel Grey', code: 'FPG-900-GR', cell: 'CELL-12', plant: 'K4', nfpPercent: 8, onHand: 12, onOrder: 200, demandPerDay: 85, coverage: 1.2, zone: BufferZone.red, hasOpenPO: true, trend: '↓'),
      const BufferItemModel(name: 'Caster Wheel 75mm', code: 'CW-75-HD', cell: 'CELL-04', plant: 'K3', nfpPercent: 22, onHand: 88, onOrder: 0, demandPerDay: 45, coverage: 2.8, zone: BufferZone.red, hasOpenPO: false, trend: '↓'),
      const BufferItemModel(name: 'SS Bracket L-50', code: 'SSB-L50', cell: 'CELL-03', plant: 'K2', nfpPercent: 38, onHand: 340, onOrder: 150, demandPerDay: 120, coverage: 4.1, zone: BufferZone.yellow, hasOpenPO: true, trend: '↓'),
      const BufferItemModel(name: 'Hinges 35mm Soft-Close', code: 'HNG-35SC', cell: 'CELL-11', plant: 'K4', nfpPercent: 45, onHand: 1200, onOrder: 0, demandPerDay: 400, coverage: 5.2, zone: BufferZone.yellow, hasOpenPO: false, trend: '↓'),
      const BufferItemModel(name: 'Board 18mm Teak', code: 'BRD-18TK', cell: 'CELL-06', plant: 'K3', nfpPercent: 52, onHand: 78, onOrder: 50, demandPerDay: 35, coverage: 6.8, zone: BufferZone.yellow, hasOpenPO: true, trend: '↑'),
      const BufferItemModel(name: 'Drawer Rail 400mm', code: 'DRL-400-FE', cell: 'CELL-09', plant: 'K2', nfpPercent: 41, onHand: 560, onOrder: 200, demandPerDay: 250, coverage: 4.5, zone: BufferZone.yellow, hasOpenPO: true, trend: '→'),
    ];
  }

  static List<double> getBufferTrend7Day() => [2, 2, 3, 2, 3, 3, 3]; // red count per day

  // ── DBR ──────────────────────────────────────────────────────

  static double getCCRPenetration() => 34.0;
  static double getCCRUtilization() => 87.0;
  static int getCCRQueueJobs() => 12;
  static String getCCRName() => 'Paint Shop — K2 Khalapur';

  static List<Map<String, dynamic>> getDrumSchedule() => [
    {'so': 'SO-2024-4821', 'desc': 'Office Table Set', 'progress': 1.0, 'status': 'Complete', 'zone': BufferZone.green},
    {'so': 'SO-2024-4856', 'desc': 'Healthcare Bed Frame', 'progress': 0.68, 'status': '68% done', 'zone': BufferZone.yellow},
    {'so': 'SO-2024-4901', 'desc': 'Lab Workstation', 'progress': 0.22, 'status': 'Delayed', 'zone': BufferZone.red},
    {'so': 'SO-2024-4923', 'desc': 'Executive Chairs ×12', 'progress': 0.0, 'status': 'Queue', 'zone': BufferZone.green},
  ];

  // ── CCPM ─────────────────────────────────────────────────────

  static Future<List<ProjectModel>> getProjects() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const [
      ProjectModel(name: 'Project Phoenix — Godrej ERP', client: 'Godrej Interio', pm: 'Suresh P.', bufferConsumed: 74, zone: FeverZone.red, bufferInfo: 'Buffer −18 days'),
      ProjectModel(name: 'i-tek ERP Phase I', client: 'i-tek', pm: 'Santosh ji', bufferConsumed: 68, zone: FeverZone.red, bufferInfo: 'Phase I — 3 weeks'),
      ProjectModel(name: 'Rishi Laser MES Rollout', client: 'Rishi Laser', pm: 'Team C9', bufferConsumed: 48, zone: FeverZone.yellow, bufferInfo: 'Go-live on track'),
      ProjectModel(name: 'Gufic Biosciences DDMRP', client: 'Gufic Pharma', pm: 'Team C9', bufferConsumed: 28, zone: FeverZone.green, bufferInfo: 'Ahead +5 days'),
    ];
  }

  // ── MES ──────────────────────────────────────────────────────

  static Future<List<CellModel>> getCells() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const [
      CellModel(name: 'CELL-07 — Fabrication', description: '2.5h behind · Feeds Paint Shop CCR', percentOfPlan: 58, status: BufferZone.red),
      CellModel(name: 'CELL-09 — Assembly', description: 'Ahead of plan · Can absorb work', percentOfPlan: 102, status: BufferZone.green),
      CellModel(name: 'Paint Shop — CCR', description: '87% utilization · 34% buffer consumed', percentOfPlan: 87, status: BufferZone.yellow),
      CellModel(name: 'CELL-03 — Finishing', description: 'Normal pace · No issues', percentOfPlan: 96, status: BufferZone.green),
      CellModel(name: 'CELL-12 — Upholstery', description: 'Material shortage risk', percentOfPlan: 71, status: BufferZone.yellow),
    ];
  }

  // ── ERP ──────────────────────────────────────────────────────

  static Future<List<OrderModel>> getOrders() async {
    await Future.delayed(const Duration(milliseconds: 350));
    return const [
      OrderModel(orderNum: 'SO-2024-4901', customer: 'Godrej Interio', description: 'Lab Workstation', valueInLakhs: 4.8, progressPercent: 22, promisedDate: 'Fri 16 May', status: BufferZone.red, plant: 'K2'),
      OrderModel(orderNum: 'SO-2024-4823', customer: 'HDFC Bank', description: 'Office Interiors', valueInLakhs: 7.2, progressPercent: 58, promisedDate: 'Mon 19 May', status: BufferZone.yellow, plant: 'K3'),
      OrderModel(orderNum: 'SO-2024-4856', customer: 'Tata Motors', description: 'Healthcare Beds ×20', valueInLakhs: 6.1, progressPercent: 68, promisedDate: 'Sat 17 May', status: BufferZone.yellow, plant: 'K2'),
      OrderModel(orderNum: 'SO-2024-4821', customer: 'Godrej Interio', description: 'Office Table Set', valueInLakhs: 2.4, progressPercent: 100, promisedDate: 'Fri 16 May', status: BufferZone.green, plant: 'K2'),
      OrderModel(orderNum: 'SO-2024-4799', customer: 'Axis Bank', description: 'Executive Chair Lot', valueInLakhs: 3.8, progressPercent: 100, promisedDate: 'Fri 16 May', status: BufferZone.green, plant: 'K4'),
    ];
  }

  // ── Home Actions (per role) ───────────────────────────────────

  static List<ActionItemModel> getActionsForRole(UserRole role) {
    switch (role) {
      case UserRole.ceo:
        return const [
          ActionItemModel(priority: 1, module: 'DDMRP', moduleBg: Color(0xFF042C53), moduleFg: Color(0xFF85B7EB), title: 'MS Pipe Asm 40mm exhausts in 1.8 days', tag: 'K2 · No PO raised · Critical', isCritical: true, route: '/ddmrp'),
          ActionItemModel(priority: 2, module: 'DBR', moduleBg: Color(0xFF04342C), moduleFg: Color(0xFF5DCAA5), title: 'Paint Shop CCR buffer at 34% penetration', tag: 'K2 Khalapur · Escalate to Director', isCritical: true, route: '/dbr'),
          ActionItemModel(priority: 3, module: 'CCPM', moduleBg: Color(0xFF173404), moduleFg: Color(0xFF97C459), title: 'Project Phoenix entering red zone', tag: 'Godrej Interio · Buffer −18 days', isCritical: false, route: '/ccpm'),
          ActionItemModel(priority: 4, module: 'ERP', moduleBg: Color(0xFF412402), moduleFg: Color(0xFFEF9F27), title: '4 customer orders at OTD risk — ₹18L', tag: 'Dispatch window closes Thursday', isCritical: false, route: '/erp'),
        ];
      case UserRole.director:
        return const [
          ActionItemModel(priority: 1, module: 'DBR', moduleBg: Color(0xFF04342C), moduleFg: Color(0xFF5DCAA5), title: 'Paint Shop CCR buffer 34% penetrated', tag: 'K2 · Re-sequence drum today', isCritical: true, route: '/dbr'),
          ActionItemModel(priority: 2, module: 'DDMRP', moduleBg: Color(0xFF042C53), moduleFg: Color(0xFF85B7EB), title: '2 red-zone components — no open PO', tag: 'K2 & K3 · Procurement call now', isCritical: true, route: '/ddmrp'),
          ActionItemModel(priority: 3, module: 'MES', moduleBg: Color(0xFF26215C), moduleFg: Color(0xFFAFA9EC), title: 'K3 shop floor at 74% of plan today', tag: 'CELL-04 delay · Feeds K3 dispatch', isCritical: false, route: '/mes'),
          ActionItemModel(priority: 4, module: 'ERP', moduleBg: Color(0xFF412402), moduleFg: Color(0xFFEF9F27), title: '2 customer orders at delivery risk', tag: 'Confirm by 3 PM today', isCritical: false, route: '/erp'),
        ];
      case UserRole.plantHead:
        return const [
          ActionItemModel(priority: 1, module: 'DBR', moduleBg: Color(0xFF04342C), moduleFg: Color(0xFF5DCAA5), title: 'Paint Shop buffer 34% penetrated — re-sequence now', tag: 'CCR · Immediate action required', isCritical: true, route: '/dbr'),
          ActionItemModel(priority: 2, module: 'DDMRP', moduleBg: Color(0xFF042C53), moduleFg: Color(0xFF85B7EB), title: 'MS Pipe Asm 40mm exhausts in 1.8 days', tag: 'No PO raised · Escalate now', isCritical: true, route: '/ddmrp'),
          ActionItemModel(priority: 3, module: 'MES', moduleBg: Color(0xFF26215C), moduleFg: Color(0xFFAFA9EC), title: 'CELL-07 running 2.5h behind plan', tag: 'Feeds Paint Shop · Clear by 2 PM', isCritical: false, route: '/mes'),
          ActionItemModel(priority: 4, module: 'DBR', moduleBg: Color(0xFF04342C), moduleFg: Color(0xFF5DCAA5), title: '5 jobs in red buffer zone', tag: '3 are dispatch-critical today', isCritical: false, route: '/dbr'),
        ];
    }
  }

  static List<ModuleStatusModel> getModulesForRole(UserRole role) {
    if (role == UserRole.ceo) {
      return const [
        ModuleStatusModel(name: 'CCPM', status: BufferZone.yellow, statusLabel: '2 red', route: '/ccpm'),
        ModuleStatusModel(name: 'DDMRP', status: BufferZone.red, statusLabel: '3 red', route: '/ddmrp'),
        ModuleStatusModel(name: 'DBR', status: BufferZone.red, statusLabel: '34% pen.', route: '/dbr'),
        ModuleStatusModel(name: 'MES', status: BufferZone.yellow, statusLabel: '74% plan', route: '/mes'),
        ModuleStatusModel(name: 'ERP', status: BufferZone.yellow, statusLabel: '4 risk', route: '/erp'),
      ];
    } else if (role == UserRole.director) {
      return const [
        ModuleStatusModel(name: 'DDMRP', status: BufferZone.red, statusLabel: '3 red', route: '/ddmrp'),
        ModuleStatusModel(name: 'DBR', status: BufferZone.red, statusLabel: '1 crit', route: '/dbr'),
        ModuleStatusModel(name: 'MES', status: BufferZone.yellow, statusLabel: '74% plan', route: '/mes'),
        ModuleStatusModel(name: 'ERP', status: BufferZone.yellow, statusLabel: '2 risk', route: '/erp'),
      ];
    } else {
      return const [
        ModuleStatusModel(name: 'DBR', status: BufferZone.red, statusLabel: '5 jobs', route: '/dbr'),
        ModuleStatusModel(name: 'DDMRP', status: BufferZone.red, statusLabel: '1 crit', route: '/ddmrp'),
        ModuleStatusModel(name: 'MES', status: BufferZone.yellow, statusLabel: 'CELL-07', route: '/mes'),
        ModuleStatusModel(name: 'ERP', status: BufferZone.green, statusLabel: 'On track', route: '/erp'),
      ];
    }
  }

  static String getBriefingForRole(UserRole role) {
    switch (role) {
      case UserRole.ceo:
        return 'Your most urgent action is the K2 supply situation. Two components exhaust before new POs can arrive without expediting — directly threatening the Paint Shop CCR, already at 34% penetration. Recommend a procurement escalation call before 11 AM.';
      case UserRole.director:
        return 'The Paint Shop constraint is under pressure. With supply at risk and the CCR buffer already penetrated, consider re-sequencing the drum to work with available material today and protect committed deliveries.';
      case UserRole.plantHead:
        return "CELL-07 delay is feeding into the Paint Shop queue. If pre-paint assembly does not clear by 2 PM, 3 priority orders miss today's dispatch. Consider re-routing work from CELL-09 which is running ahead of plan.";
    }
  }
}
