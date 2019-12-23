import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:code_builder/code_builder.dart';
import 'package:crud_flutter_list_generator/crud_flutter_list_generator.dart';
import 'package:crud_generator/crud_generator.dart';
import 'package:source_gen/source_gen.dart';

class ListStatelessFlutterGenerator
    extends GenerateFlutterWidgetForAnnotation<ListEntity> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    name = '${element.name}ListPage';
    this.element = element;
    this.annotation = annotation;
    extend = refer('StatelessWidget');
    _methodBuild();
    return "import '${element.name.toLowerCase()}.list.stateful.dart';" + build();
  }

  void _methodBuild() {
    var create = true;
    try {
      create = getAnnotationValue('create').boolValue;
    } catch (e) {}
    var titlePage = '${element.name}s';
    try {
      titlePage = getAnnotationValue('titlePage').stringValue;
    } catch (e) {}
    var body = Code('body: ${element.name}ListFulPage(),');
    if (create) {
      methodBuild(instanceScaffold(titlePage,
          body: body,
          fab: instanceFab(
              Code('Icon(Icons.add)'),
              Code(
                  '(){Navigator.push(context, MaterialPageRoute(builder: (context) => ${element.name}FormPage()));}'))));
    } else {
      methodBuild(instanceScaffold(
        titlePage,
        body: body,
      ));
    }
  }
}
