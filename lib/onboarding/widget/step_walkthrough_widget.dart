import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';

class StepWalkThrough extends StatelessWidget {
  final Widget titleWidget;
  final List<dynamic> steps;
  final int currentStepIndex;
  final Widget Function(dynamic step) contentBuilder;
  final Widget Function(dynamic step) titleBuilder;
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;
  final Function(int index)? onStepSelected;
  final bool canGoNext;
  final bool canGoPrevious;

  const StepWalkThrough({
    super.key,
    required this.titleWidget,
    required this.steps,
    required this.currentStepIndex,
    required this.contentBuilder,
    required this.titleBuilder,
    this.onNext,
    this.onPrevious,
    this.onStepSelected,
    this.canGoNext = true,
    this.canGoPrevious = true,
  });

  @override
  Widget build(BuildContext context) {
    if (steps.isEmpty) {
      return const SizedBox.shrink();
    }

    // Get current step based on index
    final currentStep =
        currentStepIndex < steps.length ? steps[currentStepIndex] : steps[0];

    return Material(
      color: HexColor("#000000CC"),
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 600,
              width: 900,
              decoration: BoxDecoration(
                color: HexColor("#161718"),
                borderRadius: BorderRadius.circular(17),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 40,
                        horizontal: 20,
                      ),
                      child: Column(
                        children: _buildStepList(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: HexColor("#262728"),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 20,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: HexColor("#262728"),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: titleBuilder(currentStep),
                                  ),
                                  Expanded(
                                    child: contentBuilder(currentStep),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 100,
                            padding: const EdgeInsets.only(right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                canGoPrevious
                                    ? ElevatedButton(
                                        onPressed:
                                            canGoPrevious ? onPrevious : null,
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.all(8),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          backgroundColor: HexColor("#262728"),
                                        ),
                                        child: Icon(
                                          Icons.arrow_back,
                                          color: HexColor("#FFFFFF"),
                                          size: 16,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                canGoNext
                                    ? ElevatedButton(
                                        onPressed: canGoNext ? onNext : null,
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          elevation: 0,
                                          backgroundColor: Colors.transparent,
                                        ),
                                        child: Ink(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                HexColor("#1C509D"),
                                                HexColor("#08959E"),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 35,
                                            width: 90,
                                            child: const Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  'Next ',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.arrow_forward,
                                                  color: Colors.white,
                                                  size: 18,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: -45,
              left: 0,
              child: titleWidget,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildStepList() {
    List<Widget> widgets = [];

    for (int i = 0; i < steps.length; i++) {
      final step = steps[i];
      final isCurrentStep = i == currentStepIndex;

      // Add step row
      widgets.add(
        GestureDetector(
          onTap: () => onStepSelected?.call(i),
          child: Row(
            children: [
              Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      isCurrentStep ? HexColor("#FFFFFF") : HexColor("#444445"),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                step.title,
                style: TextStyle(
                  color:
                      isCurrentStep ? HexColor("#FFFFFF") : HexColor("#444445"),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      );

      // Add connector line (except for the last step)
      if (i < steps.length - 1) {
        widgets.add(const SizedBox(height: 8));
        widgets.add(
          Container(
            height: 15,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: HexColor("#262728"),
                  width: 1,
                ),
              ),
            ),
          ),
        );
        widgets.add(const SizedBox(height: 8));
      }
    }

    return widgets;
  }
}
