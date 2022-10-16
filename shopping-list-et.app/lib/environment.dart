import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

const String httpBaseAddress = kReleaseMode ? 'https://shopping-list-et-webapp.azurewebsites.net' : kIsWeb ? 'http://localhost:5062'
: "http://192.168.87.116:5062";
