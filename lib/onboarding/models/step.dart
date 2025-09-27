import 'package:flutter/material.dart';

class Step {
  final String title;
  final String? description;
  final bool isCompleted;
  final bool isActive;
  final String? floatLabel;
  final Icon? floatIcon;
  final Widget? content;

  const Step({
    required this.title,
    this.description,
    this.isCompleted = false,
    this.isActive = false,
    this.floatLabel,
    this.floatIcon,
    this.content,
  });

  Step copyWith({
    String? title,
    String? description,
    bool? isCompleted,
    bool? isActive,
    String? floatLabel,
    Icon? floatIcon,
    Widget? content,
  }) {
    return Step(
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      isActive: isActive ?? this.isActive,
      floatLabel: floatLabel ?? this.floatLabel,
      floatIcon: floatIcon ?? this.floatIcon,
      content: content ?? this.content,
    );
  }
}
