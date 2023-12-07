import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:space_battles/infrasctructure/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  Future<void> signInUser(String email, String password) async {
    emit(state.copyWith(isLoading: true));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = FirebaseAuth.instance.currentUser!;
      DocumentSnapshot<Map<String, dynamic>> userData =
          await FirestoreService().getUserData('users', user.email!);

      if (!userData.exists) {
        await FirestoreService()
            .createUserData('users', user.email!, user.email!.split('@')[0]);
        userData = await FirestoreService().getUserData('users', user.email!);
      }

      emit(
        state.copyWith(
          isAuth: true,
          isLoading: false,
          email: user.email,
          username: userData.data()!['username'],
          score: userData.data()!['score'],
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          isAuth: false,
          isLoading: false,
          error: true,
          errorMessage: 'Something went wrong!: '
              '${e.toString()}',
        ),
      );
    }
  }

  Future<void> signUpUser(String email, String password) async {
    emit(state.copyWith(isLoading: true));

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirestoreService()
          .createUserData('users', email, email.split('@')[0]);
      final user = FirebaseAuth.instance.currentUser!;
      final userData = await FirestoreService().getUserData('users', email);

      emit(
        state.copyWith(
          isAuth: true,
          isLoading: false,
          isCreatingAccount: false,
          email: user.email,
          username: userData.data()!['username'],
          score: userData.data()!['score'],
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          isAuth: false,
          isLoading: false,
          error: true,
          errorMessage: e.code,
        ),
      );
    }
  }

  Future<void> updateUserData(String email, String field, dynamic data) async {
    emit(state.copyWith(
      isLoading: true,
    ));

    try {
      await FirestoreService().updateUserData('users', email, field, data);
      final userData = await FirestoreService().getUserData('users', email);

      emit(state.copyWith(
        isLoading: false,
        username: userData.data()!['username'],
        score: userData.data()!['score'],
      ));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: true,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> signOutUser() async {
    await FirebaseAuth.instance.signOut();
    await FirestoreService().clear();
    emit(const AuthState());
  }

  Future<void> isCreatingAccount() async {
    emit(
      state.copyWith(
        isCreatingAccount: true,
        error: false,
        errorMessage: '',
      ),
    );
  }

  void reset() {
    emit(const AuthState());
  }
}
