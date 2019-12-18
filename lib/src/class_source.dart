import 'package:crud_generator/crud_generator.dart';

abstract class GenerateFlutterWidgetAbstract
    extends GenerateEntityClassAbstract {
  GenerateFlutterWidgetAbstract(String name,
      {String classSuffix, String parentClass})
      : super(name, classSuffix: classSuffix, parentClass: parentClass);
  void generateWidget();

  @override
  void addImports() {
    generateClass.writeln('import \'package:flutter/material.dart\';');
  }

  @override
  String build() {
    generateWidget();
    return super.build();
  }
}

class GenerateListStatelessFlutterClass extends GenerateFlutterWidgetAbstract {
  String titlePage;
  String listTitle;
  String listSubTitle;

  GenerateListStatelessFlutterClass(String name)
      : super(name, classSuffix: 'ListPage', parentClass: 'StatelessWidget');

  GenerateListStatelessFlutterClass setTitlePage(String titlePage) {
    this.titlePage = titlePage;
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
    generateClass.writeln('body: Container(),');
    generateClass.writeln('floatingActionButton: FloatingActionButton(');
    generateClass.writeln('child: Icon(Icons.add),');
    generateClass.writeln('),');
    generateClass.writeln(');');
    generateClass.writeln('}');
  }
}

class GenerateListStatefulFlutterClass extends GenerateFlutterWidgetAbstract {
  GenerateListStatefulFlutterClass(String name)
      : super(name, classSuffix: 'ListFulPage', parentClass: 'StatefulWidget');
@override
  void generateWidget() {
    generateClass.writeln(classPrefix+'PageState createState() => $classPrefix'+'PageState();');
  }
}
