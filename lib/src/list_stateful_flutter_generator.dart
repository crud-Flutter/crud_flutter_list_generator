import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:crud_flutter_list_generator/crud_flutter_list_generator.dart';
import 'package:crud_flutter_list_generator/src/class_source.dart';
import 'package:source_gen/source_gen.dart';

class ListStatefulFlutterGenerator extends GeneratorForAnnotation<ListEntity> {
  @override
  FutureOr<String> generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    return GenerateListStatefulFlutterClass(element.name).build();
  }

}