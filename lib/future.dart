void main() async {
  String? app;
  // print('test');
  app ??= "hhh";
  print(app);
  Employee? emp;
  if (emp != null) emp.showData();

  emp?.showData();
}

class Employee {
  void showData() {
    print("Hello Flutter");
  }
}

Future<String> loginUser() async {
  var user = await getUserFromDatabase();
  return "user : " + user;
}

Future<String> getUserFromDatabase() {
  return Future.delayed(Duration(seconds: 10), () => "Flutter");
}
