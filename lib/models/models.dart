import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

// ════════════════════════════════════════════════════════
// ENUMS
// ════════════════════════════════════════════════════════

enum UserRole { ceo, director, plantHead }
enum BufferZone { red, yellow, green }
enum FeverZone { red, yellow, green }

// ════════════════════════════════════════════════════════
// USER MODEL
// ════════════════════════════════════════════════════════

class UserModel {
  final String name;
  final String firstName;
  final String initials;
  final UserRole role;
  final String roleTitle;
  final String scope;
  final Color avatarBg;
  final Color avatarFg;
  final int exceptionCount;
  final String exceptionSub;

  const UserModel({
    required this.name,
    required this.firstName,
    required this.initials,
    required this.role,
    required this.roleTitle,
    required this.scope,
    required this.avatarBg,
    required this.avatarFg,
    required this.exceptionCount,
    required this.exceptionSub,
  });

  static const UserModel ceo = UserModel(
    name: 'Rajesh Mehta',
    firstName: 'Rajesh',
    initials: 'RM',
    role: UserRole.ceo,
    roleTitle: 'Chief Executive Officer',
    scope: 'All plants · All modules',
   avatarBg: AppColors.badgeRedBg,
    avatarFg: AppColors.c9Green,
    exceptionCount: 6,
    exceptionSub: 'Across all plants · Fri 16 May',
  );

  static const UserModel director = UserModel(
    name: 'Suresh Patil',
    firstName: 'Suresh',
    initials: 'SP',
    role: UserRole.director,
    roleTitle: 'Plant Director — Khalapur',
    scope: 'K2, K3, K4 · Khalapur complex',
    avatarBg: AppColors.badgeRedBg,
    avatarFg: AppColors.c9Blue,
    exceptionCount: 5,
    exceptionSub: 'Across K2, K3, K4 · Fri 16 May',
  );

  static const UserModel plantHead = UserModel(
    name: 'Farhan Sheikh',
    firstName: 'Farhan',
    initials: 'FS',
    role: UserRole.plantHead,
    roleTitle: 'Plant Head — K2, Khalapur',
    scope: 'Plant K2 · Khalapur facility',
   avatarBg: AppColors.badgeRedBg,
    avatarFg: AppColors.zoneRed,
    exceptionCount: 4,
    exceptionSub: 'Plant K2 only · Fri 16 May',
  );
}

// ════════════════════════════════════════════════════════
// MODULE STATUS MODEL
// ════════════════════════════════════════════════════════

class ModuleStatusModel {
  final String name;
  final BufferZone status;
  final String statusLabel;
  final String route;

  const ModuleStatusModel({
    required this.name,
    required this.status,
    required this.statusLabel,
    required this.route,
  });

  Color get dotColor {
    switch (status) {
      case BufferZone.red: return AppColors.zoneRed;
      case BufferZone.yellow: return AppColors.zoneAmber;
      case BufferZone.green: return AppColors.zoneGreen;
    }
  }
}

// ════════════════════════════════════════════════════════
// ACTION ITEM MODEL
// ════════════════════════════════════════════════════════

class ActionItemModel {
  final int priority;
  final String module;
  final Color moduleBg;
  final Color moduleFg;
  final String title;
  final String tag;
  final bool isCritical;
  final String route;

  const ActionItemModel({
    required this.priority,
    required this.module,
    required this.moduleBg,
    required this.moduleFg,
    required this.title,
    required this.tag,
    required this.isCritical,
    this.route = '',
  });
}

// ════════════════════════════════════════════════════════
// BUFFER ITEM MODEL (DDMRP)
// ════════════════════════════════════════════════════════

class BufferItemModel {
  final String name;
  final String code;
  final String cell;
  final String plant;
  final double nfpPercent;
  final int onHand;
  final int onOrder;
  final double demandPerDay;
  final double coverage;
  final BufferZone zone;
  final bool hasOpenPO;
  final String trend; // '↓', '↑', '→'

  const BufferItemModel({
    required this.name,
    required this.code,
    required this.cell,
    required this.plant,
    required this.nfpPercent,
    required this.onHand,
    required this.onOrder,
    required this.demandPerDay,
    required this.coverage,
    required this.zone,
    required this.hasOpenPO,
    this.trend = '→',
  });

  Color get zoneColor {
    switch (zone) {
      case BufferZone.red: return AppColors.zoneRed;
      case BufferZone.yellow: return AppColors.zoneAmber;
      case BufferZone.green: return AppColors.zoneGreen;
    }
  }

  String get actionLabel {
    if (zone == BufferZone.red) return hasOpenPO ? 'Expedite' : 'Raise PO';
    if (zone == BufferZone.yellow) return 'Monitor';
    return 'OK';
  }
}

// ════════════════════════════════════════════════════════
// PROJECT MODEL (CCPM)
// ════════════════════════════════════════════════════════

class ProjectModel {
  final String name;
  final String client;
  final String pm;
  final double bufferConsumed;
  final FeverZone zone;
  final String bufferInfo;

  const ProjectModel({
    required this.name,
    required this.client,
    required this.pm,
    required this.bufferConsumed,
    required this.zone,
    required this.bufferInfo,
  });

  Color get zoneColor {
    switch (zone) {
      case FeverZone.red: return AppColors.zoneRed;
      case FeverZone.yellow: return AppColors.zoneAmber;
      case FeverZone.green: return AppColors.zoneGreen;
    }
  }

  String get zoneLabel {
    switch (zone) {
      case FeverZone.red: return 'RED';
      case FeverZone.yellow: return 'YLW';
      case FeverZone.green: return 'GRN';
    }
  }
}

// ════════════════════════════════════════════════════════
// CELL MODEL (MES)
// ════════════════════════════════════════════════════════

class CellModel {
  final String name;
  final String description;
  final double percentOfPlan;
  final BufferZone status;

  const CellModel({
    required this.name,
    required this.description,
    required this.percentOfPlan,
    required this.status,
  });

  Color get statusColor {
    switch (status) {
      case BufferZone.red: return AppColors.zoneRed;
      case BufferZone.yellow: return AppColors.zoneAmber;
      case BufferZone.green: return AppColors.zoneGreen;
    }
  }
}

// ════════════════════════════════════════════════════════
// ORDER MODEL (ERP)
// ════════════════════════════════════════════════════════

class OrderModel {
  final String orderNum;
  final String customer;
  final String description;
  final double valueInLakhs;
  final double progressPercent;
  final String promisedDate;
  final BufferZone status;
  final String plant;

  const OrderModel({
    required this.orderNum,
    required this.customer,
    required this.description,
    required this.valueInLakhs,
    required this.progressPercent,
    required this.promisedDate,
    required this.status,
    required this.plant,
  });

  String get statusLabel {
    switch (status) {
      case BufferZone.red: return 'At risk';
      case BufferZone.yellow: return 'Watch';
      case BufferZone.green: return 'Ready';
    }
  }

  Color get statusColor {
    switch (status) {
      case BufferZone.red: return AppColors.zoneRed;
      case BufferZone.yellow: return AppColors.zoneAmber;
      case BufferZone.green: return AppColors.zoneGreen;
    }
  }
}

// ════════════════════════════════════════════════════════
// CHAT MESSAGE MODEL (Claude AI)
// ════════════════════════════════════════════════════════

class ChatMessage {
  final String content;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.content,
    required this.isUser,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}
