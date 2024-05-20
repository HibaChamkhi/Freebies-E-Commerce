import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../features/products/data/data_source/supabase_data_source.dart';
import '../../config/themes/app_theme.dart';
import 'dialog_widget.dart';

class FilterPopupWidget extends StatefulWidget {
  final BuildContext context;
  final Function(ProductSortType) sortFunction;
  const FilterPopupWidget({super.key, required this.context, required this.sortFunction});

  @override
  State<FilterPopupWidget> createState() => _FilterPopupWidgetState();
}

class _FilterPopupWidgetState extends State<FilterPopupWidget> {
  int _selectedSortIndex = -1;
  bool isFiltering = true;
  bool isAllChecked = false;
  List<String> selectedFilters = [];
  RangeValues selectedRange = const RangeValues(0, 100);
  ProductSortType? _selectedSortType;

  void _onItemTap(int index, ProductSortType type) {
    setState(() {
      _selectedSortIndex = index;
      _selectedSortType = type;
    });
  }

  void _toggleFilterState() {
    setState(() {
      isFiltering = !isFiltering;
    });
  }

  void _toggleAllChecked(bool? value) {
    setState(() {
      isAllChecked = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      isDivider: false,
      title: 'Filter & Sorting',
      widget: Column(
        children: [
          _buildFilterSortToggle(),
          const SizedBox(height: 10),
          const Divider(),
          isFiltering ? _buildFilterOptions() : _buildSortOptions(),
        ],
      ),
    );
  }

  Widget _buildFilterSortToggle() {
    return Row(
      children: [
        GestureDetector(
          onTap: isFiltering ? null : _toggleFilterState,
          child: Text(
            "Filter",
            style: TextStyle(
              fontWeight: isFiltering ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: isFiltering ? _toggleFilterState : null,
          child: Text(
            "Sorting",
            style: TextStyle(
              fontWeight: !isFiltering ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterOptions() {
    return Container(
      height: 450,
      width: 400,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16.0),
          const Text(
            'Price Range',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          RangeSlider(
            values: selectedRange,
            min: 0,
            max: 100,
            onChanged: (RangeValues values) {
              setState(() {
                selectedRange = values;
              });
            },
          ),
          const Divider(),
          _buildFilterCheckbox('All Sub Categories', isAllChecked, _toggleAllChecked),
          const Divider(),
          _buildFilterCheckbox('Cellphone', isAllChecked, _toggleAllChecked),
          const Divider(),
          _buildFilterCheckbox('Computer', isAllChecked, _toggleAllChecked),
          const Divider(),
          _buildFilterCheckbox('Laptop', isAllChecked, _toggleAllChecked),
          const SizedBox(height: 16.0),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildFilterCheckbox(String title, bool value, Function(bool?) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildSortOptions() {
    return Container(
      width: 400,
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSortOption('Name (A-Z)', 0, ProductSortType.nameAsc),
          const Divider(),
          _buildSortOption('Name (Z-A)', 1, ProductSortType.nameDesc),
          const Divider(),
          _buildSortOption('Price (High-Low)', 2, ProductSortType.priceHighToLow),
          const Divider(),
          _buildSortOption('Price (Low-High)', 3, ProductSortType.priceLowToHigh),
          SizedBox(height: 20.h),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildSortOption(String title, int index, ProductSortType type) {
    return GestureDetector(
      onTap: () => _onItemTap(index, type),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14),
            ),
            if (_selectedSortIndex == index)
              Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(Icons.check, size: 14, color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionButton('Cancel', Colors.black, Colors.transparent, Colors.black, () {
          setState(() {
            selectedFilters.clear();
            selectedRange = const RangeValues(0, 100);
            isAllChecked = false;
            _selectedSortIndex = -1;
            _selectedSortType = null;
          });
        }),
        _buildActionButton('Apply', Colors.white, marinerApprox, Colors.white, () {
          if (_selectedSortType != null) {
            widget.sortFunction(_selectedSortType!);
            print('Selected Sort Type: $_selectedSortType');
          }
          Navigator.pop(context);
        }),
      ],
    );
  }

  Widget _buildActionButton(String text, Color textColor, Color bgColor, Color borderColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        width: 130.w,
        height: 50.h,
        child: Text(
          text,
          style: TextStyle(color: textColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
