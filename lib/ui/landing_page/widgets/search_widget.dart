import 'package:flutter/material.dart';
import 'package:petnity/ui/widgets/filter_search_section.dart';

class Search extends StatelessWidget {
  final String label;
  const Search(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.transparent,
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.search,
              color: Colors.grey[600],
            ),
          ),
          Expanded(
            child: FilterSearchView(),
          ),
        ],
      ),
    );
  }
}
