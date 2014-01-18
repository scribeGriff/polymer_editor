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
/**
 * Computing the impulse response of a digital filter.
 *
 * The filter is defined by the following difference equation:
 * y(n) - y(n - 1) + 0.9y(n - 2) = x(n)
 *
 */

import 'dart:html';
import 'package:convolab/convolab.dart';
import 'package:simplot/simplot.dart';

void main() {
  // Define a canvas for drawing a 2D plot of the impulse response.
  Plot2D impulsePlot;
  // Define an impulse sequence.
  Sequence x = impseq(141, 20);
  // Define a position sequence for the impulse.
  Sequence n = x.position(20);
  // Define the numerator coefficient of the filter.
  Sequence b = sequence([1]);
  // Define the denominator coefficient of the filter.
  Sequence a = sequence([1, -1, 0.9]);
  // Compute the impulse response.
  FilterResults h = filter(b, a, x);
  // Print the response and the final conditions.
  print(h.x);
  print(h.z);
  // Determine the stability of the filter by calculating the sum(abs(h(n)).
  print(h.x.abs().sum());
  
  // Plot the impulse response of the filter.
  impulsePlot = plot(h.x.toList(), xdata:n.toList(), shadow:element,
      style1:'data', color1:'blue', range:2, index:1);
  impulsePlot
      ..grid()
      ..title(title)
      ..ymarker(0, width:2);
}
""";

  ace.Editor editor, editorBkgd;
  ace.Document mainDoc, bkgdDoc;
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
        ..focus()
        ..setOptions({
          'enableBasicAutocompletion' : true,
          'enableSnippets' : true
        });
    mainDoc = editor.session.document;
    mainDoc.insert(editor.cursorPosition, "${resultsAll[id]}");

    // A background editor that is just for better ux when
    // transitioning between themes.
    editorBkgd = ace.edit(viewerBkgd)
        ..theme = new ace.Theme("ace/theme/$choice")
        ..session.mode = new ace.Mode("ace/mode/$mode")
        ..session.tabSize = 2
        ..session.useSoftTabs = true
        ..fontSize = 15
        ..readOnly = true;
    bkgdDoc = editorBkgd.session.document;
    bkgdDoc.insert(editor.cursorPosition, "${resultsAll[id]}");
  }

  updateTheme(String newTheme) {
    ace.Point activeCursorPos;
    ace.Point bkgdCursorPos;
    int rowDelta;

    if (viewer != null) {
      // Update background document with main document's text, keeping
      // track of cursor position during the transition.
      // This part is not working correctly for windows sized to present
      // a horizontal scroll bar.  Need the cursor position of main document.
      editorBkgd.navigateFileEnd();
      String currentText = mainDoc.getAllLines().join("\n");
      bkgdDoc.replace(new ace.Range.fromPoints(new ace.Point(0, 0),
          editorBkgd.cursorPosition), currentText);
      activeCursorPos = editor.cursorPosition;
      bkgdCursorPos = editorBkgd.cursorPosition;
      rowDelta = activeCursorPos.row - bkgdCursorPos.row;
      if (rowDelta != 0) {
        if(rowDelta < 0) {
          editorBkgd.navigateUp(rowDelta.abs());
        } else {
          editorBkgd.navigateDown(rowDelta);
        }
      }
      editorBkgd.theme = new ace.Theme("ace/theme/$newTheme");
      viewer.classes.add('fade');
      viewer.onTransitionEnd.first.then((_) {
        editor.theme = new ace.Theme("ace/theme/$newTheme");
        viewer.classes.remove('fade');
      });
      editor.focus();
    }
  }
}