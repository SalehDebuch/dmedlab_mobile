import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../services/general_services/size_config.dart';
import 'colors.dart';

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(50.0),
    borderSide: const BorderSide(color: kPrimaryColr, width: 5),
  );
}

////////
const String MainServerUrl = "https://labedia.doctordobosh.com/api/";
// const String MainServerUrl = "https://doctorDobosh.com/api/";
// const String filesURL = "https://doctordobosh.com/lab_test/";
// const String filesPrefix = ".pdf";
//const String TestServerUrl = "https://test.doctordobosh.net/api/";
final storedToken = storage.read(key: 'token');
// final Map<String, String> headers = {
//   "Authorization": "Bearer $storedToken",
//   "Content-Type": "application/json"
// };

const Map<String, String> headers = {"Content-Type": "application/json"};

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

final storage = FlutterSecureStorage();
const KEmptField = 'ادخل البيانات المطلوبة';
const EmailOrPasswordNotCorrect = 'كلمة المرور أو الحساب غير صحيح';
const HomeIconeText = 'الرئيسية';
const FavoriteIconeText = 'المفضلة';
const BookmarksIconeText = 'علامة مرجعية';
const ProfileIconeText = 'الحساب ';
const SearchIconeText = 'البحث';
const EmptyFavoriteTest = "لايوجد تحاليل مفضلة";
const kInternetConnectionErrorr = "لايوجد اتصال بالانترنت";
const SessionExperiedAlert = "انتهت الجلسة يرجى اعادة تسجيل الدخول";
const UpdateUserProfileSuccess = 'تم تحديث البيانات بنجاح';
const GeneralErrorMassege = 'حدث خطأ ما';
const SearchTextFieldHint = " البحث عن التحليل بكافة التسميات واللغات المذكورة";
const PaymentPromotionDialog =
    'احصل على فرصة للوصول إلى جميع محتويات الموسوعة المخبرية السريرية، واجعل خبرتك الطبية أفضل من خلال ترقية حسابك ';
const invalidActivationKey = "رمز التفعيل غير صالح";
const ExitWillpopContent = '  الخروج من التطبيق ';
const ExitWillpopTitle = 'هل أنت متأكد ';

const ExitDialogTitle = 'تسجيل الخروج  ';
const ExitDialogContent = ' هل تريد تسجيل الخروج من حسابك الحالي؟  ';
const ActivationSuccess = 'تم تفعيل الحساب بنجاح';
const No = 'لا';
const Yes = 'نعم';
const Error = 'خطأ';
const Success = 'نجاح';
///////////////////////////
// Define variables for the texts
const String appNameArabic = 'الموسوعة المخبرية السريرية العربية ';
//const String appNameEnglish = 'Arabic Clinical Laboratory Encyclopedia';

const String appVersion = 'الإصدار 1.0.0';
const String appDescription =
    "نهدف من خلال الموسوعة المخبرية السريرية العربية  لتقديم خلاصة العمل المخبري والتشخيص الطبي بالاعتماد على الخبرات العملية وأحدث القيم من المراجع الموثوقة العالمية";
const String appDeveloperDescription =
    'تم تطوير التطبيق  من قبل شركة proitx لتطوير البرمجيات وباشراف الأطباء المختصين في العمل المخبري  \nمن أعمال المطور برنامج Smart lab لإدارة وأتمتة المختبرات الطبية ';
const String contactTitle = 'اتصل بنا';
const String contactEmail = 'info@dmedlab.com';
const String supportEmail = 'support@dmedlab.com';
const String contactPhone = " 545068089 971+";
const String appauthorDescription1 =
    "د. محمد خليل الدبش ماجستير في الطب المخبري - أستاذ محاضر و خبرة 40 عام في العمل المخبري ";
const String appauthorDescription2 =
    "د. إياد عمر تنبكجي ماجستير في الطب المخبري - أستاذ محاضر و خبرة 40 عام في العمل المخبري";
const String appauthorDescription3 =
    "	من أعمال المؤلفين سلسلة بسائط للممارسين في المختبر الطبي العام: \n (الطفيليات – الجرثوميات – البول – الكيمياء السريرية – أساسيات العمل المخبري)";
