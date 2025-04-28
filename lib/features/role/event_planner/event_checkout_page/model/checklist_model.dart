import 'package:flutter/material.dart';

// Model class to represent a single checklist item
class ChecklistModel {
  String eventName; // Name of the event
  String? taskName; // Name of the task (optional)
  DateTime? taskDate; // Date of the task (optional)
  TimeOfDay? taskTime; // Time of the task (optional)
  String? venue; // Venue of the task (optional)
  bool isCompleted=false; // Whether the task is completed (for the checkbox)
  bool isUrgent; // Whether the task is marked as urgent

  ChecklistModel({
    required this.eventName,
    this.taskName,
    this.taskDate,
    this.taskTime,
    this.venue,
    this.isCompleted = false, // Default to not completed
    this.isUrgent = false, // Default to not urgent
  });
}