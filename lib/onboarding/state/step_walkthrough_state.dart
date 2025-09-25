import 'package:equatable/equatable.dart';
import 'package:widget_builder_demo/onboarding/models/step.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

class OnboardingInitial extends OnboardingState {}

class OnboardingInProgress extends OnboardingState {
  final int currentStepIndex;
  final List<Step> steps;
  final bool isVisible;

  const OnboardingInProgress({
    required this.currentStepIndex,
    required this.steps,
    this.isVisible = false,
  });

  @override
  List<Object?> get props => [currentStepIndex, steps, isVisible];

  OnboardingInProgress copyWith({
    int? currentStepIndex,
    List<Step>? steps,
    bool? isVisible,
  }) {
    return OnboardingInProgress(
      currentStepIndex: currentStepIndex ?? this.currentStepIndex,
      steps: steps ?? this.steps,
      isVisible: isVisible ?? this.isVisible,
    );
  }

  bool get canGoNext => currentStepIndex < steps.length - 1;
  bool get canGoPrevious => currentStepIndex > 0;
  Step get currentStep => steps[currentStepIndex];
}

class OnboardingCompleted extends OnboardingState {}
