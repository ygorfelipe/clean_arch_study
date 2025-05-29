import 'dart:io';

/// função para ler o arquivo json
String fixture(String name) => File('test/fixtures/$name').readAsStringSync();
