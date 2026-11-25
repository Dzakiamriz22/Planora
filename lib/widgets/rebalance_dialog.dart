import 'package:material_ui/material_ui.dart';
import 'package:planora/core/calc/planora_calc.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/core/theme/app_theme.dart';

/// Dialog pratinjau penyeimbangan plafon.
/// Mengembalikan `true` hanya jika pengguna menyetujui secara eksplisit.
Future<bool> showRebalancePreviewDialog(
  BuildContext context, {
  required RebalanceResult result,
  required int ceilingAmount,
  String title = 'Pratinjau Penyesuaian Batas',
  String? subtitle,
}) async {
  if (!result.success) {
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Melebihi Batas Nabung'),
        content: Text(
          result.errorMessage ??
              'Perubahan tidak dapat disimpan karena melebihi batas nabung ${AppFormatters.rupiah(ceilingAmount)}.',
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Mengerti'),
          ),
        ],
      ),
    );
    return false;
  }

  final approved = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                subtitle ??
                    'Perubahan melebihi batas nabung sebesar ${AppFormatters.rupiah(result.excess)}. Porto lain akan diturunkan secara proporsional agar total tetap dalam batas ${AppFormatters.rupiah(ceilingAmount)}.',
                style: const TextStyle(
                  fontSize: 13,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 8),
              ...result.changes.map(
                (c) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          c.name,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            AppFormatters.rupiah(c.oldAmount),
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.textSecondary,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          Text(
                            AppFormatters.rupiah(c.newAmount),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: c.delta >= 0
                                  ? AppTheme.success
                                  : AppTheme.warning,
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
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(false),
          child: const Text('Batal'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(ctx).pop(true),
          child: const Text('Setujui & Simpan'),
        ),
      ],
    ),
  );

  return approved == true;
}
