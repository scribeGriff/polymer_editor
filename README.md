
## The Ace Editor as a Polymer Element in Dart ##

Using Ross Smith's awesome Ace api to make an editor element in Polymer.dart (JS-Interop now works in Polymer.dart).

Verified that there are no issues with latest update involving [implementation decoupling](https://github.com/rmsmith/ace.dart/pull/30 "implementation decoupling").  Note that only the index of the selected theme is saved to local storage.  If you select a dark theme but have the light theme menu selected, upon reloading, the dark theme menu will be selected.  Not sure if this is a bit ux deal or not.

### Bug List:

- Updating background document with main document's text is not working correctly for windows sized to display a horizontal scroll bar.  The transition between themes shows the entire background window without the scrollbar.  Probably need to capture the left side position of main document or some such thing.  Needs investigating.

### Todo:    
- save code to indexdb (include autosave)  
- add search element

### Usage:

````html
<!DOCTYPE html>

<html>
  <head>
    <meta charset="utf-8">
    <title>The Ace Editor as a Polymer Element</title> 
    <link rel="import" href="elements/ace_editor.html">
    <style>
      @font-face {
        font-family: 'FontAwesome';
        src: url('font-awesome-4.0.3/fonts/fontawesome-webfont.eot?v=4.0.3');
        src: url('font-awesome-4.0.3/fonts/fontawesome-webfont.eot?#iefix&v=4.0.3') format('embedded-opentype'), url('font-awesome-4.0.3/fonts/fontawesome-webfont.woff?v=4.0.3') format('woff'), url('font-awesome-4.0.3/fonts/fontawesome-webfont.ttf?v=4.0.3') format('truetype'), url('font-awesome-4.0.3/fonts/fontawesome-webfont.svg?v=4.0.3#fontawesomeregular') format('svg');
        font-weight: normal;
        font-style: normal;
      }
    </style>
    <script type='application/dart'>export 'package:polymer/init.dart';</script>
    <script type="text/javascript" src="packages/browser/dart.js"></script>  
    <script type="text/javascript" src="packages/browser/interop.js"></script>
    <script type="text/javascript" src="packages/ace/src/js/ace.js"></script>
    <script type="text/javascript" src="packages/ace/src/js/ext-language_tools.js"></script>
  </head>
  <body>
    <div>
      <ace-editor lang="dart"></ace-editor>
    </div>
  </body>
</html>
````

### Screenshot as polymer element:

![Ace editor as polymer element](http://www.scribegriff.com/dartlang/github/filter-code.jpg)

### References:  
[ace.dart](https://github.com/rmsmith/ace.dart "ace.dart")     
