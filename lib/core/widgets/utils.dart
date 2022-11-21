

String twoDigits(int n) {
  if (n >= 10) return '$n';
  return '0$n';
}

String formatBySeconds(Duration duration) =>
    twoDigits(duration.inSeconds.remainder(60));

String formatByMinutes(Duration duration) {
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  return '$twoDigitMinutes:${formatBySeconds(duration)}';
}

String formatByHours(Duration duration) {
  return '${twoDigits(duration.inHours)}:${formatByMinutes(duration)}';
}

// ignore: missing_return
String? getErrorCode(int code) {
  if (code == 201) return 'FIELDS_ERRORS';
  if (code == 202) return 'RESOURCE_NOT_FOUND';
  if (code == 203) return 'DATA_NOT_SAVE';
  if (code == 300) return 'USERNOTFOUND';
  if (code == 301) return 'TOKENEXPIRE';
  if (code == 302) return 'INVALIDTOKEN';
  if (code == 303) return 'TOKENMISSING';
  if (code == 400) return 'REQUEST_VALIDATAION_ERROR';
  if (code == 404) return 'HTTP_NOT_FOUND';
  if (code == 1) return 'Socket Exception';
  if (code == 2) return 'Format Exception';
  if (code == 3) return 'Http Exception';
  if (code == 4) return 'Unknown Exception';
  return null;
}
