//importando pacotes
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PyChartItem{

  const PyChartItem({
    required this.title,
    required this.value,
    required this.color,
    required this.textColor
  });

  final String title;
  final double value;
  final Color color;
  final Color textColor;

}

class CustomPyChart extends StatefulWidget {

  const CustomPyChart({

    super.key,
    required this.items,
    this.maxSize = 300
    
  });

  final List<PyChartItem> items;
  final double maxSize;


  @override
  State<CustomPyChart> createState() => _CustomPyChartState();
}

class _CustomPyChartState extends State<CustomPyChart> {

  static const _shadows = [Shadow(color: Colors.black, blurRadius: 2)];

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {

    //------------------------PyChart (Return)----------------------------//
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: widget.maxSize,
        maxWidth: widget.maxSize
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: PieChart(
          PieChartData(
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                setState(() {
                  if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                    touchedIndex = -1;
                    return;
                  }
                  touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                });
              },
            ),
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 0,
            centerSpaceRadius: 40,
            sections: showingSections(),
          ),
        ),
      )
    ); 
  }
    //------------------------PyChart (ListAnimations)----------------------------//
  
  List<PieChartSectionData> showingSections() {

    return List.generate(widget.items.length, (i) {

      final item = widget.items[i];
      
      final isTouched = i == touchedIndex;

      return PieChartSectionData(
        value: item.value,
        title: item.title,
        color: item.color,
        radius: isTouched ? 60.0 : 50.0,
        titleStyle: TextStyle(
          fontSize: isTouched ? 25.0 : 16.0,
          fontWeight: FontWeight.bold,
          color: item.textColor,
          shadows: _shadows,
        ),
      );

    });
  }
}