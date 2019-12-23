// import 'dart:async';

// import 'package:analyzer/dart/element/element.dart';
// import 'package:build/src/builder/build_step.dart';
// import 'package:crud_flutter_list_generator/crud_flutter_list_generator.dart';
// import 'package:crud_generator/crud_generator.dart';
// import 'package:source_gen/source_gen.dart';

import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:crud_flutter_list_generator/crud_flutter_list_generator.dart';
import 'package:crud_generator/crud_generator.dart';
import 'package:source_gen/source_gen.dart';

class ListStateFlutterBuilder
    extends GenerateFlutterWidgetForAnnotation<ListEntity> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    name = '${element.name}ListFulPageState';
    extend = refer('State<${element.name}ListFulPage>');
    this.element = element;
    this.annotation = annotation;
    _declareField();
    _methodBuild();
    return "import '${element.name.toLowerCase()}.list.stateful.dart';"
            "import '${element.name.toLowerCase()}.bloc.dart';" +
        build();
  }

  void _declareField() {
    declareField(refer('${element.name}Bloc'), '_bloc',
        assignment: Code('${element.name}Bloc()'));
  }

  void _methodBuild() {
    var buildCode = [
      Code('return StreamBuilder<List<$entityClass>>('),
      Code('stream: _bloc.list,'),
      Code('builder: (context, snapshot) {'),
      Code(
          'if (!snapshot.hasData) return Center(child: CircularProgressIndicator());'),
      // Code(
      //     'if (snapshot.hasError) return SimpleDilaog(title: snapshot.error);'),
      Code('return ListView('),
      Code('children: snapshot.data.map(($entityInstance) {'),
      Code('return ListTile(')
    ];
    try {
      buildCode.add(Code(
          'title: Text($entityInstance.${getAnnotationValue("listTitle").stringValue}),'));
    } catch (e) {}
    try {
      buildCode.add(Code(
          'subtitle: Text($entityInstance.${getAnnotationValue("listSubTitle").stringValue}),'));
    } catch (e) {}
    buildCode.add(Code(');'));
    buildCode.add(Code('}).toList()'));
    buildCode.add(Code(');'));
    buildCode.add(Code('},'));
    buildCode.add(Code(');'));
    var blockBuilder = BlockBuilder();
    blockBuilder.statements.addAll(buildCode);
    methodBuild(blockBuilder.build());
  }
}
