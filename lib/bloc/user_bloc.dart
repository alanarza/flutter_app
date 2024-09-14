import 'package:bloc/bloc.dart';
import 'package:chat_app_2/models/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoginUser>(_onLogin);
    on<LogoutUser>(_onLogout);
  }

  void _onLogin(LoginUser event, Emitter<UserState> emit) async {
    emit(UserLoading());

    // Simulación de autenticación (puedes sustituir con una llamada a una API)
    await Future.delayed(Duration(seconds: 2));

    // Aquí podrías realizar la lógica de autenticación
    if (event.email == 'john.doe@example.com' && event.password == 'password123') {
      emit(UserAuthenticated(
        user: User(
          id: 1,
          token: 'token',
          username: 'John Doe',
          email: 'email'
          )
        )
      );
    } else {
      emit(UserUnauthenticated());
    }
  }

  void _onLogout(LogoutUser event, Emitter<UserState> emit) {
    emit(UserUnauthenticated());
  }
}
