class SliderModel {
  String title;
  String icon;
  String subtitle;
  String buttonLabel;
  bool active;
  String indicatorText;
  SliderModel(
      {this.indicatorText,
      this.buttonLabel,
      this.icon,
      this.subtitle,
      this.title,
      this.active});
  List<SliderModel> get items => [
        SliderModel(
            title: 'Professional diagnose and treatment plan.',
            subtitle:
                'Do you suffer any specific skin desease and need medical help or do you want your skin analyzed?',
            active: true,
            buttonLabel: 'Let’s start',
            indicatorText: 'Contact dermatologist',
            icon: 'assets/icon_adviser.svg'),
        SliderModel(
          title: 'The dermatologist is analyzing your case.',
          subtitle: 'This may take up to 48h.',
          icon: 'assets/dematologist.svg',
          active: true,
          indicatorText: 'Analyzing your case',
          buttonLabel: 'Enable notifications',
        ),
        SliderModel(
          title: 'Your treatment is available!',
          indicatorText: 'Professional diagnose',
          subtitle:
              'The dermatologist analyzed your skin and made suggestions for treatment.',
          icon: 'assets/dematologist.svg',
          active: true,
          buttonLabel: 'My current treatment',
        ),
        SliderModel(
            title: 'Professional diagnose and treatment plan.',
            indicatorText: 'Your treatment',
            subtitle:
                'In the future you will have the opportunity to get your skin analyzed by a professional dermatologist.',
            buttonLabel: 'Coming soon',
            active: false,
            icon: 'assets/icon_adviser.svg'),
      ];
}
