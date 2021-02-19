import 'dart:io';

String fixture(String name) =>
    File('test/app/fixtures/$name').readAsStringSync();
