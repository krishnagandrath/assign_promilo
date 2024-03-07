import 'package:assign_promilo/services/login_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('API Testing Group', ()  {
    final future = LoginService().checkLogin('test45@yopmail.com', 'Test@123');
    expectLater(future, completes).then((value) {
      expect(future, equals(true));
    });
  });
}
