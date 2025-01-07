class FileImage {
  const FileImage({
    required this.path,
    required this.name,
    required this.lastModified,
  });

  final String path;
  final String? name;
  final DateTime? lastModified;
}
