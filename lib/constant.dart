import 'package:flutter/material.dart';

const kLightColor = Colors.white;
const kDarkBackgroundColor = Colors.black;
const kBackgroundColor = Color(0xFFF9F9F9);
const kAppColor = Color(0xFFF2B232);
const kLightAppColor = Color(0xFFFCEEBE);
const kAlternateAppColor = Color(0xFFF6B633);
const onboardfirstText =
    "طور لغتك الانجليزية من خلال الاجابة على الاختبارات بالفيديو";
const onboardSecondText =
    "احصل على شهادة معتمدة من خلال تحسين مستواك في الانجليزية";
const onboardThirdText =
    "لا يسمح بتغيير الاسم وتفاصيل التسجيل وسيتم استخدامه للشهادة";
const skipText = "تخطي";
const continueText = "استمرار";
const signinText = "تسجيل الدخول";
const signupText = "التسجيل";

const validationMsgEmail = "قم بتزويد بريد فعال";
const validationLevel = "المستوى مفقود";
const fieldRequired = "حقل مطلوب";
const emailText = "البريد الالكتروني";
const nameText = "الاسم الكامل";
const passwordText = "كلمة المرور";
const cpasswordText = "تاكيد كلمة المرور";
const passwordLength = "كلمة المرور يجب ان تكون اكثر او تساوي 6 ";
const loginText = "دخول";
const reisterText = "حساب جديد";
const forgotPasswordques = "نسيت كلمة المرور؟";
const donthaveanaccount = "ليس لديك حساب؟";
const createOne = "انشاء حساب";
const alreadyhaveanaccount = "لديك حساب بالفعل؟";
const loginhere = "الدخول هنا";
const forgotPassword = "نسيت كلمة المرور";
const submitText = "ارسال";
const forgotPasswordDesc = "يرجى استخدام البريد الالكتروني المستخدم في التسجيل";
const setupAccountInfo = "تعبئة بيانات الحساب";
const maleText = "ذكر";
const femaleText = "انثى";
const prefernottoDiscloseText = "Prefer not to disclose";
const countryText = "الدولة";
const dobText = 'تاريخ الميلاد';
const selectonetext = "اختر الجنس";
const selectlevel = "ما هو تقييمك لمستواك الحالي؟";

const borderWidget = BoxDecoration(
  color: kBackgroundColor,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(30.0),
    topRight: Radius.circular(30.0),
  ),
);
const fontSizeOnBoarding = 20.0;
const occupationText = "الوطيفة";
const pageHeaderFontSize = 25.0;
const zeroText = "صفر";
const beginnerText = "مبتدأ";
const intermediateText = "متوسط";
const advancedText = "متقدم";
const staticExamText = "Static Exam Text";
const paywithcard = "بطاقة الدفع";
const changePassword = "تغيير كلمة المرور";
const currentPassword = "كلمة المرور الحالية";
const confirmPassword = "تاكيد كلمة المرور";
const newPassword = "كلمة مرور جديدة";
const changePasswordDesc =
    "ادخل كلمة المرور القديمة ثم كلمة مرور جديدة من اختيارك ";
const homeFeedText = "الرئيسية";

const userProfile = "الملف الشخصي";
const faceTofaceTest = "اختبار بث مباشر";
const settings = "اعدادات";
const logout = "الخروج";
const drawerFontSize = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
const inactivecolor = Color(0xFFAFA9A9);
const settingsStyle = TextStyle(
  fontSize: 18,
);
const privacyPolicy = "سياسة الخصوصية";
const tandc = "الشروط والاحكام";
const requestInfo = "طلب معلومات";
const contactUs = "اتصل بنا";
const schedule = "جدولة";
const passwordDoNotMatch =
    "كلمة المرور غير متطابقة يرجى المحاولة مرة اخرى";
const accountCreationError =
    "خطأ اثناء انشاء الحساب، المستخدم او البريد الالكتروني موجود مسبقا";
const accountCreationSuccessful =
    "تم انشاء الحساب بنجاح، يرجى تاكيد البريد الالكتروني للدخول";
const emailNotVerified =
    "البريد الالكتروني غير مفعل، يرجى تفعيلة والدخول من جديد ";
const loginError =
    "خطأ اثناء الدخول، البريد او كلمة المرور خاطئة او المستخدم غير موجود او لم يتم تفعيل البريد الالكتروني";
const exceptionError = "حدث خطأ، يرجى المحاولة مرة اخرى";
const perpage = 10;
const nocontent = "لا يوجد محتوى";
const fieldnotempty = "الحقل لا يجب ان يكون فارغ";
const passwordnotmatchexistingpassword =
    "كلمة المرور لا تطابق الموجودة";
const passwordchanged = "تم تغيير كلمة المرور بنجاح";
const resetsent = "تم ارسال رابط اعادة التعيين";
const errorforgotpassword =
    "البريد غير فعال او غير موجود، يرجى التاكد";
const descempty = "الوصف لا يمكن ان يكون فارغ";
const submit = "ارسال";
const descedited = "تم تحديث الوصف";
const leaderBoard = "تصنيف الطلاب";
const pay = "دفع";
const paymentSuccessul =
    "تم التسديد بنجاح، سنقوم بالتواصل معك من خلال البريد الالكتروني او رقم الهاتف المرفق للبدأ";
const validPhone = "يرجى تزويدنا برقم جوال فعال";
const phone = "رقم الهاتف";
const learningPoints = "نقاط التقدم";
const correctAnswer = "اجابة صحيحة";
const wrongattemptTry = "اجابة خاطئة، حاول مجددا";
const wrongattemptAnswer = "اجابة خاطئة، الاجابة الصحيحة هي ";
const videoFeed="Video Feed";
const passedVideo="Passed Videos";
const reattemptVideos="Reattempt Videos";