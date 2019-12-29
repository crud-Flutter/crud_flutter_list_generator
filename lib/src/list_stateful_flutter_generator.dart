import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:crud_flutter_list_generator/crud_flutter_list_generator.dart';
import 'package:crud_generator/crud_generator.dart';
import 'package:source_gen/source_gen.dart';

class ListStatefulFlutterGenerator
    extends GenerateFlutterWidgetForAnnotation<ListEntity> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    init();
    name = '${element.name}ListFulPage';
    this.element = element;
    this.annotation = annotation;
    extend = refer('StatefulWidget');
    addImportPackage('package:flutter/material.dart');
    _methodCreateState();
    return build();
  }

  void _methodCreateState() {
    addImportPackage('${element.name.toLowerCase()}.list.state.dart');
    declareMethod('createState',
        returns: refer('${element.name}ListFulPageState'),
        lambda: true,
        body: Code('${element.name}ListFulPageState()'));
  }
}
