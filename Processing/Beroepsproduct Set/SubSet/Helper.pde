boolean contains(String[] arr, String item) {
  for (String n : arr) {
     if (item == n) {
        return true;
     }
  }
  return false;
 }