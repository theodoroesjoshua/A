import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sugoi/models/customer.dart';

class CustomerCubit extends Cubit<Customer?> {
  CustomerCubit(Customer? state) : super(state);

  void login(Customer? customer) => emit(customer);
  void logout() => emit(null);
}
