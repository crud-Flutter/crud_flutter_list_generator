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
    init();
    name = '${element.name}ListPage';
    this.element = element;
    this.annotation = annotation;
    extend = refer('StatelessWidget');
    var create = true;
    var drawer = false;
    try {
      drawer = getAnnotationValue('drawer').boolValue;
    } catch (e) {}
    try {
      create = getAnnotationValue('create').boolValue;
    } finally {
      _methodBuild(create, drawer);
      return "import '${element.name.toLowerCase()}.list.stateful.dart';" +
          (create
              ? "import '${element.name.toLowerCase()}.form.stateful.dart';"
              : '') +
          (drawer ? "import '../drawer.dart';" : '') +
          build();
    }
  }

  void _methodBuild(bool create, bool drawer) {
    var titlePage;
    try {
      titlePage = getAnnotationValue('titlePage').stringValue;
    } catch (e) {
      titlePage = '${element.name}s';
    }
    var body = Code('body: ${element.name}ListFulPage(),');
    var fab;
    if (create) {
      fab = instanceFab(
          Code('Icon(Icons.add)'),
          Code(
              '(){Navigator.push(context, MaterialPageRoute(builder: (context) => ${element.name}FormPage()));}'));
    }
    methodBuild(
        instanceScaffold(titlePage, body: body, fab: fab, drawer: drawer));
  }
}
