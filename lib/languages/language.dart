import 'package:get/get.dart';

class Language extends Translations {

  @override
  Map<String, Map<String, String>> get keys => {
    'pt_BR':{
      'home': 'Início',
      'welcome':'Bem vindo!',
      'user':'Usuário',
      'pl_user':'Usuários',
      'name':'Nome',
      'loggedIn': 'Acesso em',
      'back':'Voltar',
      //Password
      'password': 'Senha',
      'password_not_valid':'Senha incorreta',
      'password_required': 'O campo senha é obrigatório',
      //Email
      'email_required': 'O campo "E-mail" é obrigatório',
      'email_not_valid': 'E-mail digitado não é válido',
      'email_not_registered':'Usuário com o e-mail: @email não cadastrado'
    },

    'en_US':{
      'home': 'Home',
      'welcome':'Welcome!',
      'user':'User',
      'pl_user':'Users',
      'name':'Name',
      'loggedIn': 'Logged in',
      'back': 'Back',
      //Password
      'password': 'Password',
      'password_not_valid':'Incorrect password',
      'password_required': 'Password is required',
      //Email
      'email_required': 'E-mail is required',
      'email_not_valid': 'Email entered is not valid',
      'email_not_registered':'User with email @email not registered'
    },
  };
  
}
