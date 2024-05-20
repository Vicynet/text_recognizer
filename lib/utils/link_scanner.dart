class LinkScanner {
  Iterable<RegExpMatch> findLinks(String text) {
    final RegExp urlRegExp = RegExp(
      r'(https?:\/\/[^\s]+)',
      caseSensitive: false,
    );
    return urlRegExp.allMatches(text);
  }
}
