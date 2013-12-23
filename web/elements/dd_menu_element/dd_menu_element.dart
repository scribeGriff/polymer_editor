import 'dart:html';
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
  @published bool darkTheme = false;
  @published String choice;
  @published String commonName;
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
                            new Item('dreamweaver', 'fa fa-github', false),
                            new Item('eclipse', 'fa fa-glass', false),
                            new Item('kr_theme', 'fa fa-desktop', true),
                            new Item('merbivore', 'fa fa-cloud', true),
                            new Item('merbivore_soft', 'fa fa-github', true),
                            new Item('monokai', 'fa fa-bolt', true),
                            new Item('pastel_on_dark', 'fa fa-desktop', true),
                            new Item('solarized_dark', 'fa fa-cloud', true),
                            new Item('solarized_light', 'fa fa-github', false),
                            new Item('terminal', 'fa fa-glass', true),
                            new Item('textmate', 'fa fa-bolt', false),
                            new Item('tomorrow', 'fa fa-desktop', false),
                            new Item('tomorrow_night_blue', 'fa fa-github', true),
                            new Item('tomorrow_night_bright', 'fa fa-glass', true),
                            new Item('twilight', 'fa fa-desktop', true),
                            new Item('vibrant_ink', 'fa fa-cloud', true),
                            new Item('xcode', 'fa fa-github', false)
                            ];

  Element ddmenu;

  DropdownMenuElement.created() : super.created() {
    choice = darkTheme ? items.first.name : items[4].name;
    commonName = darkTheme ? items.first.cname : items[4].cname;
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
  }

  removeActiveClass() {
    ddmenu.classes.remove('active');
  }

  toggleDark(Event e, var detail, Element target) {
    target.parent.classes.toggle('dd-select-light');
    target.parent.classes.toggle('dd-select-dark');
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
}