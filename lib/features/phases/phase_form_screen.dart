import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:planora/core/calc/planora_calc.dart';
import 'package:planora/core/constants/portfolio_palette.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/core/theme/app_theme.dart';
import 'package:planora/core/theme/planora_colors.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/repositories/phase_repository.dart';
import 'package:planora/features/shared/planora_providers.dart';
import 'package:planora/widgets/planora_widgets.dart';
import 'package:planora/widgets/rupiah_text_field.dart';

class PhaseFormScreen extends ConsumerStatefulWidget {
  const PhaseFormScreen({super.key, this.phaseId});

  final String? phaseId;

  @override
  ConsumerState<PhaseFormScreen> createState() => _PhaseFormScreenState();
}

class _PhaseFormScreenState extends ConsumerState<PhaseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final Map<String, TextEditingController> _allocCtrls = {};
  bool _initialized = false;
  bool _saving = false;
  bool _isEditingActivePhase = false;
  String? _validationError;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    for (final c in _allocCtrls.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _init(
    List<Portfolio> portfolios,
    List<PhaseWithAllocations> allPhases,
  ) {
    if (_initialized) return;
    _initialized = true;

    final existing = widget.phaseId == null
        ? null
        : allPhases.where((p) => p.phase.id == widget.phaseId).firstOrNull;

    if (existing != null) {
      _nameCtrl.text = existing.phase.name;
      _descCtrl.text = existing.phase.description ?? '';
      _isEditingActivePhase = existing.phase.isActive;
    }

    for (final porto in portfolios) {
      final initial = existing?.allocations[porto.id] ?? 0;
      _allocCtrls[porto.id] = TextEditingController(
        text: initial > 0 ? AppFormatters.number(initial) : '0',
      );
    }
  }

  PhaseValidationResult _validateNow(
    List<Portfolio> portfolios,
    FinancialSummary summary,
  ) {
    final inputs = portfolios
        .map(
          (p) => PhaseAllocationInput(
            portfolioId: p.id,
            portfolioName: p.name,
            monthlyAmount: parseRupiahInput(_allocCtrls[p.id]?.text ?? ''),
          ),
        )
        .toList();
    return PlanoraCalc.validatePhaseAllocations(
      allocations: inputs,
      ceilingAmount: summary.ceiling,
      phaseLimitEnabled: summary.phaseLimitEnabled,
      phaseLimitAmount: summary.phaseLimitAmount,
    );
  }

  Future<void> _submit({required bool saveAsNew}) async {
    if (!_formKey.currentState!.validate()) return;
    final portfolios = ref.read(portfoliosStreamProvider).value ?? const [];
    final summary = ref.read(financialSummaryProvider);

    final validation = _validateNow(portfolios, summary);
    if (!validation.isValid) {
      setState(() => _validationError = validation.errorMessage);
      return;
    }

    setState(() {
      _validationError = null;
      _saving = true;
    });

    try {
      final allocMap = {
        for (final p in portfolios)
          p.id: parseRupiahInput(_allocCtrls[p.id]?.text ?? ''),
      };
      await ref.read(phaseRepositoryProvider).savePhase(
            id: saveAsNew ? null : widget.phaseId,
            name: _nameCtrl.text.trim(),
            description: _descCtrl.text.trim(),
            allocationsByPortfolioId: allocMap,
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              saveAsNew
                  ? 'Disimpan sebagai fase baru "${_nameCtrl.text.trim()}".'
                  : 'Perubahan fase berhasil disimpan.',
            ),
          ),
        );
        context.pop();
      }
    } catch (e) {
      setState(() => _validationError = e.toString());
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _duplicate() async {
    if (widget.phaseId == null) return;
    final newId =
        await ref.read(phaseRepositoryProvider).duplicatePhase(widget.phaseId!);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fase berhasil diduplikat.')),
      );
      context.pushReplacement('/phases/$newId/edit');
    }
  }

  Future<void> _delete() async {
    if (widget.phaseId == null || _isEditingActivePhase) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Fase?'),
        content: Text(
          'Fase "${_nameCtrl.text.trim()}" beserta seluruh alokasinya akan dihapus permanen.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Batal'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: PlanoraColors.danger),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    await ref.read(phaseRepositoryProvider).deletePhase(widget.phaseId!);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final portfolios = ref.watch(portfoliosStreamProvider).value ?? const [];
    final allPhases = ref.watch(phasesWithAllocationsProvider);
    final summary = ref.watch(financialSummaryProvider);
    _init(portfolios, allPhases);

    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isEdit = widget.phaseId != null;

    final liveValidation = _validateNow(portfolios, summary);
    final ceiling = summary.ceiling;
    final overCeiling =
        ceiling != null && liveValidation.totalAmount > ceiling;
    final exactCeiling =
        ceiling != null && liveValidation.totalAmount == ceiling;

    final limitViolator = (summary.phaseLimitEnabled &&
            summary.phaseLimitAmount != null)
        ? portfolios
            .where(
              (p) =>
                  parseRupiahInput(_allocCtrls[p.id]?.text ?? '') >
                  summary.phaseLimitAmount!,
            )
            .firstOrNull
        : null;

    final segments = portfolios
        .map(
          (p) => AllocationBarSegment(
            amount: parseRupiahInput(_allocCtrls[p.id]?.text ?? ''),
            color: Color(p.color),
          ),
        )
        .toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 6),
              child: Row(
                children: [
                  PlanoraAppBarIconButton(
                    icon: Icons.chevron_left_rounded,
                    tooltip: 'Kembali',
                    onPressed: () => context.pop(),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      isEdit ? 'Edit Fase' : 'Buat Fase Baru',
                      style: AppTheme.sora(
                        size: 17,
                        weight: FontWeight.w800,
                        color: cs.onSurface,
                      ),
                    ),
                  ),
                  if (_isEditingActivePhase) PlanoraPill.yellow('Fase Aktif'),
                ],
              ),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
                  children: [
                    if (_isEditingActivePhase) ...[
                      PlanoraNoteBox(
                        isWarning: true,
                        child: Text(
                          'Mengedit fase aktif tidak langsung mengubah setoran porto berjalan sampai fase ini diterapkan lagi.',
                          style: AppTheme.manrope(
                            size: 11.5,
                            color: cs.onSurface,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        'NAMA FASE',
                        style: AppTheme.uppercaseLabel(
                          color: PlanoraColors.inkMuted,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _nameCtrl,
                      style: AppTheme.manrope(
                        size: 14,
                        weight: FontWeight.w600,
                        color: cs.onSurface,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Contoh: Fase Fokus Darurat',
                      ),
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Nama fase wajib diisi.'
                          : null,
                    ),
                    const SizedBox(height: 14),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        'DESKRIPSI',
                        style: AppTheme.uppercaseLabel(
                          color: PlanoraColors.inkMuted,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _descCtrl,
                      maxLines: 2,
                      style: AppTheme.manrope(
                        size: 13.5,
                        color: cs.onSurface,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Deskripsi singkat tujuan fase ini',
                      ),
                    ),
                    const SizedBox(height: 14),
                    PlanoraCard(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      child: portfolios.isEmpty
                          ? Text(
                              'Belum ada porto. Buat porto terlebih dahulu untuk mengisi alokasi.',
                              style: AppTheme.manrope(
                                size: 12,
                                color: cs.onSurfaceVariant,
                              ),
                            )
                          : Column(
                              children: [
                                for (var i = 0; i < portfolios.length; i++) ...[
                                  if (i > 0) const SizedBox(height: 10),
                                  _AllocationEditableRow(
                                    portfolio: portfolios[i],
                                    controller: _allocCtrls[portfolios[i].id]!,
                                    onChanged: () => setState(() {}),
                                  ),
                                ],
                              ],
                            ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Alokasi',
                          style: AppTheme.manrope(
                            size: 12.5,
                            weight: FontWeight.w700,
                            color: cs.onSurface,
                          ),
                        ),
                        Text(
                          ceiling != null
                              ? '${AppFormatters.rupiah(liveValidation.totalAmount)} / ${AppFormatters.rupiah(ceiling)}'
                              : AppFormatters.rupiah(liveValidation.totalAmount),
                          style: AppTheme.manrope(
                            size: 12.5,
                            weight: FontWeight.w800,
                            color: overCeiling
                                ? PlanoraColors.danger
                                : cs.onSurface,
                            tabular: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    StackedAllocationBar(segments: segments, height: 10),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        if (ceiling == null)
                          PlanoraPill.gray('Batas belum diatur')
                        else if (overCeiling)
                          PlanoraPill.danger(
                            'Melebihi batas (${AppFormatters.rupiah(liveValidation.totalAmount - ceiling)})',
                            icon: Icons.error_outline,
                          )
                        else
                          PlanoraPill.green(
                            exactCeiling ? 'Pas batas' : 'Dalam batas',
                            icon: Icons.check,
                          ),
                        if (summary.phaseLimitEnabled &&
                            summary.phaseLimitAmount != null)
                          limitViolator == null
                              ? PlanoraPill.green(
                                  'Semua porto ≤ ${AppFormatters.rupiah(summary.phaseLimitAmount!)}',
                                  icon: Icons.check,
                                )
                              : PlanoraPill.danger(
                                  '${limitViolator.name} > ${AppFormatters.rupiah(summary.phaseLimitAmount!)}',
                                  icon: Icons.error_outline,
                                ),
                      ],
                    ),
                    if (_validationError != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        _validationError!,
                        style: AppTheme.manrope(
                          size: 12,
                          weight: FontWeight.w700,
                          color: PlanoraColors.danger,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border(
                  top: BorderSide(
                    color: isDark
                        ? PlanoraColors.darkBorder
                        : PlanoraColors.cardBorder,
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FilledButton(
                    onPressed: (_saving || !liveValidation.isValid)
                        ? null
                        : () => _submit(saveAsNew: false),
                    child: Text(isEdit ? 'Simpan Perubahan' : 'Simpan Fase'),
                  ),
                  if (isEdit) ...[
                    const SizedBox(height: 8),
                    OutlinedButton(
                      onPressed: (_saving || !liveValidation.isValid)
                          ? null
                          : () => _submit(saveAsNew: true),
                      child: const Text('Simpan sebagai Fase Baru'),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: cs.onSurface,
                          ),
                          onPressed: _saving ? null : _duplicate,
                          child: const Text('Duplikat Fase'),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: _isEditingActivePhase
                                ? cs.onSurfaceVariant
                                : PlanoraColors.danger,
                          ),
                          onPressed: _saving
                              ? null
                              : (_isEditingActivePhase
                                  ? () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Fase aktif tidak bisa dihapus. Aktifkan fase lain terlebih dahulu.',
                                          ),
                                        ),
                                      );
                                    }
                                  : _delete),
                          child: const Text('Hapus Fase'),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AllocationEditableRow extends StatelessWidget {
  const _AllocationEditableRow({
    required this.portfolio,
    required this.controller,
    required this.onChanged,
  });

  final Portfolio portfolio;
  final TextEditingController controller;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final platformLabel = PortfolioPalette.displayPlatform(
      portfolio.platformPreset,
      portfolio.platformName,
    );

    return Row(
      children: [
        PortfolioDot(color: Color(portfolio.color)),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                portfolio.name,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.manrope(
                  size: 13,
                  weight: FontWeight.w800,
                  color: cs.onSurface,
                ),
              ),
              if (portfolio.platformPreset != null ||
                  (portfolio.platformName != null &&
                      portfolio.platformName!.isNotEmpty))
                Text(
                  platformLabel,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.manrope(
                    size: 11,
                    color: cs.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 112,
          child: TextFormField(
            controller: controller,
            textAlign: TextAlign.right,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              RupiahInputFormatter(),
            ],
            onChanged: (_) => onChanged(),
            style: AppTheme.manrope(
              size: 13,
              weight: FontWeight.w800,
              color: cs.onSurface,
              tabular: true,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 9,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: BorderSide(
                  color: isDark
                      ? PlanoraColors.darkBorder
                      : PlanoraColors.inputBorder,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: BorderSide(
                  color: isDark
                      ? PlanoraColors.darkBorder
                      : PlanoraColors.inputBorder,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: const BorderSide(
                  color: PlanoraColors.primary,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
