import 'package:form_field_validator/form_field_validator.dart';

class Validator {
  static RequiredValidator required() => RequiredValidator(errorText: 'Il campo è obbligatorio');
}
