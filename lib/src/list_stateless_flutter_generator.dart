import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:crud_flutter_list_generator/crud_flutter_list_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_gen/src/constants/reader.dart';

import 'class_source.dart';

class ListStatelessFlutterGenerator extends GeneratorForAnnotation<ListEntity> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    return GenerateListStatelessFlutterClass(element.name)
        .setTitlePage(_getTitlePage(element, annotation))
        .build();
  }

  String _getTitlePage(Element element, ConstantReader annotation) {
    try {
      return annotation.read('titlePage').stringValue;
    } catch (FormatException) {
      return element.name + 's';
    }
  }
}
