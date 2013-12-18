import 'package:polymer/polymer.dart';
import 'dart:html';
import 'package:ace/ace.dart' as ace;


@CustomTag('editor-element')
class Editor extends PolymerElement {
  //@published String id = '';
  @observable String choice = '';
  static String ncoeff = '1, 2, 3';
  static String nindex = '2';
  static String dcoeff = '4, 5, 6, 7';
  static String dindex = '0';

  final Map resultsAll = {
                          "convolution" : resultsConvolution

  };

  static String resultsConvolution = """
import 'package:convolab/convolab.dart';

void main() {
  // X sequence coefficients.
  Sequence x = sequence([$ncoeff]);
  // Create the X sequence position vector.
  Sequence n = x.position($nindex);
  // H sequence coefficients.
  Sequence h = sequence([$dcoeff]);
  // Create the H sequence position vector.
  Sequence nh = h.position($dindex);
  // Compute y = x * h
  var y = conv(x, h, n, nh);
  // Print the results.
  print(pstring(x, index:n.indexOf(0), variable:'z', name:'x'));
  print(pstring(h, index:nh.indexOf(0), variable:'z', name:'h'));
  print(y.format('latex', 'z', 'y'));
}
""";

  var editor;

  bool get applyAuthorStyles => true;

  Editor.created() : super.created();

  @override
  void attributeChanged(String attrName, String oldVal, String newVal) {
    super.attributeChanged(attrName, oldVal, newVal);
    print(attrName);
    print(oldVal);
    print(newVal);
    editor.theme = new ace.Theme("ace/theme/$newVal");
  }

  enteredView() {
    super.enteredView();
    ace.require('ace/ext/language_tools');
    editor = ace.edit($['editor'])
        ..theme = new ace.Theme("ace/theme/$choice")
        ..session.mode = new ace.Mode("ace/mode/dart")
        ..session.tabSize = 2
        ..session.useSoftTabs = true
        ..fontSize = 15
        ..setOptions({
          'enableBasicAutocompletion' : true,
          'enableSnippets' : true
        });
    editor.session.insert(editor.cursorPosition, "${resultsAll[id]}");
  }

  void compute(Event e, var detail, Element target) {
    e.preventDefault();
    //editor.session.insert(editor.cursorPosition, "${resultsAll[id]}");
    //editor.theme = new ace.Theme.named(ace.Theme.TEXTMATE);
    //print(ace.Theme.THEMES);
  }
}