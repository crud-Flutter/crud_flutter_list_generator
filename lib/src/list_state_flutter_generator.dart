import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:crud_flutter_list_generator/crud_flutter_list_generator.dart';
import 'package:crud_generator/crud_generator.dart';
import 'package:source_gen/source_gen.dart';

class ListStateFlutterBuilder extends GeneratorForAnnotation<ListEntity> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    return GenerateListStateFlutterClass(element.name)
        .setListTitle(getValueAnnotation(element, annotation, 'listTitle'))
        .setListSubTitle(
            getValueAnnotation(element, annotation, 'listSubTitle'))
        .build();
  }
}

class GenerateListStateFlutterClass extends GenerateFlutterWidgetAbstract {
  String listTitle;
  String listSubTitle;
  GenerateListStateFlutterClass(String name)
      : super(name,
            classSuffix: 'ListPageState',
            parentClass: 'State<$name' 'ListFulPage>') {
    generateClass.writeln('final _bloc = $classPrefix' 'Bloc();');
  }

  GenerateListStateFlutterClass setListTitle(String listTitle) {
    this.listTitle = listTitle;
    return this;
  }

  GenerateListStateFlutterClass setListSubTitle(String listSubTitle) {
    this.listSubTitle = listSubTitle;
    return this;
  }

  @override
  void generateWidget() {
    generateClass.writeln('Widget build(BuildContext context) {');
    generateClass.writeln('return StreamBuilder<List<$entityClass>>(');
    generateClass.writeln('stream: _bloc.$nameLowerCase' 's,');
    generateClass.writeln('builder: (context, snapshot) {');
    generateClass
        .writeln('if (!snapshot.hasData) return CircularProgressIndicator();');
    // generateClass.writeln(
    //     'if (snapshot.hasError) return SimpleDilaog(title: snapshot.error);');
    generateClass.writeln('return ListView(');
    generateClass.writeln('children: snapshot.data.map(($entityInstance) {');
    generateClass.writeln('return ListTile(');
    if (listTitle != null) {
      generateClass.writeln('title: Text($entityInstance.$listTitle),');
    }
    if (listSubTitle != null) {
      generateClass.writeln('subtitle: Text($entityInstance.$listSubTitle),');
    }
    generateClass.writeln(');');
    generateClass.writeln('}).toList()');
    generateClass.writeln(');');
    generateClass.writeln('},');
    generateClass.writeln(');');
    generateClass.writeln('}');
  }

  @override
  void addImports() {
    super.addImports();
    importEntity();
    importGenerate('list.stateful');
    importGenerate('bloc');
  }
}
