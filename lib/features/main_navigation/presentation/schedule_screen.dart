import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usafi_app/core/constants/app_colors.dart';
import 'package:usafi_app/core/widgets/app_button.dart';
import 'package:usafi_app/core/widgets/app_text_field.dart';
import 'package:usafi_app/core/widgets/job_item_card.dart';

import '../../../app/routes.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _tabs = ['Approved', 'Pending', 'Rejected'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: TabBarView(
        controller: _tabController,
        children: [
          _scheduleList(status: 'Confirmed'),
          _scheduleList(status: 'Pending'),
          _scheduleList(status: 'Rejected'),
        ],
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      titleSpacing: 0,
      title: TabBar(
        controller: _tabController,
        indicatorColor: AppColors.yellow,
        labelPadding: EdgeInsets.zero,
        indicatorWeight: 3,
        labelColor: AppColors.yellow,
        unselectedLabelColor: AppColors.secondary,
        padding: EdgeInsets.zero,
        dividerColor: Colors.transparent,
        labelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        tabs: _tabs.map((e) => Tab(text: e)).toList(),
      ),
      actions: [
        PopupMenuButton<String>(
          offset: const Offset(0, 45),
          color: AppColors.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          icon: CircleAvatar(
            backgroundColor: AppColors.circleButton,
            child: Icon(
              Icons.tune_outlined,
              color: AppColors.secondary,
              size: 20,
            ),
          ),
          onSelected: (value) {
            debugPrint(value);
            switch (value) {
              case 'date':
                _openDateBottomSheet(context);
                break;
              case 'location':
                _openLocationBottomSheet(context);
                break;
              case 'job':
                _openJobRoleBottomSheet(context);
                break;
            }
          },
          itemBuilder: (context) => [
            _menuHeader(),
            PopupMenuDivider(color: AppColors.jobHeader, thickness: 03),
            _menuItem('date', 'Date'),
            _menuItem('location', 'Location'),
            _menuItem('job', 'Job role'),
          ],
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.profile);
          },
          child: CircleAvatar(
            backgroundColor: AppColors.circleButton,
            child: Icon(Icons.menu, color: AppColors.secondary, size: 20),
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  PopupMenuItem<String> _menuHeader() {
    return const PopupMenuItem<String>(
      enabled: false,
      height: 40,
      child: Text(
        'Filter Shifts',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  PopupMenuItem<String> _menuItem(String value, String title) {
    return PopupMenuItem<String>(
      value: value,
      height: 46,
      child: Container(
        width: double.infinity,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(vertical: 08, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  void _openDateBottomSheet(BuildContext context) {
    DateTime selectedDate = DateTime.now();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.only(top: 16, bottom: 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Date',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime.now(),
                  minimumDate: DateTime(2000, 1, 1),
                  maximumDate: DateTime.now(),
                  use24hFormat: true,
                  onDateTimeChanged: (DateTime date) {
                    selectedDate = date;
                  },
                ),
                // child: CupertinoDateTimePicker(),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      debugPrint('Selected Date: $selectedDate');
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _openLocationBottomSheet(BuildContext context) {
    final TextEditingController locationController = TextEditingController();
    String? selectedLocation;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Location',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 20),

                AppTextField(hint: "Enter Location"),
                const SizedBox(height: 16),
                const Text(
                  'OR',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedLocation,
                  dropdownColor: AppColors.secondary,
                  hint: const Text('Select Location'),
                  items: const [
                    DropdownMenuItem(
                      value: 'Manchester',
                      child: Text('Manchester'),
                    ),
                    DropdownMenuItem(value: 'London', child: Text('London')),
                    DropdownMenuItem(
                      value: 'Birmingham',
                      child: Text('Birmingham'),
                    ),
                  ],
                  onChanged: (value) {
                    selectedLocation = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                AppButton(
                  title: "Filter Now",
                  onTap: () {
                    debugPrint('Typed Location: ${locationController.text}');
                    debugPrint('Selected Location: $selectedLocation');
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openJobRoleBottomSheet(BuildContext context) {
    String? selectedLocation;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Job Role',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: selectedLocation,
                  dropdownColor: AppColors.secondary,
                  hint: const Text('Select Job Role'),
                  items: const [
                    DropdownMenuItem(
                      value: 'Sales Man',
                      child: Text('Sales Man'),
                    ),
                    DropdownMenuItem(
                      value: 'Product Manager',
                      child: Text('Product Manager'),
                    ),
                    DropdownMenuItem(
                      value: 'Developer',
                      child: Text('Developer'),
                    ),
                  ],
                  onChanged: (value) {
                    selectedLocation = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                AppButton(
                  title: "Filter Now",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _scheduleList({required String status}) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 3,
      separatorBuilder: (_, _) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.jobDetail,
              arguments: {"jobStatus": status, "isFromWhere": false},
            );
          },
          child: JobItemCard(
            date: 'Tomorrow, Tuesday, November 18',
            time: '16:00 - 00:30',
            title: 'North — New Accreditations to Work Future Etihad Games',
            role: 'Bar Staff',
            index: index,
            location: 'Etihad Stadium, Manchester',
            status: status,
          ),
        );
      },
    );
  }
}

class FilterSelectorDialog extends StatelessWidget {
  const FilterSelectorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Filter Shifts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 20),

            _FilterButton(
              title: 'Date',
              onTap: () {
                Navigator.pop(context);
                // open date picker later
              },
            ),

            const SizedBox(height: 12),

            _FilterButton(
              title: 'Location',
              onTap: () {
                Navigator.pop(context);
              },
            ),

            const SizedBox(height: 12),

            _FilterButton(
              title: 'Job role',
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _FilterButton({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}

class CupertinoDateTimePicker extends StatelessWidget {
  final Function(DateTime)? onSelectionChanged;
  final DateTime? initialDateTime;
  final Widget Function(BuildContext, SelectionOverlayPosition)? selectionOverlayBuilder;
  final double height;
  const CupertinoDateTimePicker({
    super.key,
    this.onSelectionChanged,
    this.initialDateTime,
    this.selectionOverlayBuilder,
    this.height = 100,
  });

  @override
  Widget build(BuildContext context) {
    var zeroDateTime = initialDateTime ?? DateTime.now();
    int hourFromIndex(int index) => (zeroDateTime.hour + index) % 24;
    int minuteFromIndex(int index) => (zeroDateTime.minute + index) % 60;
    return CupertinoPickerLine(
      height: height,
      selectionOverlayBuilder: selectionOverlayBuilder,
      onSelectionChanged: (indexes) {
        var selectedDateOnly = zeroDateTime.add(Duration(days: indexes[0]));
        var selectedHour = hourFromIndex(indexes[1]);
        var selectedMinute = minuteFromIndex(indexes[2]);
        var selected = DateTime(
            selectedDateOnly.year,
            selectedDateOnly.month,
            selectedDateOnly.day,
            selectedHour,
            selectedMinute
        );

        onSelectionChanged?.call(selected);
      },
      itemsData: [
        CupertinoPickerLineItemData(
          width: 130,
          itemTextBuilder: (context, index) {
            final selectedDate = zeroDateTime.add(Duration(days: index));
            return selectedDate.day.toString();
          },
        ),
        CupertinoPickerLineItemData(
          width: 120,
          itemTextBuilder: (context, index) {
            final localization = CupertinoLocalizations.of(context);
            final month = (index % 12) + 1;
            final date = DateTime(2024, month, 1);

            return localization.datePickerMonth(month);
          },
        ),
        CupertinoPickerLineItemData(
          width: 100,
          itemTextBuilder: (context, index) {
            final startYear = 2000;
            final endYear = 2030;

            final year = startYear + index;
            if (year > endYear) return '';

            return year.toString();
          },
        ),
      ],
    );
  }
}

enum SelectionOverlayPosition {
  inline,
  leftEdge,
  rightEdge,
}

class CupertinoPickerLine extends StatelessWidget {
  final double height;
  final double itemExtent;
  final List<CupertinoPickerLineItemData> itemsData;
  final Widget Function(BuildContext, String)? itemBuilder;
  final Function(List<int>)? onSelectionChanged;
  final Widget Function(BuildContext, SelectionOverlayPosition)? selectionOverlayBuilder;

  const CupertinoPickerLine({
    super.key,
    required this.itemsData,
    this.itemBuilder,
    this.height = 50,
    this.itemExtent = 30,
    this.onSelectionChanged,
    this.selectionOverlayBuilder,
  });

  @override
  Widget build(BuildContext context) {
    var selectedIndexes = List.generate(itemsData.length, (index) => 0);
    List<Widget> children = [];
    for (int i = 0; i < itemsData.length; i++) {
      CupertinoPickerLineItemData item = itemsData[i];
      Widget selectionOverlay = _buildInlineSelectionOverlay(context);
      if (i == 0) selectionOverlay = _buildLeftEdgeSelectionOverlay(context);
      if (i == itemsData.length - 1) selectionOverlay = _buildRightEdgeSelectionOverlay(context);
      children.add(
        SizedBox(
          width: item.width,
          height: height,
          child: CupertinoPicker.builder(
              itemExtent: itemExtent,
              onSelectedItemChanged: (index) {
                selectedIndexes[i] = index;
                onSelectionChanged?.call(selectedIndexes);
              },
              scrollController: FixedExtentScrollController(initialItem: 0),
              selectionOverlay: selectionOverlay,
              itemBuilder: (context, index) {
                var text = item.itemTextBuilder(context, index);
                return text == null ? null : _buildItem(context, text);
              }
          ),
        ),
      );
    }
    return Row(
      children: children,
    );
  }

  Widget _buildInlineSelectionOverlay(BuildContext context) =>
      selectionOverlayBuilder?.call(context, SelectionOverlayPosition.inline) ??
          CupertinoPickerSelectionOverlay();

  Widget _buildLeftEdgeSelectionOverlay(BuildContext context) =>
      selectionOverlayBuilder?.call(context, SelectionOverlayPosition.leftEdge) ??
          CupertinoPickerSelectionOverlay.roundedLeftSide();

  Widget _buildRightEdgeSelectionOverlay(BuildContext context) =>
      selectionOverlayBuilder?.call(context, SelectionOverlayPosition.rightEdge) ??
          CupertinoPickerSelectionOverlay.roundedRightSide();

  Widget _buildItem(BuildContext context, String data) =>
      itemBuilder?.call(context, data) ??
          Center(
            child: Text(data),
          );
}

class CupertinoPickerSelectionOverlay extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final BorderRadiusGeometry borderRadius;
  final Color background;
  final BoxBorder? border;
  static const double _defaultSelectionOverlayRadius = 8;

  const CupertinoPickerSelectionOverlay({
    super.key,
    this.background = CupertinoColors.tertiarySystemFill,
    this.margin = const EdgeInsets.all(0),
    this.borderRadius = const BorderRadius.all(Radius.zero),
    this.border
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: border,
        color: CupertinoDynamicColor.resolve(background, context),
      ),
    );
  }

  factory CupertinoPickerSelectionOverlay.roundedLeftSide() {
    return const CupertinoPickerSelectionOverlay(
      borderRadius: BorderRadiusDirectional.horizontal(
        start: Radius.circular(_defaultSelectionOverlayRadius),
      ),
    );
  }

  factory CupertinoPickerSelectionOverlay.roundedRightSide() {
    return const CupertinoPickerSelectionOverlay(
      borderRadius: BorderRadiusDirectional.horizontal(
        end: Radius.circular(_defaultSelectionOverlayRadius),
      ),
    );
  }
}



class CupertinoPickerLineItemData {
  final double width;
  final String? Function(BuildContext, int) itemTextBuilder;
  const CupertinoPickerLineItemData({
    this.width = 80,
    required this.itemTextBuilder,
  });
}