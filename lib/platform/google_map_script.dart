import 'dart:async';
import 'dart:js_util' as js_util;
import 'dart:html' as html;

/// This function is used to load the Google Maps script manually because the
/// Google map is causing issue on Web.
Future<void> loadGoogleMapsScript(String apiKey) async {
  if (js_util.hasProperty(js_util.globalThis, 'google') &&
      js_util.hasProperty(js_util.getProperty(js_util.globalThis, 'google'), 'maps')) {
    return;
  }

  final completer = Completer<void>();
  final script = html.ScriptElement()
    ..src = 'https://maps.googleapis.com/maps/api/js?key=$apiKey&libraries=drawing'
    ..async = true
    ..defer = true;

  script.onLoad.listen((_) => completer.complete());
  script.onError.listen((_) => completer.completeError('Google Maps script failed'));

  html.document.head!.append(script);
  return completer.future;
}