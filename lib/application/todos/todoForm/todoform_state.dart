part of 'todoform_bloc.dart';

class TodoformState {
  final Todo todo;
  final bool showErrorMessage;
  final bool isSaving;
  final bool isEditing;

  final Option<Either<TodoFailure, Unit>> failureOrSuccessOption;

  TodoformState(
      {required this.todo,
      required this.showErrorMessage,
      required this.isSaving,
      required this.isEditing,
      required this.failureOrSuccessOption});

  factory TodoformState.initial() => TodoformState(
      todo: Todo.empty(),
      showErrorMessage: false,
      isSaving: false,
      isEditing: false,
      failureOrSuccessOption: none());

  TodoformState copyWith(
      {Todo? todo,
      bool? showErrorMessage,
      bool? isSaving,
      bool? isEditing,
      Option<Either<TodoFailure, Unit>>? failureOrSuccessOption}) {
    return TodoformState(
        todo: todo ?? this.todo,
        showErrorMessage: showErrorMessage ?? this.showErrorMessage,
        isSaving: isSaving ?? this.isSaving,
        isEditing: isEditing ?? this.isEditing,
        failureOrSuccessOption:
            failureOrSuccessOption ?? this.failureOrSuccessOption);
  }
}
