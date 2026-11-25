import 'package:material_ui/material_ui.dart';
import 'package:planora/core/calc/planora_calc.dart';
import 'package:planora/core/theme/app_theme.dart';

class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.status});

  final GoalTrackStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      GoalTrackStatus.achieved => ('Tercapai', AppTheme.success),
      GoalTrackStatus.onTrack => ('Di jalur', AppTheme.success),
      GoalTrackStatus.behind => ('Kurang', AppTheme.warning),
      GoalTrackStatus.overdue => ('Terlambat', AppTheme.danger),
      GoalTrackStatus.flexible => ('Fleksibel', AppTheme.textSecondary),
      GoalTrackStatus.noTarget => ('Rutin', AppTheme.bankGreenLight),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

