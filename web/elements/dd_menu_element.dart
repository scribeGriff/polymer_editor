import 'dart:html';
import 'package:polymer/polymer.dart';

class Item extends Observable {
  @observable String name;
  @observable String icon;

  Item(this.name, this.icon);
}

@CustomTag('dropdown-menu-element')
class DropdownMenuElement extends PolymerElement {
  @observable String selected = 'ambiance';
  @published String choice = '';
  final List<Item> items = [
                            new Item('ambiance', 'fa fa-glass'),
                            new Item('chaos', 'fa fa-bolt'),
                            new Item('chrome', 'fa fa-desktop'),
                            new Item('clouds', 'fa fa-cloud'),
                            new Item('github', 'fa fa-github')
                            ];

  Element ddmenu;

  DropdownMenuElement.created() : super.created() {
    choice = selected;
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
    selected = target.attributes["id"];
    choice = selected;
  }

  removeActiveClass() {
    ddmenu.classes.remove('active');
  }
}