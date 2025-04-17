extension StringExtension on String {
  String toTitleCase() => split(' ').map((w) => '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}').join(' ');
}
