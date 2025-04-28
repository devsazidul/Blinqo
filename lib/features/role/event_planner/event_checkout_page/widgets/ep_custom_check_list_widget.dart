import 'package:blinqo/features/role/event_planner/event_checkout_page/model/checklist_model.dart';
import 'package:flutter/material.dart';

class EpCustomCheckListWidget extends StatelessWidget {
  final ChecklistModel item; // 🔥 Correct model

  const EpCustomCheckListWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
        child: Row(
          children: [
            Checkbox(
              value: item.isCompleted,
              onChanged: (value) {
                // toggleCompletion function call korle checkbox work korbe
              },
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.taskName ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.venue ?? '',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.taskDate != null
                        ? "${item.taskDate!.day}.${item.taskDate!.month}.${item.taskDate!.year}"
                        : '',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Text(
              item.taskTime != null
                  ? item.taskTime!.format(context)
                  : '',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
