
import 'package:get/get.dart';

class AppTranslation extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'en_US': Locales.en_US,
    'fa_IR': Locales.fa_IR,
  };
}

class LocaleKeys {
  LocaleKeys._();
  static const firstName = 'firstName';
  static const lastName = 'lastName';
  static const repeatPassword = 'repeatPassword';
  static const seller = 'seller';
  static const customer = 'customer';
  static const login = 'login';
  static const password = 'password';
  static const signup = 'signup';
  static const userName = 'userName';
  static const admin = 'admin';
  static const emptyList = 'emptyList';
  static const price = 'price';
  static const active = 'active';
  static const productList = 'productList';
  static const thisIsRequired = 'thisIsRequired';
  static const thisIsWrong = 'thisIsWrong';
  static const addProduct = 'addProduct';
  static const color = 'color';
  static const tittle = 'tittle';
  static const description = 'description';
  static const count = 'count';
  static const selectAColor = 'selectAColor';
  static const ok = 'ok';
  static const submit = 'Submit';
  static const editProduct = 'editProduct';
  static const edit = 'edit';
  static const selectProduct = 'selectProduct';
  static const addToCart = 'addToCart';
  static const shoppingCart = 'shoppingCart';
  static const totalPrice = 'totalPrice';
  static const payment = 'payment';
  static const error = 'error';
  static const usernameOrPasswordIncorrect = 'usernameOrPasswordIncorrect';
  static const imageIsNotSelect = 'imageIsNotSelect';
  static const thisProductIsExist = 'thisProductIsExist';
  static const filter = 'filter';
  static const thisUsernameIsExist = 'thisUsernameIsExist';
  static const retry = 'retry';
  static const rememberMe = 'rememberMe';
  static const errorPassword = 'errorPassword';
}

class Locales {
  static const en_US = {
    'firstName': 'First Name',
    'lastName': 'Last Name',
    'repeatPassword': 'repeat Password',
    'seller': 'Seller',
    'customer': 'Customer',
    'login': 'Login',
    'password': 'Password',
    'signup': 'Sign up',
    'userName': 'User Name',
    'admin': 'Admin',
    'emptyList': 'List is empty',
    'price': 'Price',
    'active': 'Active',
    'submit': 'Submit',
    'productList': 'Product List',
    'thisIsRequired': 'this is required',
    'thisIsWrong': 'this is wrong',
    'addProduct': 'Add Product',
    'color': 'Color',
    'tittle': 'Tittle',
    'description': 'Description',
    'count': 'Count',
    'selectAColor': 'Select a color',
    'ok': 'Ok',
    'editProduct': 'Edit Product',
    'edit': 'Edit',
    'selectProduct': 'Select Product',
    'addToCart': 'Add To Cart',
    'shoppingCart': 'Shopping Cart',
    'totalPrice': 'Total Price',
    'payment': 'Payment',
    'error': 'Error',
    'usernameOrPasswordIncorrect': 'Username or Password is incorrect',
    'imageIsNotSelect': 'Image is not select',
    'thisProductIsExist': 'This product is exist',
    'filter': 'Filter',
    'thisUsernameIsExist': 'This username is exist',
    'retry': 'Retry',
    'rememberMe': 'Remember Me',
    'errorPassword': 'The length of the password must be at least 5 characters',
  };
  static const fa_IR = {
    'firstName': 'نام',
    'lastName': 'نام خانوادگی',
    'repeatPassword': 'تکرار پسورد',
    'seller': 'فروشنده',
    'customer': 'مشتری',
    'login': 'ورود',
    'password': 'رمز عبور',
    'signup': 'ثبت نام',
    'userName': 'نام کاربری',
    'admin': 'مدیر فروشگاه',
    'emptyList': 'لیست خالی است',
    'price': 'قیمت',
    'active': 'فعال',
    'submit': 'ثبت',
    'productList': 'لیست محصولات',
    'thisIsRequired': 'این فیلد ضروری است',
    'thisIsWrong': 'عدم تطابق',
    'addProduct': 'اضافه کردن محصول',
    'color': 'رنگ',
    'tittle': 'عنوان',
    'description': 'توضیحات',
    'count': 'تعداد',
    'selectAColor': 'انتخاب رنگ',
    'ok': 'تایید',
    'editProduct': 'ویرایش محصولات',
    'edit': 'ویرایش',
    'selectProduct': 'انتخاب محصول',
    'addToCart': 'اضافه کردن به سبد خرید',
    'shoppingCart': 'سبد خرید',
    'totalPrice': 'مجموع خرید',
    'payment': 'پرداخت',
    'error': 'خطا',
    'usernameOrPasswordIncorrect': 'نام کاربری یا کلمه عبور اشتباه است',
    'imageIsNotSelect': 'عکس انتخاب نشد',
    'thisProductIsExist': 'این محصول قبلا ثبت شده',
    'filter': 'فیلتر',
    'thisUsernameIsExist': 'این نام کاربری قبلا ثبت شده',
    'retry': 'تلاش مجدد',
    'rememberMe': 'مرا به خاطر بسپار',
    'errorPassword': 'طول پسورد باید حداقل 5 کاراکتر باشد',
  };
}
