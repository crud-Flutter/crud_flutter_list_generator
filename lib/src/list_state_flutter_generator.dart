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
    init();
    name = '${element.name}ListFulPageState';
    extend = refer('State<${element.name}ListFulPage>');
    this.element = element;
    this.annotation = annotation;
    _declareField();
    _methodBuild();
    return "import '${element.name.toLowerCase()}.list.stateful.dart';"
            "import '${element.name.toLowerCase()}.form.stateful.dart';"
            "import '${element.name.toLowerCase()}.entity.dart';"
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
      Code('return ListTile('),
      Code(
          'onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ${element.name}FormPage($entityInstance: $entityInstance)));},')
    ];
    try {
      buildCode.add(Code(
          'title: Text($entityInstance.${getAnnotationValue("listTitle").stringValue}),'));
    } finally {
      try {
        buildCode.add(Code(
            'subtitle: Text($entityInstance.${getAnnotationValue("listSubTitle").stringValue}),'));
      } catch (e) {} finally {
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
  }
}
