
## The Ace Editor as a Polymer Element in Dart ##

Using Ross Smith's awesome Ace api to make an editor element in Polymer.dart (JS-Interop now works in Polymer.dart).

### Todo:  
- css to handle theme changes (transition)  
- layout cleanup (bootstrap?)  
- read theme selections from file with ajax (possibly from polymer_elements library)  
- save code to localstorage or indexdb (include autosave)  
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

### References:  
[ace.dart](https://github.com/rmsmith/ace.dart "ace.dart")     
