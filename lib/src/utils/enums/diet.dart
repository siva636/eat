enum Diet {
  nonvegetarian(value: 'nv', description: 'Nonvegetarian'),
  vegetarian(value: 'v', description: 'Vegetarian');

  const Diet({required this.value, required this.description});

  final String value;
  final String description;
}
