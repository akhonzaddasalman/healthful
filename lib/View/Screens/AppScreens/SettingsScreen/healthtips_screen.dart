import 'package:flutter/material.dart';
import 'package:healthful/View/theme/light_color.dart';

class HealthTipsScreen extends StatelessWidget {
  HealthTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Tips'),
      ),
      body: ListView.builder(
        itemCount: healthTips.length,
        itemBuilder: (context, index) {
          String category = healthTips.keys.elementAt(index);
          List<String> tips = healthTips[category]!;
          return _buildCategoryItem(category, tips);
        },
      ),
    );
  }

  Widget _buildCategoryItem(String category, List<String> tips) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: LightColor.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: const Offset(4, 4),
            blurRadius: 10,
            color: LightColor.grey.withOpacity(.2),
          ),
          BoxShadow(
            offset: const Offset(-3, 0),
            blurRadius: 15,
            color: LightColor.grey.withOpacity(.1),
          )
        ],
      ),
      child: ExpansionTile(
        title: Text(category),
        children: tips.map((tip) => ListTile(title: Text(tip))).toList(),
      ),
    );
  }

  final Map<String, List<String>> healthTips = {
    'Clean Skin': [
      'Wash your face twice a day with a gentle cleanser.',
      'Use lukewarm water to avoid stripping your skin of natural oils.',
      'Apply moisturizer after cleansing to keep your skin hydrated.',
      'Avoid touching your face with dirty hands to prevent breakouts.',
    ],
    'Healthy Eating': [
      'Eat plenty of fruits and vegetables for vitamins and antioxidants.',
      'Choose lean proteins like chicken, fish, and tofu.',
      'Limit processed foods and sugary snacks.',
      'Stay hydrated by drinking water throughout the day.',
    ],
    'Exercise': [
      'Engage in regular physical activity for at least 30 minutes a day.',
      'Incorporate a variety of exercises such as cardio, strength training, and flexibility exercises.',
      'Find activities you enjoy to make exercise fun and sustainable.',
      'Listen to your body and avoid overexertion.',
    ],
    'Mental Health': [
      'Practice mindfulness and meditation to reduce stress.',
      'Connect with friends and family for emotional support.',
      'Seek professional help if you\'re struggling with mental health issues.',
      'Take breaks and prioritize self-care activities.',
    ],
    'Sleep Quality': [
      'Establish a consistent sleep schedule and stick to it even on weekends.',
      'Create a relaxing bedtime routine to signal to your body that it\'s time to sleep.',
      'Keep your bedroom cool, dark, and quiet for optimal sleep conditions.',
      'Limit screen time before bed to avoid disrupting your sleep cycle.',
    ],
    'Heart Health': [
      'Eat a heart-healthy diet rich in fruits, vegetables, whole grains, and lean proteins.',
      'Exercise regularly to strengthen your heart and improve cardiovascular health.',
      'Maintain a healthy weight to reduce the risk of heart disease.',
      'Manage stress through relaxation techniques such as deep breathing and yoga.',
    ],
    'Bone Health': [
      'Get enough calcium and vitamin D through diet and supplements if necessary.',
      'Engage in weight-bearing exercises like walking, running, and weightlifting to strengthen bones.',
      'Avoid smoking and excessive alcohol consumption, which can weaken bones.',
      'Schedule regular bone density tests as you age to monitor bone health.',
    ],
    'Hydration': [
      'Drink plenty of water throughout the day to stay hydrated.',
      'Monitor your urine color to gauge hydration levels - pale yellow is ideal.',
      'Eat water-rich foods like fruits and vegetables to increase hydration.',
      'Limit caffeine and alcohol, as they can contribute to dehydration.',
    ],
    'Posture': [
      'Sit and stand up straight with your shoulders back and your spine aligned.',
      'Take regular breaks from sitting to stretch and move around.',
      'Use ergonomic furniture and accessories to support good posture.',
      'Practice core-strengthening exercises to improve posture and stability.',
    ],
    'Eye Health': [
      'Take regular breaks from screens to prevent eye strain and fatigue.',
      'Wear sunglasses with UV protection when outdoors to shield your eyes from harmful rays.',
      'Eat a diet rich in antioxidants like vitamins A, C, and E to support eye health.',
      'Schedule regular eye exams to monitor vision and detect any issues early.',
    ],
    'Dental Hygiene': [
      'Brush your teeth twice a day with fluoride toothpaste to remove plaque and prevent cavities.',
      'Floss daily to clean between teeth and along the gumline where toothbrushes can\'t reach.',
      'Limit sugary snacks and beverages, which can contribute to tooth decay.',
      'Visit your dentist regularly for cleanings and check-ups to maintain oral health.',
    ],
    'Immune System': [
      'Eat a balanced diet with plenty of fruits, vegetables, and whole grains to support immune function.',
      'Get regular exercise to boost circulation and immune cell activity.',
      'Practice good hygiene by washing your hands frequently and avoiding contact with sick individuals.',
      'Get enough sleep each night to allow your body to rest and repair.',
    ],
    'Stress Management': [
      'Practice deep breathing exercises to calm the mind and body during stressful situations.',
      'Engage in regular physical activity to reduce stress and promote relaxation.',
      'Spend time outdoors in nature to improve mood and reduce stress levels.',
      'Seek support from friends, family, or a therapist if stress becomes overwhelming.',
    ],
    'Healthy Relationships': [
      'Communicate openly and honestly with your partner or loved ones to build trust and understanding.',
      'Set boundaries to protect your emotional well-being and maintain healthy relationships.',
      'Show appreciation and affection towards your loved ones to strengthen bonds and foster connection.',
      'Resolve conflicts respectfully and constructively to maintain harmony in relationships.',
    ],
    'Digital Detox': [
      'Set boundaries around screen time and establish tech-free zones in your home.',
      'Take regular breaks from electronic devices to reduce eye strain and mental fatigue.',
      'Engage in offline activities like reading, hobbies, or spending time with loved ones.',
      'Practice mindfulness and be present in the moment instead of constantly checking your phone or social media.',
    ],
    'Financial Wellness': [
      'Create a budget and track your spending to ensure financial stability and security.',
      'Save money regularly for emergencies, future goals, and retirement.',
      'Avoid unnecessary debt and pay off existing debts as quickly as possible.',
      'Invest in your future by contributing to retirement accounts and other long-term savings vehicles.',
    ],
  };
}
