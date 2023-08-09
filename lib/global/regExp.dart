final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

const String kEmailNullError =
    "يرجى ادخال بريدك الالكتروني"; //Please Enter your email
const String kInvalidEmailError =
    "يرجى ادخال بريد الكتروني صالح"; //Please Enter Valid Email
const String kPassNullError =
    "يرجى ادخال كلمة السر"; //Please Enter your password
const String kShortPassError = "كلمة السر قصيرة "; //Password is too short
const String kMatchPassError = "كلمة السر غير متطابقة"; //Passwords don't match
const String kPassConformError =
    "يرجى تأكيد كلمة السر   "; //Passwords don't match

const String kNamelNullError = "يرجى ادخال الاسم"; //Please Enter your name
const String kMobileNumberNullError =
    " أدخل كلمة السر  "; //Passwords don't match
const String kNameNullError = "يرجى ادخال اسم  المستخدم";

const String kUserNameNullError = "يرجى ادخال حسابك الاكتروني";
//const String kPhoneNumberNullError = "يرجى ادخال رقم الموبايل"; //Please Enter your phone number
//const String kAddressNullError = "";//Please Enter your address
String searchValidateRegExp(input) => input
    .replaceAll(RegExp(r'[$&+,:;=?@#|\<>.()/^*%!-]'), ' ')
    .replaceAll(RegExp(r'[أإآ]'), 'ا')
    .replaceAll(RegExp(r'[ىئ]'), 'ى')
    .replaceAll(RegExp(r'[هة]'), 'ه')
    .replaceAll(RegExp(r'[\u064B-\u0652]'), '')
    .replaceAll(RegExp(r' +'), ' ')
    .toLowerCase()
    .split('   ')
    .join('   ');
