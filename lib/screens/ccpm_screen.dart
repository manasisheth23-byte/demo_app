// ════════════════════════════════════════════════════════════════
// ccpm_screen.dart
// ════════════════════════════════════════════════════════════════
// (Save as lib/screens/ccpm_screen.dart)

import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/models.dart';
import '../services/api_service.dart';
import '../widgets/common_widgets.dart';
import 'claude_screen.dart';
import 'home_screen.dart';

class CCPMScreen extends StatefulWidget {
  final UserModel user;
  const CCPMScreen({super.key, required this.user});

  @override
  State<CCPMScreen> createState() => _CCPMScreenState();
}

class _CCPMScreenState extends State<CCPMScreen> {
  List<ProjectModel> _projects = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    ApiService.getProjects().then((p) {
      if (mounted) setState(() { _projects = p; _loading = false; });
    });
  }

  @override
  Widget build(BuildContext context) {
    int red = _projects.where((p) => p.zone == FeverZone.red).length;
    int ylw = _projects.where((p) => p.zone == FeverZone.yellow).length;
    int grn = _projects.where((p) => p.zone == FeverZone.green).length;

    return Scaffold(
      backgroundColor: AppColors.bgScreen,
      appBar: AppBar(
        backgroundColor: AppColors.ccpm, // AppBar main color
        title: const Text('CCPM', style: TextStyle(color: Colors.white)),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80), // height of your StatCard row
          child: Container(
            padding: const EdgeInsets.all(12),
            color: AppColors.ccpm, // same background as AppBar
            child: Row(
              children: [
                Expanded(
                  child: StatCard(
                    number: '$red',
                    label: 'Red',
                    accentColor: AppColors.zoneRed,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: StatCard(
                    number: '$ylw',
                    label: 'Yellow',
                    accentColor: AppColors.zoneAmber,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: StatCard(
                    number: '$grn',
                    label: 'Green',
                    accentColor: AppColors.zoneGreen,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: AppColors.modCCPM))
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              children: [


                const SizedBox(height: 12),
                const SectionTitle(title: 'Active projects · Fever chart status'),
                ..._projects.map((p) => _ProjectCard(project: p)),
                const SizedBox(height: 12),
                ClaudeAICard(
                  text: 'Project Phoenix is in critical red — 74% buffer consumed. The delay is concentrated in the Integration Testing task pending resource assignment for 4 days. Recommend escalation to Godrej Interio today and a recovery plan by Monday.',
                  actionLabel: 'Ask about project recovery',
                  onActionTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ClaudeScreen(user: widget.user))),
                ),
                const SizedBox(height: 20),
              ],
            ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final ProjectModel project;
  const _ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          // ✅ LEFT COLORED STRIPE
          Container(
            width: 3,
            decoration: BoxDecoration(
              color: project.zoneColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(0),
                bottomLeft: Radius.circular(0),
              ),
            ),
          ),

          // ✅ MAIN CARD
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.bgCard,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                border: Border.all(
                  color: AppColors.borderCard,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              project.name,
                              style: const TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              '${project.client} · PM: ${project.pm}',
                              style: const TextStyle(
                                fontSize: 10,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: project.zoneColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: project.zoneColor.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          project.zoneLabel,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: project.zoneColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  FeverBar(
                    consumedPercent: project.bufferConsumed,
                  ),

                  const SizedBox(height: 4),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Buffer consumed: ${project.bufferConsumed.toStringAsFixed(0)}%',
                        style: TextStyle(
                          fontSize: 10.5,
                          color: project.zoneColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        project.bufferInfo,
                        style: const TextStyle(
                          fontSize: 10.5,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
