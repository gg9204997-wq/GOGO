import 'package:equatable/equatable.dart';

final class OnboardingStepEntity extends Equatable {
  const OnboardingStepEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.icon,
  });

  final String id;
  final String title;
  final String description;
  final String imagePath;
  final String icon;

  static const List<OnboardingStepEntity> defaultSteps = <OnboardingStepEntity>[
    OnboardingStepEntity(
      id: '1',
      title: 'Welcome to Joojo Chat',
      description: 'Connect with people worldwide through voice chat rooms',
      imagePath: 'assets/images/onboarding_1.png',
      icon: 'chat_bubble',
    ),
    OnboardingStepEntity(
      id: '2',
      title: 'Join Voice Rooms',
      description: 'Create or join rooms and start talking instantly',
      imagePath: 'assets/images/onboarding_2.png',
      icon: 'mic',
    ),
    OnboardingStepEntity(
      id: '3',
      title: 'Send Gifts',
      description: 'Show appreciation by sending virtual gifts',
      imagePath: 'assets/images/onboarding_3.png',
      icon: 'gift',
    ),
    OnboardingStepEntity(
      id: '4',
      title: 'Level Up',
      description: 'Earn XP, unlock badges, and climb the rankings',
      imagePath: 'assets/images/onboarding_4.png',
      icon: 'star',
    ),
  ];

  @override
  List<Object?> get props => <Object?>[id, title, description, imagePath, icon];
}
