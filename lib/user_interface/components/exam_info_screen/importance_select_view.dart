import 'package:flutter/material.dart';
import '../../../data/models/_models.dart';

class ImportanceSelectView extends StatelessWidget {
  final Importance selectedImportance;
  final Function(Importance newImportance) setImportance;
  const ImportanceSelectView({
    Key? key,
    required this.selectedImportance,
    required this.setImportance,
  }) : super(key: key);

  Color getColor(Importance imp) {
    switch (imp) {
      case Importance.low:
        return const Color(0xff00d930);
      case Importance.medium:
        return const Color(0xFFD9D930);
      case Importance.high:
        return const Color(0xFFD90030);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Важность:', style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildChoiceChip(
                  Importance.low,
                  'Низкая',
                  context,
                ),
                _buildChoiceChip(Importance.medium, 'Средняя', context),
                _buildChoiceChip(Importance.high, 'Высокая', context),
              ],
            )
          ],
        ),
      ),
    );
  }

  _buildChoiceChip(Importance imp, String label, BuildContext context) {
    return ChoiceChip(
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      label: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      selected: imp == selectedImportance,
      onSelected: (selected) {
        setImportance(imp);
      },
      selectedColor: getColor(imp),
      padding: const EdgeInsets.all(5),
      backgroundColor: Colors.white,
      pressElevation: 0,
    );
  }
}
