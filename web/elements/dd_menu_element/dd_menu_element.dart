import 'dart:html';
import 'package:polymer/polymer.dart';

class Item extends Observable {
  @observable String name;
  @observable String icon;
  @observable bool dark;

  Item(this.name, this.icon, this.dark);
}

@CustomTag('dropdown-menu-element')
class DropdownMenuElement extends PolymerElement {
  @published bool darkTheme = false;
  @published String choice;
  final List<Item> items = [
                            new Item('ambiance', 'fa fa-glass', true),
                            new Item('chaos', 'fa fa-bolt', true),
                            new Item('chrome', 'fa fa-desktop', false),
                            new Item('clouds', 'fa fa-cloud', false),
                            new Item('github', 'fa fa-github', false),
                            new Item('clouds_midnight', 'fa fa-glass', true),
                            new Item('cobalt', 'fa fa-bolt', true),
                            new Item('crimson_editor', 'fa fa-desktop', false),
                            new Item('dawn', 'fa fa-cloud', false),
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
    choice = darkTheme ? 'ambiance' : 'github';
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
    choice = target.attributes["id"];
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