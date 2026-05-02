import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/constants/enums.dart';
import '../../domain/models/villa_model.dart';
import '../providers/villa_provider.dart';
import '../widgets/app_text_field.dart';
import '../widgets/app_date_picker_field.dart';
import '../widgets/app_dropdown.dart';

class AddEditVillaScreen extends ConsumerStatefulWidget {
  final VillaModel? villa;

  const AddEditVillaScreen({Key? key, this.villa}) : super(key: key);

  @override
  ConsumerState<AddEditVillaScreen> createState() => _AddEditVillaScreenState();
}

class _AddEditVillaScreenState extends ConsumerState<AddEditVillaScreen> {
  late TextEditingController _villaNameController;
  late TextEditingController _villaNumberController;
  late TextEditingController _locationController;
  late TextEditingController _tenantNameController;
  late TextEditingController _tenantPhoneController;
  late TextEditingController _monthlyRentController;
  late DateTime _contractStartDate;
  late DateTime _contractEndDate;
  late int _paymentDueDay;
  late VillaStatus _status;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.villa != null) {
      _villaNameController =
          TextEditingController(text: widget.villa!.villaName);
      _villaNumberController =
          TextEditingController(text: widget.villa!.villaNumber);
      _locationController = TextEditingController(text: widget.villa!.location);
      _tenantNameController =
          TextEditingController(text: widget.villa!.tenantName);
      _tenantPhoneController =
          TextEditingController(text: widget.villa!.tenantPhone);
      _monthlyRentController =
          TextEditingController(text: widget.villa!.monthlyRent.toString());
      _contractStartDate = widget.villa!.contractStartDate;
      _contractEndDate = widget.villa!.contractEndDate;
      _paymentDueDay = widget.villa!.paymentDueDay;
      _status = widget.villa!.status;
    } else {
      _villaNameController = TextEditingController();
      _villaNumberController = TextEditingController();
      _locationController = TextEditingController();
      _tenantNameController = TextEditingController();
      _tenantPhoneController = TextEditingController();
      _monthlyRentController = TextEditingController();
      _contractStartDate = DateTime.now();
      _contractEndDate = DateTime.now().add(const Duration(days: 365));
      _paymentDueDay = 1;
      _status = VillaStatus.vacant;
    }
  }

  @override
  void dispose() {
    _villaNameController.dispose();
    _villaNumberController.dispose();
    _locationController.dispose();
    _tenantNameController.dispose();
    _tenantPhoneController.dispose();
    _monthlyRentController.dispose();
    super.dispose();
  }

  bool get _isTenantRequired => _status == VillaStatus.occupied;

  void _saveVilla() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final villa = VillaModel(
      id: widget.villa?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      villaName: _villaNameController.text.trim(),
      villaNumber: _villaNumberController.text.trim(),
      location: _locationController.text.trim(),
      tenantName: _tenantNameController.text.trim(),
      tenantPhone: _tenantPhoneController.text.trim(),
      monthlyRent: double.parse(_monthlyRentController.text),
      contractStartDate: _contractStartDate,
      contractEndDate: _contractEndDate,
      paymentDueDay: _paymentDueDay,
      status: _status,
      createdAt: widget.villa?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );

    try {
      if (widget.villa == null) {
        await ref.read(addVillaProvider(villa).future);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Villa added successfully!')),
        );
      } else {
        await ref.read(updateVillaProvider(villa).future);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Villa updated successfully!')),
        );
      }
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 20,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: AppStyles.titleMedium.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard({required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ...List.generate(
            children.length,
            (index) => Column(
              children: [
                children[index],
                if (index < children.length - 1) const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.villa != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Villa' : 'Add New Villa'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status Selection (prominent)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.08),
                        AppColors.primary.withValues(alpha: 0.02),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: AppDropdown<VillaStatus>(
                    label: 'Villa Status',
                    value: _status,
                    items: VillaStatus.values,
                    itemLabel: (status) => status.displayName,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _status = value);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // Basic Information Section
                _buildSectionHeader('Villa Details', Icons.home_outlined),
                _buildFormCard(
                  children: [
                    AppTextField(
                      controller: _villaNameController,
                      label: 'Villa Name *',
                      hint: 'e.g., Sunset Villa',
                      prefixIcon: Icons.label_outlined,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Villa name is required';
                        }
                        return null;
                      },
                    ),
                    AppTextField(
                      controller: _villaNumberController,
                      label: 'Villa Number *',
                      hint: 'e.g., V001',
                      prefixIcon: Icons.numbers,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Villa number is required';
                        }
                        return null;
                      },
                    ),
                    AppTextField(
                      controller: _locationController,
                      label: 'Location *',
                      hint: 'e.g., Downtown, District',
                      prefixIcon: Icons.location_on_outlined,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Location is required';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Financial Information Section
                _buildSectionHeader(
                    'Financial Details', Icons.attach_money_outlined),
                _buildFormCard(
                  children: [
                    AppTextField(
                      controller: _monthlyRentController,
                      label: 'Monthly Rent *',
                      hint: 'Enter amount',
                      prefixIcon: Icons.currency_rupee,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Monthly rent is required';
                        }
                        if (double.tryParse(value!) == null) {
                          return 'Please enter a valid amount';
                        }
                        return null;
                      },
                    ),
                    AppDropdown<int>(
                      label: 'Payment Due Day *',
                      value: _paymentDueDay,
                      items: List.generate(31, (i) => i + 1),
                      itemLabel: (day) => 'Day $day of each month',
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _paymentDueDay = value);
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Contract Information Section
                _buildSectionHeader(
                    'Contract Terms', Icons.description_outlined),
                _buildFormCard(
                  children: [
                    AppDatePickerField(
                      label: 'Contract Start Date *',
                      value: _contractStartDate,
                      onChanged: (date) {
                        setState(() => _contractStartDate = date);
                      },
                    ),
                    AppDatePickerField(
                      label: 'Contract End Date *',
                      value: _contractEndDate,
                      onChanged: (date) {
                        setState(() => _contractEndDate = date);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Tenant Information Section (conditional)
                if (_isTenantRequired) ...[
                  _buildSectionHeader(
                      'Tenant Information', Icons.person_outlined),
                  _buildFormCard(
                    children: [
                      AppTextField(
                        controller: _tenantNameController,
                        label: 'Tenant Name *',
                        hint: 'Full name',
                        prefixIcon: Icons.person_outline,
                        validator: (value) {
                          if (_isTenantRequired && (value?.isEmpty ?? true)) {
                            return 'Tenant name is required for occupied villas';
                          }
                          return null;
                        },
                      ),
                      AppTextField(
                        controller: _tenantPhoneController,
                        label: 'Tenant Phone *',
                        hint: 'Phone number',
                        prefixIcon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (_isTenantRequired && (value?.isEmpty ?? true)) {
                            return 'Tenant phone is required for occupied villas';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ] else ...[
                  _buildSectionHeader(
                      'Tenant Information (Optional)', Icons.person_outlined),
                  _buildFormCard(
                    children: [
                      AppTextField(
                        controller: _tenantNameController,
                        label: 'Tenant Name',
                        hint: 'Can be added later',
                        prefixIcon: Icons.person_outline,
                      ),
                      AppTextField(
                        controller: _tenantPhoneController,
                        label: 'Tenant Phone',
                        hint: 'Can be added later',
                        prefixIcon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.surface,
                          foregroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: BorderSide(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            width: 1.5,
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _saveVilla,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: Text(
                          isEditing ? 'Update Villa' : 'Add Villa',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
