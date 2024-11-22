
String getImagePath(String name, {String format = 'png'}) {
  return 'assets/images/$name.$format';
}

String getIconPath(String name, {String format = 'svg'}) {
  return 'assets/icons/$name.$format';
}

String getRivePath(String name, {String format = 'riv'}) {
  return 'assets/rive/$name.$format';
}
