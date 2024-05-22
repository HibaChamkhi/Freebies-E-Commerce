import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freebies_e_commerce/features/products/data/models/sub_category/sub_category.dart';
import '../../../features/products/data/data_source/supabase_data_source.dart';
import '../../config/themes/app_theme.dart';
import 'dialog_widget.dart';

class FilterPopupWidget extends StatefulWidget {
  final BuildContext context;
  final List<SubCategoryModel> subCategories;
  final Function(ProductSortType) sortFunction;
  final Function(List<int>,double,double) filterFunction;

  const FilterPopupWidget({
    super.key,
    required this.context,
    required this.sortFunction,
    required this.subCategories,
    required this.filterFunction,
  });

  @override
  State<FilterPopupWidget> createState() => _FilterPopupWidgetState();
}

class _FilterPopupWidgetState extends State<FilterPopupWidget> {
  int _selectedSortIndex = -1;
  bool isFiltering = true;
  bool isChecked = false;
  List<String> selectedFilters = [];
  RangeValues selectedRange = const RangeValues(0, 1000);
  ProductSortType? _selectedSortType;
  late List<int> checkedItems;

  @override
  void initState() {
    super.initState();
    checkedItems = [];
  }

  void _toggleChecked(int id, bool? value) {
    setState(() {
      if (value == true) {
        // If the checkbox is checked, add the ID to checkedItems
        checkedItems.add(id);
      } else {
        // If the checkbox is unchecked, remove the ID from checkedItems
        checkedItems.remove(id);
      }
    });
  }

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
            max: 1000,
            onChanged: (RangeValues values) {
              setState(() {
                selectedRange = values;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(selectedRange.start.toStringAsFixed(2)),
              Text(selectedRange.end.toStringAsFixed(2)),
            ],
          ),
          const Divider(),
          const SizedBox(height: 16.0),

          const Text(
            "All Sub Categories :",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          widget.subCategories.isNotEmpty
          ?
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: widget.subCategories.map((subCategory) {
                return Column(
                  children: [
                    CheckboxListTile(
                      title: Text(subCategory.name),
                      value: checkedItems.contains(subCategory.id),
                      onChanged: (bool? value) {
                        _toggleChecked(subCategory.id, value);
                      },
                    ),
                    const Divider(),
                  ],
                );
              }).toList(),
            ),
          )
          :
          Center(child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20) ,
              child: const Text("Not Sub Category yet...")))
          ,
          const SizedBox(height: 16.0),
          _buildActionButtons(),
        ],
      ),
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
          _buildSortOption(
              'Price (High-Low)', 2, ProductSortType.priceHighToLow),
          const Divider(),
          _buildSortOption(
              'Price (Low-High)', 3, ProductSortType.priceLowToHigh),
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
        _buildActionButton(
            'Cancel', Colors.black, Colors.transparent, Colors.black, () {
          setState(() {
            selectedFilters.clear();
            selectedRange = const RangeValues(0, 1000);
            isChecked = false;
            // checkedItems.updateAll((key, value) => false);
            _selectedSortIndex = -1;
            _selectedSortType = null;
          });
        }),
        _buildActionButton('Apply', Colors.white, marinerApprox, Colors.white,
            () {
          if (_selectedSortType != null) {
            widget.sortFunction(_selectedSortType!);
          }
          widget.filterFunction(checkedItems,selectedRange.start,selectedRange.end);
          Navigator.pop(context);
        }),
      ],
    );
  }

  Widget _buildActionButton(String text, Color textColor, Color bgColor,
      Color borderColor, VoidCallback onTap) {
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
