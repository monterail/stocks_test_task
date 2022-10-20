import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import 'package:template/src/modules/stock_module/bloc/stock_module_bloc.dart';
import 'package:template/src/repositories/tickers_repository/src/models/time_range.dart';

class StockFooter extends StatefulWidget {
  const StockFooter({Key? key}) : super(key: key);

  @override
  State<StockFooter> createState() => _StockFooterState();
}

class _StockFooterState extends State<StockFooter>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: TimeRange.values.length, vsync: this);
    super.initState();
  }

  List<Widget> _generateTabs() => TimeRange.values
      .map((e) => Tab(
            text: e.value,
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Transform.translate(
          offset: const Offset(0, -0.7),
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: RDottedLineBorder(
              dottedSpace: 5,
              dottedLength: 1,
              top: BorderSide(
                color: Colors.grey.shade700,
              ),
            ),
          ),
          child: TabBar(
            controller: _controller,
            isScrollable: true,
            labelColor: Colors.green,
            indicatorWeight: 3,
            indicatorColor: Colors.green,
            labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            onTap: (index) => context
                .read<StockModuleBloc>()
                .add(TimeRangeChanged(newTimeRange: TimeRange.values[index])),
            tabs: _generateTabs(),
          ),
        ),
      ],
    );
  }
}
