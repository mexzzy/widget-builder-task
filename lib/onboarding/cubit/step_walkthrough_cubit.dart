import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart' show HexColor;
import 'package:widget_builder_demo/onboarding/models/step.dart'
    as onboarding_step;
import 'package:widget_builder_demo/onboarding/state/step_walkthrough_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  void initialize() {
    final steps = [
      onboarding_step.Step(
        title: "Intro",
        isActive: true,
        description: "Welcome to Widget Builder",
        floatIcon: Icon(
          Icons.import_contacts,
          size: 16,
          color: HexColor("#ffffff"),
        ),
        floatLabel: "Reason",
        content: Text(
          "text things",
          style: TextStyle(
            color: HexColor("#FFFFFF"),
            fontSize: 24,
          ),
        ),
      ),
      onboarding_step.Step(
        title: "Connect figma",
        isActive: false,
        description: "Transfer figma components to canvas",
        floatIcon: Icon(
          Icons.accessibility_sharp,
          size: 16,
          color: HexColor("#ffffff"),
        ),
        content: Text(
          "text",
          style: TextStyle(
            color: HexColor("#FFFFFF"),
            fontSize: 24,
          ),
        ),
      ),
      onboarding_step.Step(
        title: "Single widget",
        isActive: false,
        description: "Transfer figma components to canvas",
        floatLabel: "Overview",
        content: Text(
          "text",
          style: TextStyle(
            color: HexColor("#FFFFFF"),
            fontSize: 24,
          ),
        ),
      ),
      onboarding_step.Step(
        title: "Templates",
        isActive: false,
        description: "Transfer figma components to canvas",
        floatLabel: "Widget",
        content: Text(
          "text",
          style: TextStyle(
            color: HexColor("#FFFFFF"),
            fontSize: 24,
          ),
        ),
      ),
      onboarding_step.Step(
        title: "Export code",
        isActive: false,
        description: "Transfer figma components to canvas",
        floatLabel: "Buildings",
        content: Text(
          "text",
          style: TextStyle(
            color: HexColor("#FFFFFF"),
            fontSize: 24,
          ),
        ),
      ),
    ];

    emit(OnboardingInProgress(
      currentStepIndex: 0,
      steps: steps,
      isVisible: false,
    ));
  }

  void showOnboarding() {
    if (state is OnboardingInProgress) {
      final currentState = state as OnboardingInProgress;
      emit(currentState.copyWith(isVisible: true));
    } else {
      initialize();
      final currentState = state as OnboardingInProgress;
      emit(currentState.copyWith(isVisible: true));
    }
  }

  void hideOnboarding() {
    if (state is OnboardingInProgress) {
      final currentState = state as OnboardingInProgress;
      emit(currentState.copyWith(isVisible: false));
    }
  }

  void nextStep() {
    if (state is OnboardingInProgress) {
      final currentState = state as OnboardingInProgress;
      if (currentState.canGoNext) {
        final newSteps = List<onboarding_step.Step>.from(currentState.steps);

        // Mark current step as completed and inactive
        newSteps[currentState.currentStepIndex] =
            newSteps[currentState.currentStepIndex].copyWith(
          isCompleted: true,
          isActive: false,
        );

        // Mark next step as active
        newSteps[currentState.currentStepIndex + 1] =
            newSteps[currentState.currentStepIndex + 1].copyWith(
          isActive: true,
        );

        emit(currentState.copyWith(
          currentStepIndex: currentState.currentStepIndex + 1,
          steps: newSteps,
        ));
      }
    }
  }

  void previousStep() {
    if (state is OnboardingInProgress) {
      final currentState = state as OnboardingInProgress;
      if (currentState.canGoPrevious) {
        final newSteps = List<onboarding_step.Step>.from(currentState.steps);

        // Mark current step as inactive
        newSteps[currentState.currentStepIndex] =
            newSteps[currentState.currentStepIndex].copyWith(
          isActive: false,
        );

        // Mark previous step as active and not completed
        newSteps[currentState.currentStepIndex - 1] =
            newSteps[currentState.currentStepIndex - 1].copyWith(
          isActive: true,
          isCompleted: false,
        );

        emit(currentState.copyWith(
          currentStepIndex: currentState.currentStepIndex - 1,
          steps: newSteps,
        ));
      }
    }
  }

  void selectStep(int index) {
    if (state is OnboardingInProgress) {
      final currentState = state as OnboardingInProgress;
      if (index >= 0 && index < currentState.steps.length) {
        final newSteps = List<onboarding_step.Step>.from(currentState.steps);

        // Reset all steps
        for (int i = 0; i < newSteps.length; i++) {
          newSteps[i] = newSteps[i].copyWith(
            isActive: i == index,
            isCompleted: i < index,
          );
        }

        emit(currentState.copyWith(
          currentStepIndex: index,
          steps: newSteps,
        ));
      }
    }
  }

  void completeOnboarding() {
    emit(OnboardingCompleted());
  }
}
