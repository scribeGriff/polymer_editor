import 'package:polymer/polymer.dart';
import 'dart:html';
import 'package:ace/ace.dart' as ace;

@CustomTag('editor-element')
class Editor extends PolymerElement {
  @published String choice;
  String mode;
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

  var editor, editorBkgd;
  var initCursorPosition;
  Element viewer, viewerBkgd;

  bool get applyAuthorStyles => true;

  Editor.created() : super.created();

  @override
  void attributeChanged(String attrName, String oldVal, String newVal) {
    super.attributeChanged(attrName, oldVal, newVal);
    if (attrName == 'choice' && newVal != oldVal) {
      updateTheme(newVal);
    }
  }

  @override
  enteredView() {
    super.enteredView();
    ace.require('ace/ext/language_tools');
    viewer = $['editor'];
    viewerBkgd = $['editor-background'];
    editor = ace.edit(viewer)
        ..theme = new ace.Theme("ace/theme/$choice")
        ..session.mode = new ace.Mode("ace/mode/$mode")
        ..session.tabSize = 2
        ..session.useSoftTabs = true
        ..fontSize = 15
        ..setOptions({
          'enableBasicAutocompletion' : true,
          'enableSnippets' : true
        });
    editor.session.insert(editor.cursorPosition, "${resultsAll[id]}");

    // A background editor that is just for better ux when
    // transitioning between themes.
    editorBkgd = ace.edit(viewerBkgd)
        ..theme = new ace.Theme("ace/theme/$choice")
        ..session.mode = new ace.Mode("ace/mode/$mode")
        ..session.tabSize = 2
        ..session.useSoftTabs = true
        ..fontSize = 15;
    editorBkgd.session.insert(editor.cursorPosition, "${resultsAll[id]}");
    initCursorPosition = editorBkgd.cursorPosition;
  }

  updateTheme(String newTheme) {
    if (viewer != null) {
      // This is stopping the rendering engine.  Why is that and how to fix?
      //var text = editor.session.getAllLines();
      //editorBkgd.session.replace(new ace.Range.fromPoints(initCursorPosition,
          //editorBkgd.cursorPosition), editor.session.getAllLines());
      editorBkgd.theme = new ace.Theme("ace/theme/$newTheme");
      viewer.classes.add('fade');
      viewer.onTransitionEnd.first.then((_) {
        editor.theme = new ace.Theme("ace/theme/$newTheme");
        viewer.classes.remove('fade');
      });
    }
  }
}