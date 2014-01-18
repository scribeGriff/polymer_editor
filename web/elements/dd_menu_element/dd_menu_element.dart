import 'dart:html';
import 'dart:convert';
import 'package:polymer/polymer.dart';

class Item extends Observable {
  @observable String name;
  @observable String icon;
  @observable bool dark;

  Item(this.name, this.icon, this.dark);

  String get cname => name.split("_").map((word) =>
      word.substring(0,1).toUpperCase() + word.substring(1)).join(" ");
}

@CustomTag('dropdown-menu-element')
class DropdownMenuElement extends PolymerElement {
  @published String choice;
  @observable bool darkTheme = false;
  @observable String commonName;
  @observable int savedIndex = 4;
  final List<Item> items = [
                            new Item('ambiance', 'fa fa-glass', true),
                            new Item('chaos', 'fa fa-bolt', true),
                            new Item('chrome', 'fa fa-desktop', false),
                            new Item('clouds', 'fa fa-cloud', false),
                            new Item('github', 'fa fa-github', false),
                            new Item('clouds_midnight', 'fa fa-cloud', true),
                            new Item('cobalt', 'fa fa-flask', true),
                            new Item('crimson_editor', 'fa fa-file-text-o', false),
                            new Item('dawn', 'fa fa-rocket', false),
                            new Item('dreamweaver', 'fa fa-magic', false),
                            new Item('eclipse', 'fa fa-moon-o', false),
                            new Item('kr_theme', 'fa fa-shield', true),
                            new Item('merbivore', 'fa fa-align-justify', true),
                            new Item('merbivore_soft', 'fa fa-bars', true),
                            new Item('monokai', 'fa fa-road', true),
                            new Item('pastel_on_dark', 'fa fa-leaf', true),
                            new Item('solarized_dark', 'fa fa-star', true),
                            new Item('solarized_light', 'fa fa-star-o', false),
                            new Item('terminal', 'fa fa-terminal', true),
                            new Item('textmate', 'fa fa-columns', false),
                            new Item('tomorrow', 'fa fa-calendar-o', false),
                            new Item('tomorrow_night_blue', 'fa fa-calendar', true),
                            new Item('tomorrow_night_bright', 'fa fa-calendar-o', true),
                            new Item('twilight', 'fa fa-adjust fa-rotate-90', true),
                            new Item('vibrant_ink', 'fa fa-pencil-square-o', true),
                            new Item('xcode', 'fa fa-apple', false)
                            ];

  Element ddmenu;

  DropdownMenuElement.created() : super.created() {
    String json = window.localStorage['themeIndex'];

    if (json != null) savedIndex = JSON.decode(json);

    darkTheme = items[savedIndex].dark;
    choice = items[savedIndex].name;
    commonName = items[savedIndex].cname;

    onPropertyChange(this, #darkTheme, () =>
        notifyPropertyChange(#themeClass, null, darkTheme));
  }

  enteredView() {
    super.enteredView();
    ddmenu = $['dd'];
    document.onClick.listen((e) {
      if (e.target.toString() != 'ace-editor') {
        removeActiveClass();
      }
    });

    ddmenu.onClick.listen((e) {
      ddmenu.classes.toggle('active');
    });
  }

  select(Event e, var detail, Element target) {
    e.preventDefault();
    choice = target.id;
    commonName = target.text;
    savedIndex = items.indexOf(items.firstWhere(((item) =>
        item.name == choice)));
  }

  removeActiveClass() {
    ddmenu.classes.remove('active');
  }

  toggleDark(Event e, var detail, Element target) {
    if (ddmenu.classes.contains('active')) {
      ddmenu.classes.toggle('active');
      ddmenu.onTransitionEnd.first.then((_) {
        darkTheme = !darkTheme;
        ddmenu.classes.toggle('active');
      });
    } else {
      darkTheme = !darkTheme;
    }
  }

  @reflectable String get themeClass {
    if (darkTheme) return 'dd-select-dark';
    else return 'dd-select-light';
  }
}