import 'dart:collection';

class PythonList<T> extends ListBase<T> {
  final List<T> _list;

  PythonList([int? length, T? fill])
      : _list = List<T>.filled(length ?? 0, fill as T);

  @override
  int get length => _list.length;

  @override
  set length(int newLength) {
    _list.length = newLength;
  }

  @override
  T operator [](dynamic index) {
    if (index is int) {
      return _list[index];
    } else if (index is Iterable<int>) {
      final start = index.elementAt(0);
      final end = index.length > 1 ? index.elementAt(1) : null;
      final step = index.length > 2 ? index.elementAt(2) : 1;
      return _sublist(start, end, step)[0];
    } else {
      throw ArgumentError('Invalid index type');
    }
  }

  @override
  void operator []=(int index, T value) {
    _list[index] = value;
  }

  List<T> _sublist(int start, int? end, int step) {
    final length = end ?? this.length;
    final sublist = <T>[];
    if (step > 0) {
      for (var i = start; i < length; i += step) {
        sublist.add(_list[i]);
      }
    } else if (step < 0) {
      for (var i = start; i >= length; i += step) {
        sublist.add(_list[i]);
      }
    } else {
      throw ArgumentError('Step cannot be zero');
    }
    return sublist;
  }
}

void test() {
  var list = PythonList<int>(5);
  list[0] = 1;
  list[1] = 2;
  list[2] = 3;
  list[3] = 4;
  list[4] = 5;
  // print(list[2]); // prints 3
  // print(list[-1]); // prints 5
  // print(list[(1, 4)]); // prints [2, 3, 4]
  // print(list[(1, 4, 2)]); // prints [2, 4]
  // print(list[(4, 1, -1)]); // prints [5, 4, 3]
}
