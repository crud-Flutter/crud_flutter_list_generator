import 'package:crud_generator/crud_generator.dart';

abstract class GenerateFlutterWidgetAbstract
    extends GenerateEntityClassAbstract {
  GenerateFlutterWidgetAbstract(String name,
      {String classSuffix, String parentClass})
      : super(name, classSuffix: classSuffix, parentClass: parentClass);
  generateWidget();

  @override
  addImports() {
    generateClass.writeln('import \'package:flutter/material.dart\';');
  }

  @override
  String build() {
    this.generateWidget();
    return super.build();
  }
}

class GenerateListStatelessFlutterClass extends GenerateFlutterWidgetAbstract {
  StringBuffer widget = new StringBuffer();
  String titlePage;
  String listTitle;
  String listSubTitle;

  GenerateListStatelessFlutterClass(String name)
      : super(name, classSuffix: 'Page', parentClass: 'StatelessWidget');

  setTitlePage(String titlePage) {
    this.titlePage = titlePage;
    return this;
  }

  setListTitle(String title) {
    this.listTitle = title;
    return this;
  }

  setListSubTitle(String title) {
    this.listSubTitle = title;
    return this;
  }

  generateWidget() {
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

class GenerateListStatefullFlutterClass extends GenerateFlutterWidgetAbstract {
  GenerateListStatefullFlutterClass(String name)
      : super(name, classSuffix: 'FullPage', parentClass: 'StatefulWidget');
@override
  generateWidget() {
    generateClass.writeln(classPrefix+'PageState createState() => $classPrefix'+'PageState();');
  }
}
