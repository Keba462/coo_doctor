class DatasetFields {
  String title;
  bool value;

  DatasetFields({
    required this.title,
    this.value = false,
  });
  @override
  String toString() {
    return 'DatasetFields{title: $title, value: $value}';
  }
}
