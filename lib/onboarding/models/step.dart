class Step {
  final String title;
  final String? description;
  final bool isCompleted;
  final bool isActive;

  const Step({
    required this.title,
    this.description,
    this.isCompleted = false,
    this.isActive = false,
  });

  Step copyWith({
    String? title,
    String? description,
    bool? isCompleted,
    bool? isActive,
  }) {
    return Step(
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      isActive: isActive ?? this.isActive,
    );
  }
}