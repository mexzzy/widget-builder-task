import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:widget_builder_demo/onboarding/cubit/step_walkthrough_cubit.dart';
import 'package:widget_builder_demo/onboarding/state/step_walkthrough_state.dart';
import 'package:widget_builder_demo/onboarding/widget/step_walkthrough_widget.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit()..initialize(),
      child: const OnBoardingView(),
    );
  }
}

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  OverlayEntry? overlayEntry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#202122"),
      body: BlocListener<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingInProgress) {
            if (state.isVisible && overlayEntry == null) {
              _showOverlay(context, state);
            } else if (!state.isVisible && overlayEntry != null) {
              _hideOverlay();
            }
          }
        },
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              context.read<OnboardingCubit>().showOnboarding();
            },
            child: const Text('Show Onboarding Overlay'),
          ),
        ),
      ),
    );
  }

  void _showOverlay(BuildContext context, OnboardingInProgress state) {
    final onboardingCubit = context.read<OnboardingCubit>();

    overlayEntry = OverlayEntry(
      builder: (overlayContext) => BlocProvider.value(
        value: onboardingCubit,
        child: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            if (state is OnboardingInProgress) {
              return StepWalkThrough(
                key: ValueKey(state.currentStepIndex),
                steps: state.steps,
                currentStepIndex: state.currentStepIndex,
                titleWidget: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [HexColor("#1C509D"), HexColor("#08959E")],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      state.steps[state.currentStepIndex].floatIcon ??
                          Icon(
                            Icons.info,
                            size: 16,
                            color: HexColor("#ffffff"),
                          ),
                      const SizedBox(width: 8),
                      Text(
                        state.steps[state.currentStepIndex].floatLabel ??
                            'Overview',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                contentBuilder: (step) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      state.steps[state.currentStepIndex].content ??
                          Text(
                            "title",
                            style: TextStyle(
                              color: HexColor("#FFFFFF"),
                              fontSize: 24,
                            ),
                          ),
                    ],
                  ),
                ),
                titleBuilder: (step) => Text(
                  step.description ?? "",
                  style: TextStyle(
                    color: HexColor("#FFFFFF"),
                    fontSize: 12,
                  ),
                ),
                onNext: state.canGoNext
                    ? () => context.read<OnboardingCubit>().nextStep()
                    : null,
                onPrevious: state.canGoPrevious
                    ? () => context.read<OnboardingCubit>().previousStep()
                    : null,
                onStepSelected: (index) =>
                    context.read<OnboardingCubit>().selectStep(index),
                canGoNext: state.canGoNext,
                canGoPrevious: state.canGoPrevious,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry!);
  }

  void _hideOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  @override
  void dispose() {
    _hideOverlay();
    super.dispose();
  }
}
