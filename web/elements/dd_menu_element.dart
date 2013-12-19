import 'dart:html';
import 'package:polymer/polymer.dart';

class Item extends Observable {
  @observable String name;
  @observable String icon;

  Item(this.name, this.icon);
}

@CustomTag('dropdown-menu-element')
class DropdownMenuElement extends PolymerElement {
  @published String choice = 'ambiance';
  final List<Item> items = [
                            new Item('ambiance', 'fa fa-glass'),
                            new Item('chaos', 'fa fa-bolt'),
                            new Item('chrome', 'fa fa-desktop'),
                            new Item('clouds', 'fa fa-cloud'),
                            new Item('github', 'fa fa-github')
                            ];

  Element ddmenu;

  DropdownMenuElement.created() : super.created();

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
}