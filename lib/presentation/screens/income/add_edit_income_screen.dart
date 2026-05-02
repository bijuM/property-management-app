import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/app_permissions.dart';
import '../../../domain/models/app_notification.dart';
import '../../../domain/models/income.dart';
import '../../../domain/models/villa_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/income_provider.dart';
import '../../providers/notification_provider.dart';
import '../../providers/villa_provider.dart';

class AddEditIncomeScreen extends ConsumerStatefulWidget {
  final Income? income;

  const AddEditIncomeScreen({
    Key? key,
    this.income,
  }) : super(key: key);

  @override
  ConsumerState<AddEditIncomeScreen> createState() =>
      _AddEditIncomeScreenState();
}

class _AddEditIncomeScreenState extends ConsumerState<AddEditIncomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();

  String? _selectedVillaId;
  late String _selectedIncomeType;
  late String _selectedPaymentMethod;
  late DateTime _paymentDate;
  late DateTime _monthCovered;

  bool get _isEditing => widget.income != null;

  @override
  void initState() {
    super.initState();
    final income = widget.income;
    _selectedVillaId = income?.villaId;
    _selectedIncomeType = income?.incomeType ?? IncomeTypes.rent;
    _selectedPaymentMethod = income?.paymentMethod ?? IncomePaymentMethods.cash;
    _paymentDate = income?.paymentDate ?? DateTime.now();
    _monthCovered = income?.monthCovered ??
        DateTime(DateTime.now().year, DateTime.now().month, 1);
    _amountController.text =
        income == null ? '' : income.amount.toStringAsFixed(0);
    _notesController.text = income?.notes ?? '';
  }

  @override
  void dispose() {
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final villasAsync = ref.watch(villasProvider);
    final controllerState = ref.watch(incomeControllerProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFD),
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Income' : 'Add Income'),
        elevation: 0,
      ),
      body: villasAsync.when(
        data: (villas) {
          final occupiedVillas = villas.where(_isOccupiedVilla).toList();
          final selectedVillaIsOccupied =
              occupiedVillas.any((villa) => villa.id == _selectedVillaId);

          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              children: [
                _FormPanel(
                  children: [
                    const _SectionTitle(
                      title: 'Income Details',
                      icon: Icons.payments_rounded,
                    ),
                    const SizedBox(height: 18),
                    DropdownButtonFormField<String>(
                      initialValue:
                          selectedVillaIsOccupied ? _selectedVillaId : null,
                      decoration: _decoration('Villa'),
                      items: occupiedVillas
                          .map(
                            (villa) => DropdownMenuItem(
                              value: villa.id,
                              child: Text(_villaLabel(villa)),
                            ),
                          )
                          .toList(),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Villa is required'
                          : null,
                      onChanged: (value) {
                        setState(() => _selectedVillaId = value);
                      },
                    ),
                    if (occupiedVillas.isEmpty) ...[
                      const SizedBox(height: 8),
                      const Text(
                        'Income can only be added for occupied villas.',
                        style: TextStyle(
                          color: Color(0xFFF04438),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                    const SizedBox(height: 14),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedIncomeType,
                      decoration: _decoration('Income Type'),
                      items: IncomeTypes.values
                          .map(
                            (type) => DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ),
                          )
                          .toList(),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Income type is required'
                          : null,
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() => _selectedIncomeType = value);
                      },
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _amountController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: _decoration('Amount', prefixText: 'QAR '),
                      validator: (value) {
                        final amount = double.tryParse(value?.trim() ?? '');
                        if (amount == null) return 'Amount is required';
                        if (amount <= 0) return 'Amount must be greater than 0';
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    _DateField(
                      label: 'Payment Date',
                      value: _paymentDate,
                      formatter: DateFormat('dd MMM yyyy'),
                      onTap: () => _pickDate(
                        initialDate: _paymentDate,
                        onPicked: (date) => setState(() => _paymentDate = date),
                      ),
                    ),
                    const SizedBox(height: 14),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedPaymentMethod,
                      decoration: _decoration('Payment Method'),
                      items: IncomePaymentMethods.values
                          .map(
                            (method) => DropdownMenuItem(
                              value: method,
                              child: Text(method),
                            ),
                          )
                          .toList(),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Payment method is required'
                          : null,
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() => _selectedPaymentMethod = value);
                      },
                    ),
                    const SizedBox(height: 14),
                    _DateField(
                      label: 'Month Covered',
                      value: _monthCovered,
                      formatter: DateFormat('MMMM yyyy'),
                      onTap: () => _pickDate(
                        initialDate: _monthCovered,
                        onPicked: (date) => setState(
                          () => _monthCovered =
                              DateTime(date.year, date.month, 1),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _notesController,
                      minLines: 3,
                      maxLines: 5,
                      decoration: _decoration('Notes'),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                FilledButton.icon(
                  onPressed:
                      controllerState.isLoading ? null : () => _save(villas),
                  icon: controllerState.isLoading
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.check_rounded),
                  label: Text(_isEditing ? 'Update Income' : 'Save Income'),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF12B76A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        error: (error, _) => Center(child: Text(error.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  InputDecoration _decoration(String label, {String? prefixText}) {
    return InputDecoration(
      labelText: label,
      prefixText: prefixText,
      filled: true,
      fillColor: const Color(0xFFFBFFFC),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFCDEFD8)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFCDEFD8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFF12B76A), width: 1.5),
      ),
    );
  }

  Future<void> _pickDate({
    required DateTime initialDate,
    required ValueChanged<DateTime> onPicked,
  }) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      onPicked(picked);
    }
  }

  Future<void> _save(List<VillaModel> villas) async {
    if (!_formKey.currentState!.validate()) return;

    final selectedVilla =
        villas.where((villa) => villa.id == _selectedVillaId).firstOrNull;
    if (selectedVilla == null) return;
    if (!_isOccupiedVilla(selectedVilla)) {
      _showMessage('Income can only be added for occupied villas.');
      return;
    }

    final income = Income(
      id: widget.income?.id ?? const Uuid().v4(),
      villaId: selectedVilla.id,
      villaName: selectedVilla.villaName,
      incomeType: _selectedIncomeType,
      amount: double.parse(_amountController.text.trim()),
      paymentDate: _paymentDate,
      paymentMethod: _selectedPaymentMethod,
      monthCovered: DateTime(_monthCovered.year, _monthCovered.month, 1),
      notes: _notesController.text.trim(),
    );

    final controller = ref.read(incomeControllerProvider.notifier);
    if (_isEditing) {
      await controller.updateIncome(income);
    } else {
      await controller.addIncome(income);
      await _createIncomeAddedNotification(income);
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  Future<void> _createIncomeAddedNotification(Income income) async {
    final authState = ref.read(authProvider);
    final currentUser = authState.currentUser;
    if (currentUser == null) return;
    if (!authState.hasPermission(AppPermissions.manageIncome)) return;

    final targetUserIds = authState.users
        .where((user) => user.id != currentUser.id)
        .map((user) => user.id)
        .toList();

    debugPrint('[Notifications] current user id=${currentUser.id}');
    debugPrint('[Notifications] target user ids=$targetUserIds');

    if (targetUserIds.isEmpty) return;

    final notification = AppNotification(
      id: const Uuid().v4(),
      title: 'New income added',
      body:
          'QAR ${_moneyFormat.format(income.amount)} ${income.incomeType.toLowerCase()} added for ${income.villaName} by ${currentUser.username}',
      type: NotificationTypes.incomeAdded,
      createdByUserId: currentUser.id,
      createdByUsername: currentUser.username,
      targetUserIds: targetUserIds,
      targetRole: null,
      createdAt: DateTime.now(),
      isReadMap: {
        for (final userId in targetUserIds) userId: false,
      },
    );

    await ref
        .read(notificationControllerProvider)
        .createNotification(notification);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static String _villaLabel(VillaModel villa) {
    final number =
        villa.villaNumber.trim().isEmpty ? '' : ' #${villa.villaNumber}';
    return '${villa.villaName}$number';
  }

  static bool _isOccupiedVilla(VillaModel villa) {
    return villa.status.name.toLowerCase() == 'occupied';
  }

  static final NumberFormat _moneyFormat = NumberFormat('#,##0.##');
}

class _DateField extends StatelessWidget {
  final String label;
  final DateTime value;
  final DateFormat formatter;
  final VoidCallback onTap;

  const _DateField({
    required this.label,
    required this.value,
    required this.formatter,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: const Color(0xFFFBFFFC),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFCDEFD8)),
          ),
        ),
        child: Row(
          children: [
            Expanded(child: Text(formatter.format(value))),
            const Icon(
              Icons.calendar_month_rounded,
              color: Color(0xFF12B76A),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormPanel extends StatelessWidget {
  final List<Widget> children;

  const _FormPanel({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFCDEFD8)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF067647).withValues(alpha: 0.08),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionTitle({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 38,
          width: 38,
          decoration: const BoxDecoration(
            color: Color(0xFFE4F8EA),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xFF12B76A)),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF060B26),
            fontSize: 19,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

extension _FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull {
    final iterator = this.iterator;
    if (iterator.moveNext()) return iterator.current;
    return null;
  }
}
