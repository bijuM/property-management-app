import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../domain/models/expense.dart';
import '../../domain/models/villa_model.dart';
import '../providers/expense_provider.dart';
import '../providers/villa_provider.dart';

class AddEditExpenseScreen extends ConsumerStatefulWidget {
  final Expense? expense;

  const AddEditExpenseScreen({
    Key? key,
    this.expense,
  }) : super(key: key);

  @override
  ConsumerState<AddEditExpenseScreen> createState() =>
      _AddEditExpenseScreenState();
}

class _AddEditExpenseScreenState extends ConsumerState<AddEditExpenseScreen> {
  static const String _generalExpenseId = '__general_expense__';

  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _paidToController = TextEditingController();
  final _notesController = TextEditingController();

  late String _selectedVillaId;
  late String _selectedCategory;
  late String _selectedPaymentMethod;
  late DateTime _selectedDate;

  bool get _isEditing => widget.expense != null;

  @override
  void initState() {
    super.initState();
    final expense = widget.expense;
    _selectedVillaId = expense?.villaId ?? _generalExpenseId;
    _selectedCategory = expense?.category ?? ExpenseCategories.maintenance;
    _selectedPaymentMethod =
        expense?.paymentMethod ?? ExpensePaymentMethods.cash;
    _selectedDate = expense?.expenseDate ?? DateTime.now();
    _amountController.text =
        expense == null ? '' : expense.amount.toStringAsFixed(0);
    _paidToController.text = expense?.paidTo ?? '';
    _notesController.text = expense?.notes ?? '';
  }

  @override
  void dispose() {
    _amountController.dispose();
    _paidToController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final villasAsync = ref.watch(villasProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFD),
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Expense' : 'Add Expense'),
        elevation: 0,
      ),
      body: villasAsync.when(
        data: (villas) => Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            children: [
              _FormPanel(
                children: [
                  _SectionTitle(
                    title: 'Expense Details',
                    icon: Icons.receipt_long_rounded,
                  ),
                  const SizedBox(height: 18),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedVillaId,
                    decoration: _decoration('Villa'),
                    items: [
                      const DropdownMenuItem(
                        value: _generalExpenseId,
                        child: Text('General Expense'),
                      ),
                      ...villas.map(
                        (villa) => DropdownMenuItem(
                          value: villa.id,
                          child: Text(_villaLabel(villa)),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() => _selectedVillaId = value);
                    },
                  ),
                  const SizedBox(height: 14),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedCategory,
                    decoration: _decoration('Category'),
                    items: ExpenseCategories.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ),
                        )
                        .toList(),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Category is required'
                        : null,
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() => _selectedCategory = value);
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
                  InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: _pickDate,
                    child: InputDecorator(
                      decoration: _decoration('Expense Date'),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(DateFormat('dd MMM yyyy')
                                .format(_selectedDate)),
                          ),
                          const Icon(
                            Icons.calendar_month_rounded,
                            color: Color(0xFFF04438),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _paidToController,
                    decoration: _decoration('Paid To'),
                  ),
                  const SizedBox(height: 14),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedPaymentMethod,
                    decoration: _decoration('Payment Method'),
                    items: ExpensePaymentMethods.values
                        .map(
                          (method) => DropdownMenuItem(
                            value: method,
                            child: Text(method),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() => _selectedPaymentMethod = value);
                    },
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
                onPressed: () => _save(villas),
                icon: const Icon(Icons.check_rounded),
                label: Text(_isEditing ? 'Update Expense' : 'Save Expense'),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFF04438),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ],
          ),
        ),
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
      fillColor: const Color(0xFFFFFBFA),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFF1D6CF)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFF1D6CF)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFF04438), width: 1.5),
      ),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _save(List<VillaModel> villas) async {
    if (!_formKey.currentState!.validate()) return;

    final selectedVilla = _selectedVillaId == _generalExpenseId
        ? null
        : villas.where((villa) => villa.id == _selectedVillaId).firstOrNull;
    final expense = Expense(
      id: widget.expense?.id ?? const Uuid().v4(),
      villaId: selectedVilla?.id,
      villaName:
          selectedVilla == null ? 'General Expense' : selectedVilla.villaName,
      category: _selectedCategory,
      amount: double.parse(_amountController.text.trim()),
      expenseDate: _selectedDate,
      paidTo: _paidToController.text.trim(),
      paymentMethod: _selectedPaymentMethod,
      notes: _notesController.text.trim(),
    );

    final notifier = ref.read(expenseProvider.notifier);
    if (_isEditing) {
      await notifier.updateExpense(expense);
    } else {
      await notifier.addExpense(expense);
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  static String _villaLabel(VillaModel villa) {
    final number =
        villa.villaNumber.trim().isEmpty ? '' : ' #${villa.villaNumber}';
    return '${villa.villaName}$number';
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
        border: Border.all(color: const Color(0xFFF1D6CF)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB42318).withValues(alpha: 0.08),
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
            color: Color(0xFFFFE6E0),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xFFF04438)),
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
