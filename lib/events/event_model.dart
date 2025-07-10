class Event{
  final String id;
  final String title;
  final String description;
  final String date;
  final String location;
  final String imageUrl;
  final List<String> badges;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.imageUrl,
    required this.badges,
  });
}
