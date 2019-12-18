import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:crud_flutter_list_generator/crud_flutter_list_generator.dart';
import 'package:crud_generator/crud_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_gen/src/constants/reader.dart';

class ListStatelessFlutterGenerator extends GeneratorForAnnotation<ListEntity> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    return GenerateListStatelessFlutterClass(element.name)
        .setTitlePage(getValueAnnotation(element, annotation, 'titlePage'))        
        .build();
  }
}

class GenerateListStatelessFlutterClass extends GenerateFlutterWidgetAbstract {
  String titlePage;
  String listTitle;
  String listSubTitle;

  GenerateListStatelessFlutterClass(String name)
      : super(name, classSuffix: 'ListPage', parentClass: 'StatelessWidget');

  GenerateListStatelessFlutterClass setTitlePage(String titlePage) {
    if (titlePage == null) {
      this.titlePage = classPrefix + 's';
    }else {
      this.titlePage = titlePage;
    }    
    return this;
  }

  GenerateListStatelessFlutterClass setListTitle(String title) {
    listTitle = title;
    return this;
  }

  GenerateListStatelessFlutterClass setListSubTitle(String title) {
    listSubTitle = title;
    return this;
  }

  @override
  void generateWidget() {
    generateClass.writeln('Widget build(BuildContext context) {');
    generateClass.writeln('return Scaffold(');
    generateClass.writeln('appBar: AppBar(');
    generateClass.writeln('title: Text(\'$titlePage\'),');
    generateClass.writeln('),');
    generateClass.writeln('body: $classPrefix' 'ListFulPage(),');
    generateClass.writeln('floatingActionButton: FloatingActionButton(');
    generateClass.writeln('child: Icon(Icons.add),');
    generateClass.writeln('),');
    generateClass.writeln(');');
    generateClass.writeln('}');
  }

  @override
  void addImports() {
    super.addImports();
    importGenerate('list.stateful');
  }
}
