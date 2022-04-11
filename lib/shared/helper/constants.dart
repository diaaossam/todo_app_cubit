class ConstantsManger{


  //Colors

  static const String COLORS_RED = 'red';
  static const String COLORS_BLUE = 'blue';
  static const String COLORS_YELLOW = 'yellow';

  //Main Constant
  static const String ON_BOARDING = 'on_boarding';
  static const String USERS = 'users';
  static const String DEFULT = 'DEFULT';
  static const String TASKS = 'TASKS';
  static const String InProgress = 'In Progress';
  static const String DoneTask = 'Done';
  static const String Cancel = 'Cancel';
  static const String DEFULT_BIO = 'Hello I`m Using Task App Mangment .. !';

  //OnBoardingText
  static const String ON_BOARDINGTEXT1 = 'Welcome to the best Task manager baby !';
  static const String ON_BOARDINGTEXT2 = 'With this small app you can orgnize \n All Your Tasks and Duties in One \n Single App ';
  static const String ON_BOARDINGTEXT3 = 'Mangment everything with one hand';


  // Form Error
  static final RegExp emailValidatorRegExp =
  RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static const String kEmailNullError = "Please Enter your email";
  static const String kInvalidEmailError = "Please Enter Valid Email";
  static const String kPassNullError = "Please Enter your password";
  static const String kShortPassError = "Password is too short";
  static const String kMatchPassError = "Passwords don't match";
  static const String kNamelNullError = "Please Enter your name";
  static const String kPhoneNumberNullError = "Please Enter your phone number";
  static const String kAddressNullError = "Please Enter your address";


  //datebase
  static const String DATABASE_NAME = 'TaskManger.db';
  static const int DATABASE_VERSION = 1;
  static const String TABLE_NAME = 'tasks';
  static const String CREATE_QUERY = 'CREATE TABLE $TABLE_NAME (id INTEGER PRIMARY KEY, title TEXT,noteDesc TEXT ,noteDate TEXT,startTime TEXT,endtime TEXT ,remind TEXT,color TEXT)';
  static const String GET_ALL_TASKS = 'SELECT * FROM $TABLE_NAME';


}