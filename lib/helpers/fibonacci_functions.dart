class FibonacciLists {
  //Generate Fibonacci with bounds.
  int row = 3;
  int col = 4;

  List<int> generateWithBounds(int first, int limit, int originalLimit) {
    List<int> localList = [];
    int originalFirst = first;

    int n1 = fib(first);
    int n2 = fib(first + 1);
    if (originalFirst == originalLimit) {
      //si es el mismo número solo retrornar una sin entrar al bucle
      return localList;
    } else if (originalFirst + 1 == originalLimit) {
      //si son 2, retornar 2
      //sino retornar solo uno
      localList.add(n1);
      return localList;
    }

    //2 first numbers
    localList.add(n1);
    localList.add(n2);
    int n3;

    //2 minus that te real limit because I already added the 2 first numbers.
    for (int i = 0; i < limit - 2; i++) {
      n3 = n1 + n2;
      localList.add(n3);
      n1 = n2;
      n2 = n3;
    }

    return localList.take(9).toList();
  }

  List<int> rotateRight(List<int> numbers) {
    List<int> listFixed = [];
    for (var element in numbers) {
      listFixed.add(element);
    }
    listFixed[0] = numbers[6];
    listFixed[1] = numbers[3];
    listFixed[2] = numbers[0];
    listFixed[3] = numbers[7];
    listFixed[4] = numbers[4];
    listFixed[5] = numbers[1];
    listFixed[6] = numbers[8];
    listFixed[7] = numbers[5];
    listFixed[8] = numbers[2];
    return listFixed;
  }

  int totalList(List<int> list) {
    int total = 0;
    for (var element in list) {
      total = total + element;
    }
    return total;
  }

  int fib(int n) {
    if (n < 2) {
      //base case
      return n;
    }
    return fib(n - 2) + fib(n - 1); //recursive case
  }
}
