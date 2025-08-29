import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management/application/employee/employee_bloc.dart';

import 'package:management/core/constants/app_strings.dart';
import 'package:management/core/constants/app_colors.dart';
import 'package:management/core/constants/app_sizes.dart';
import 'package:management/core/assets/app_assets.dart';
import 'package:management/core/styles/app_typography.dart';
import 'package:management/core/utils/app_date_utils.dart';
import 'package:management/core/utils/widgets/AppBar/AppBarWithTitle.dart';
import 'package:management/core/utils/widgets/Image/svgImage.dart';
import 'package:management/core/utils/widgets/Message/messageBoxWidget.dart';
import 'package:management/core/utils/widgets/Text/AppText.dart';
import 'package:management/presentation/features/employee_detail/widgets/calendar_pop_up.dart';

// your shared input
import 'package:management/presentation/features/employee_detail/widgets/input_field.dart';
// bottom nav bar (Cancel / Save)
import 'package:management/presentation/features/employee_detail/widgets/bottom_bar.dart';

// domain / bloc
import 'package:management/domain/entities/employee.dart';
import 'package:management/core/constants/employee_status.dart';

// sheets kept separate (we'll polish them next)
import '../widgets/role_bottom_sheet.dart';

class EmployeeDetailScreen extends StatefulWidget {
  const EmployeeDetailScreen({super.key, this.employeeId});
  final int? employeeId; // null => create

  @override
  State<EmployeeDetailScreen> createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  // controllers
  final _nameCtrl = TextEditingController();
  final _roleCtrl = TextEditingController();
  final _joinCtrl = TextEditingController();
  final _endCtrl = TextEditingController();

  // local values
  DateTime _joinDate = DateTime.now();
  DateTime? _endDate;

  // hydrate once to avoid wiping user input on rebuilds
  bool _hydrated = false;

  @override
  void initState() {
    super.initState();
    context.read<EmployeeBloc>().add(EmployeeLoadRequested(id: widget.employeeId));
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _roleCtrl.dispose();
    _joinCtrl.dispose();
    _endCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppSize.init(context);

    return BlocListener<EmployeeBloc, EmployeeState>(
      listener: (context, state) {
        if (state is EmployeeError) {
          showMessageSnackBar(
            context,
            message: state.message ?? 'Something went wrong',
            actionText: AppStrings.messageBoxDismissText,
            onAction: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
          );
        } else if (state is EmployeeSaved) {
          Navigator.pop(
            context,
            widget.employeeId == null ? AppStrings.createdData : AppStrings.updatedData,
          );
        } else if (state is EmployeeLoaded && !_hydrated) {
          final e = state.employee;
          _nameCtrl.text = e.name;
          _roleCtrl.text = e.role;

          _joinDate = e.joinedDate ?? DateTime.now();
          _joinCtrl.text = AppDateUtils.isToday(_joinDate)
              ? AppStrings.todayText
              : AppDateUtils.formatDMMMYYYY(_joinDate);

          _endDate = e.endDate;
          _endCtrl.text = (_endDate == null)
              ? ''
              : (AppDateUtils.isToday(_endDate!)
              ? AppStrings.todayText
              : AppDateUtils.formatDMMMYYYY(_endDate!));

          _hydrated = true;
        }
      },
      child: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          final isUpdate = widget.employeeId != null;

          if (state is EmployeeLoading || state is EmployeeInitial) {
            return Scaffold(
              backgroundColor: AppColors.employeeDetailScreenBackground,
              body: Center(
                child: CircularProgressIndicator(color: AppColors.appBarBackground),
              ),
            );
          }

          if (state is EmployeeError) {
            return Scaffold(
              backgroundColor: AppColors.employeeDetailScreenBackground,
              body: Center(
                child: Padding(
                  padding: EdgeInsets.all(AppSizes.employeeSectionHorizontalPadding),
                  child: AppText(
                    text: state.message ?? 'Something went wrong',
                    size: AppSizes.employeeListScreenEmptyContentTextSize,
                    color: AppColors.deleteEmployeeIconBackground,
                    align: TextAlign.center,
                    fontFamily: AppTypography.robotoMedium,
                  ),
                ),
              ),
            );
          }

          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: AppColors.employeeDetailScreenBackground,
            appBar: AppBarWithTitle(
              title: isUpdate
                  ? AppStrings.appBarEmployeeDetailScreenUpdateTitle
                  : AppStrings.appBarEmployeeDetailScreenAddTitle,
              showDelete: isUpdate,
              onDelete: () => Navigator.pop(context, AppStrings.deletedData),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.employeeDetailScreenHorizontalPadding,),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: AppSize.isDesktop ? 720.w : double.infinity),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppSizes.employeeDetailScreenTopTextFieldPadding),
                    // ── Name (no label; hint only)
                    InputField(
                      controller: _nameCtrl,
                      hint: AppStrings.employeeDetailScreenEmployeeNameHint,
                      prefixAsset: AppAssets.employeeNameIcon,
                      keyboardType: TextInputType.name,
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z ]'))],
                    ),
                    SizedBox(height: AppSizes.employeeDetailScreenTopTextFieldPadding),

                    // ── Role (no label; hint only)
                    InputField(
                      controller: _roleCtrl,
                      hint: AppStrings.employeeDetailScreenSelectRoleHint,
                      prefixAsset: AppAssets.employeeRoleIcon,
                      suffixAsset: AppAssets.dropDownIcon,
                      readOnly: true,
                      onTap: () async {
                        final picked = await showRoleBottomSheet(context);
                        if (picked != null) _roleCtrl.text = picked;
                      },
                    ),
                    SizedBox(height: AppSizes.employeeDetailScreenTopTextFieldPadding),

                    // ── Dates row (no labels; hints only)
                    Row(
                      children: [
                        Expanded(
                          child: InputField(
                            controller: _joinCtrl,
                            hint: AppStrings.employeeDetailScreenDateHintText,
                            prefixAsset: AppAssets.calenderIcon,
                            readOnly: true,
                            onTap: () async {
                              await showCalendarPopup(
                                context: context,
                                selectedDate: _joinDate,                 // current value
                                employeeJoinedCalendar: true,            // shows Today / Next Mon / Next Tue / +1 week
                                startDate: DateTime(AppSizes.calenderStartYear),
                                onSelected: (dt) {
                                  if (dt == null) return;                // joined date can't be null in this mode
                                  _joinDate = dt;
                                  if (_endDate != null && _endDate!.isBefore(_joinDate)) {
                                    _endDate = null;
                                    _endCtrl.text = '';
                                  }
                                  _joinCtrl.text = AppDateUtils.isToday(_joinDate)
                                      ? AppStrings.todayText
                                      : AppDateUtils.formatDMMMYYYY(_joinDate);
                                  setState(() {});
                                },
                                activeTab: 0,
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 12.w),
                        SizedBox(
                          width: 28.w,
                          height: 28.h,
                          child: Center(
                            child: SvgIcon(
                              asset: AppAssets.toArrowIcon,
                              fit: BoxFit.scaleDown,
                              width: 20.w,
                              height: 20.h,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: InputField(
                            controller: _endCtrl,
                            hint: AppStrings.employeeDetailScreenDateHintText,
                            prefixAsset: AppAssets.calenderIcon,
                            readOnly: true,
                            onTap: () async {
                              await showCalendarPopup(
                                context: context,
                                selectedDate: _endDate ?? _joinDate,     // start from existing end date or join date
                                employeeJoinedCalendar: false,           // shows No date / Today
                                startDate: _joinDate,                    // end date cannot be before join date
                                onSelected: (dt) {
                                  _endDate = dt;                         // dt may be null (No date)
                                  _endCtrl.text = (_endDate == null)
                                      ? ''
                                      : (AppDateUtils.isToday(_endDate!)
                                      ? AppStrings.todayText
                                      : AppDateUtils.formatDMMMYYYY(_endDate!));
                                  setState(() {});
                                },
                                activeTab: 0,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSizes.employeeDetailScreenTopTextFieldPadding),
                  ],
                ),
              ),
            ),

            // ── Bottom nav: Cancel / Save (no in-body buttons)
            bottomNavigationBar: BottomBar(
              onCancel: () => Navigator.pop(context),
              onSave: _onSave,
            ),
          );
        },
      ),
    );
  }

  void _onSave() {
    FocusManager.instance.primaryFocus?.unfocus();

    if (_nameCtrl.text.trim().isEmpty) {
      toast(AppStrings.employeeNameErrorMessage);
      return;
    }
    if (_roleCtrl.text.trim().isEmpty) {
      toast(AppStrings.employeeRoleErrorMessage);
      return;
    }
    if (_joinCtrl.text.trim().isEmpty) {
      toast(AppStrings.employeeJoinDateErrorMessage);
      return;
    }

    final currentState = context.read<EmployeeBloc>().state;
    final base = (currentState is EmployeeLoaded)
        ? currentState.employee
        : Employee(
      id: widget.employeeId,
      name: '',
      role: '',
      joinedDate: null,
      endDate: null,
      status: EmployeeStatus.active,
    );

    final updated = Employee(
      id: base.id,
      name: _nameCtrl.text.trim(),
      role: _roleCtrl.text.trim(),
      joinedDate: _joinDate,
      endDate: _endDate,
      status: base.status,
    );

    if (base.id == null) {
      context.read<EmployeeBloc>().add(EmployeeCreateRequested(employee: updated));
    } else {
      context.read<EmployeeBloc>().add(EmployeeUpdateRequested(employee: updated));
    }
  }

  void toast(String msg) {
    showMessageSnackBar(
      context,
      message:msg ?? 'Something went wrong',
      actionText: AppStrings.messageBoxDismissText,
      onAction: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
    );
  }
}
