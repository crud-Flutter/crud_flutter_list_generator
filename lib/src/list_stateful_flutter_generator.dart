import 'package:code_builder/code_builder.dart';
import 'package:crud_flutter_list_generator/crud_flutter_list_generator.dart';
import 'package:crud_generator/crud_generator.dart';

class ListStatefulFlutterGenerator
    extends GenerateFlutterWidgetForAnnotation<ListEntity> {
  @override
  void generateConstructors() {}

  @override
  void generateFields() {}

  @override
  void generateMethods() {
    addImportPackage('${element.name.toLowerCase()}.list.state.dart');
    declareMethod('createState',
        returns: refer('${element.name}ListFulPageState'),
        lambda: true,
        body: Code('${element.name}ListFulPageState()'));
  }

  @override
  String generateName() => '${element.name}ListFulPage';

  @override
  GenerateClassForAnnotation instance() => null;
  @override
  void optionalClassInfo() {
    extend = refer('StatefulWidget');
    addImportPackage('package:flutter/material.dart');
  }
}
