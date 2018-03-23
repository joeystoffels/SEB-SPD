// Enkele helper functies voor het uitvoeren van bewerkingen op of met arrays.

boolean contains(String[] arr, String item) {
  for (String n : arr) {
    if (item == n) {
      return true;
    }
  }
  return false;
}

String[] removeFromArray(String[] arrayOud, int index) {
  String arrayNieuw[] = new String[arrayOud.length - 1];
  arrayCopy(arrayOud, 0, arrayNieuw, 0, index);
  arrayCopy(arrayOud, index + 1, arrayNieuw, index, arrayOud.length - (index + 1));
  return arrayNieuw;
}

String[][] append2DArray(String[][] arrayOud, String[] item) {
  String arrayNieuw[][] = new String[arrayOud.length + 1][];
  arrayNieuw[arrayOud.length] = item;
  return arrayNieuw;
}

boolean arrayContains(String[] array, String item) {
  for (String arrayItem : array) {
    if (arrayItem.equals(item)) {
      return true;
    }
  }
  return false;
}

int arrayIndexOf(String[] array, String item) {
  for (int x = 0; x < array.length; x++) {
    if (array[x].equals(item)) {
      return x;
    }
  }
  return -1;
}

int array2DIndexOf(String[][] array, String[] item) {
  for (int x = 0; x < array.length; x++) {
    if (array[x].equals(item)) {
      return x;
    }
  }
  return -1;
}