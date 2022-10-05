import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

const String httpBaseAddress = kReleaseMode ? 'https://shopping-list-et-webapp.azurewebsites.net' : kIsWeb ? 'http://localhost:5062'
: "http://10.0.2.2:5062";
