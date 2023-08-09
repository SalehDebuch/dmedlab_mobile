import 'package:flutter/material.dart';
import '../../global/colors.dart';
import '../../theme.dart';

class TermsAndConditionsPage extends StatelessWidget {
  static String routeName = '/terms&conditions';
  final String arabicTermsAndConditions = '''
DMedLab v1.0
 التاريخ: 27/07/2023 
توضح سياسة الخصوصية هذه كيفية جمع ديمدلاب واستخدامها ومشاركة المعلومات الشخصية عند استخدامك لتطبيقنا الجوال. من خلال تحميل التطبيق أو تثبيته أو استخدامه، فإنك توافق على الممارسات الموضحة في سياسة الخصوصية هذه.
1.	استخدام المحتوى:
 يحتوي تطبيق ديمدلاب على مواد محمية بحقوق التأليف والنشر تملكها حصريًا ديمدلاب وتحمى بموجب قوانين حقوق التأليف والنشر. يتم منح المستخدمين الحق في استخدام المحتوى للأغراض الشخصية غير التجارية فقط. يُحظر بشدة أي استخدام غير مصرح به، بما في ذلك التعديل أو الاستنساخ أو التوزيع أو الاستغلال، وقد يؤدي ذلك إلى عواقب مدنية وجنائية بموجب قوانين حقوق التأليف والعلامات التجارية. تحمي معلومات ديمدلاب التطبيق بموجب قوانين الملكية الفكرية الدولية وهو مسجل كعلامة تجارية وملكية فكرية في وزارة الاقتصاد في دولة الإمارات العربية المتحدة، برقم شهادة التسجيل (2023-368).
2.	دقة البيانات وإخلاء المسؤولية عن الاستخدام:
 أ. القيم المرجعية وبيانات المختبر: يوفر ديمدلاب معلومات مرجعية طبية لأغراض إعلامية عامة. يجب على المستخدمين أن يكونوا حذرين حيث قد لا تكون القيم المرجعية مؤشرًا مطلقًا للصحة أو المرض، وقد تختلف القيم بين مؤسسات مختلفة. ب. استخدام بحذر: التطبيق لا يقدم النصيحة الطبية، ويجب على المستخدمين طلب النصيحة من متخصصي الرعاية الصحية المؤهلين للحصول على تشخيصات دقيقة وقرارات علاجية. ج. تحديثات وتحسينات البيانات: يمكن أن تتغير المعلومات داخل التطبيق، بما في ذلك بيانات المرجع الطبي، دون إشعار. يجب على المستخدمين التشاور مع متخصصي الرعاية الصحية المؤهلين للحصول على أحدث وأكثر المعلومات الطبية موثوقية. د. المواقع الخارجية: قد يتضمن التطبيق روابط إلى مواقع خارجية، تقدم لراحة المستخدم. لا تؤيد ديمدلاب هذه المواقع أو تتحمل المسؤولية عن محتواها، ويتم الوصول إليها على مسؤولية المستخدم.
3.	المعلومات المجمعة:
أ‌.	المعلومات الشخصية: عند التسجيل وإنشاء حسابك مع ديمدلاب، قد نجمع ونعالج المعلومات الشخصية التالية:
الاسم الكامل
رقم الجوال 
عنوان البريد الإلكتروني
ب. المعلومات غير الشخصية: قد نجمع أيضًا معلومات غير شخصية مثل معلومات الجهاز وعنوان IP وبيانات الاستخدام والتحليلات المجهولة لتحسين أداء التطبيق وتجربة المستخدم.
4.	كيفية استخدام معلوماتك:
 أ. إنشاء الحساب والمصادقة: نستخدم معلوماتك الشخصية لإنشاء وإدارة حساب ديمدلاب وللتحقق من هويتك للوصول الآمن إلى ميزات التطبيق. ب. التواصل: قد نستخدم عنوان بريدك الإلكتروني ورقم هاتفك المحمول لإرسال إشعارات هامة وتحديثات ورسائل دعم لك. ج. التحسين والتحليلات: يتم استخدام المعلومات غير الشخصية لتحليل سلوك المستخدم والمشاركة مع التطبيق، مما يسمح لنا بإجراء تحسينات مستمرة على الخدمة.
5.	أمان البيانات:
نحن نأخذ أمان البيانات على محمل الجد ونقوم بتنفيذ التدابير المناسبة لحماية معلوماتك الشخصية من الوصول غير المصرح به أو الكشف عنه أو التعديل عليها. ومع ذلك، يرجى العلم بأن أي طريقة لنقل المعلومات عبر الإنترنت أو التخزين الإلكتروني ليست آمنة تمامًا، ولا يمكننا ضمان الأمان التام.
6.	خصوصية الأطفال:
 لايهدف ديمدلاب لاستخدامه من قبل أفراد دون سن 16 عامًا. نحن لا نقوم عن عمد بجمع المعلومات الشخصية من الأطفال. إذا كنت ولي أمر أو وصي وتعتقد أن طفلك قد قدم لنا معلومات شخصية، فيرجى التواصل معنا وسنتخذ خطوات لإزالة مثل هذه المعلومات من نظامنا.
7.	خياراتك:
 يمكنك الوصول إلى معلوماتك الشخصية وتحديثها أو حذفها ضمن إعدادات التطبيق. إذا كنت ترغب في حذف حسابك بالكامل، فيرجى التواصل معنا على support@dmedlab.com.
8.	نقل البيانات:
 إذا قمت بالوصول إلى ديمدلاب من خارج دولة الإمارات العربية المتحدة، فيرجى التواعد بأن معلوماتك قد يتم نقلها وتخزينها على خوادم موجودة في بلدان أخرى. باستخدام التطبيق، فإنك توافق على مثل هذه النقلات.
9.	تغييرات على سياسة الخصوصية:
 قد نقوم بتحديث سياسة الخصوصية هذه من وقت لآخر. ستكون أي تغييرات نافذة عند نشرها داخل التطبيق. استمرارك في استخدام ديمدلاب بعد تفعيل سياسة الخصوصية المعدلة يعني موافقتك على الشروط المحدثة.
10.	اتصل بنا:
 إذا كان لديك أي أسئلة أو استفسارات أو طلبات بشأن سياسة الخصوصية هذه أو معلوماتك الشخصية، فيرجى التواصل معنا على support@dmedlab.com.
  ''';

  final String englishTermsAndConditions = """
DMedLab v1.0
Date: 27/07/2023
This Privacy Policy describes how Dmedlab collects, uses, and shares personal information when you use our mobile application.
By downloading, installing, or using the App, you agree to the practices described in this Privacy Policy.

1.	Use of Content:
Dmedlab app contains copyrighted materials exclusively owned by Dmedlab  and is protected by copyright laws. Users are granted the right to use the content for personal, non-commercial purposes only. Any unauthorized use, including modification, reproduction, distribution, or exploitation, is strictly prohibited and may lead to civil and criminal penalties under copyright and trademark laws.
Data in Dmedlab app is protected by international intellectual property laws and is registered as a trademark and intellectual property under the Ministry of Economy in the United Arab Emirates, with registration certificate number (2023-368).

2.	Data Accuracy and Usage Disclaimer:
a. Reference Values and Laboratory Data: Dmedlab provides medical lab reference information for general informational purposes. Users should be cautious as reference values may not be absolute indicators of health or disease, and values can vary between different institutions.
b. Use with Care: The app does not provide medical advice, and users should seek advice from qualified healthcare professionals for accurate diagnoses and treatment decisions.
c. Data Updates and Improvements: Information within the app, including medical lab reference data, may change or update without notice. Users should consult qualified healthcare professionals for the most current and reliable medical information.
d. External Sites: The app may include links to External Sites, provided for user convenience. Dmedlab  does not endorse or take responsibility for the content of these sites, and users access them at their own risk.

3.	Collected Information:
a. Personal Information: When you sign up and create an account with Dmedlab, we may collect and process the following personal information:
• Full name
• Mobile number
• Email address

b. Non-Personal Information: We may also collect non-personal information such as device information, IP address, usage data, and anonymous analytics to improve the App's performance and user experience.

4.	How We Use Your Information:
a. Account Creation and Authentication: We use your personal information to create and manage your DMedLab account and to authenticate your identity for secure access to the App's features.
b. Communication: We may use your email address and mobile number to send you important notifications, updates, and support-related messages.
c. Improvement and Analytics: Non-personal information is used to analyze user behavior and engagement with the App, allowing us to make continuous improvements to the service.

5.	Data Security:
We take data security seriously and implement appropriate measures to safeguard your personal information from unauthorized access, disclosure, or alteration. However, please be aware that no method of transmission over the internet or electronic storage is entirely secure, and we cannot guarantee absolute security.

6.	Children's Privacy:
DMedLab is not intended for use by individuals under the age of 16. We do not knowingly collect personal information from children. If you are a parent or guardian and believe that your child has provided us with personal information, please contact us, and we will take steps to remove such information from our systems.

7.	Your Choices:
You can access, update, or delete your personal information within the App's settings. If you wish to delete your account entirely, please contact us at support@dmedlab.com.

8.	Data Transfers:
If you access DMedLab from outside the United Arab Emirates, please be aware that your information may be transferred to and stored in servers located in other countries. By using the App, you consent to such transfers.

9.	Changes to Privacy Policy:
We may update this Privacy Policy from time to time. Any changes will be effective when posted within the App. Your continued use of Dmedlab  after the revised Privacy Policy is in effect signifies your acceptance of the updated terms.

10.	Contact Us:
If you have any questions, concerns, or requests regarding this Privacy Policy or your personal information, please contact us at support@dmedlab.com.
""";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'حول التطبيق ',
          style: textTheme().displayLarge,
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'سياسة الخصوصية:',
                style: textTheme().displaySmall!.copyWith(color: Colors.black),
              ),
              Text(
                arabicTermsAndConditions,
                style: textTheme().bodyMedium!.copyWith(color: TEXT_COLOR),
              ),
              Text(
                'privacy policy:',
                textAlign: TextAlign.left,
                textDirection: TextDirection.ltr,
                style: textTheme().displaySmall!.copyWith(color: Colors.black),
              ),
              SizedBox(height: 16.0),
              Text(
                englishTermsAndConditions,
                textAlign: TextAlign.left,
                textDirection: TextDirection.ltr,
                style: textTheme().bodyMedium!.copyWith(color: TEXT_COLOR),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
