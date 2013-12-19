import 'dart:html';
import 'package:polymer/polymer.dart';

@CustomTag('ace-editor')
class Editor extends PolymerElement {
  @observable String theme;
  String lang;
  Editor.created() : super.created() {
    theme = this.theme;
  }

  enteredView() {
    super.enteredView();
    Element editor = $['editor-container'];
    editor.onClick.listen((e) {
      if (e.target.toString() != 'dropdown-menu-element') {
        $['themes'].xtag.removeActiveClass();
      }
    });
  }
}