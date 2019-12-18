import 'package:crud_generator/crud_generator.dart';

class GenerateListFlutterClass extends GenerateEntityClassAbstract {
  StringBuffer widget = new StringBuffer();
  String titlePage;
  String listTitle;
  String listSubTitle;

  GenerateListFlutterClass(String name)
      : super(name, classSuffix: 'Page', parentClass: 'StatelessWidget');

  @override
  addImports() {
    generateClass.writeln('import \'package:flutter/material.dart\';');
  }

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

  _widget() {
    generateClass.writeln('Widget build(BuildContext context) {');
    generateClass.writeln('return Scaffold(');
    generateClass.writeln('appBar: AppBar(');
    generateClass.writeln('title: Text(\'$titlePage' + 's\'),');
    generateClass.writeln('),');
    generateClass.writeln('body: Container(),');
    generateClass.writeln('floatingActionButton: FloatingActionButton(');
    generateClass.writeln('child: Icon(Icons.add),');
    generateClass.writeln('),');
    generateClass.writeln(');');
    generateClass.writeln('}');
  }


  @override
  String build() {
    // this._bloc();
    this._widget();
    return super.build();
  }
}
