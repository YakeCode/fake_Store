class ImageValidator {
  static bool isValidUrl(String? url) {
    if (url == null || url.isEmpty) return false;

    try {
      final uri = Uri.parse(url);
      return uri.isScheme('http') || uri.isScheme('https');
    } catch (_) {
      return false;
    }
  }

  static bool hasValidImage(List<String>? images) {
    return images != null && images.any(isValidUrl);
  }

  static String? getFirstValidUrl(List<String>? images) {
    if (images == null) return null;

    try {
      return images.firstWhere(
        (url) => isValidUrl(url),
        orElse: () => '',
      );
    } catch (_) {
      return null;
    }
  }
}
