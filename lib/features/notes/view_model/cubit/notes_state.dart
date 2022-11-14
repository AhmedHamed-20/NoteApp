// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notes_cubit.dart';

class NoteState extends Equatable {
  final List<NotesModel> notes;
  final DeleteNotesByIdRequestStatus notesDeleteStatus;
  final GetNotesRequestStatus notesStatus;
  final AddNotesRequestStatus notesAddStatus;
  final UpdateNotesRequestStatus notesUpdateStatus;
  final int activeColorIndex;
  final String errorMessage;
  final ThemeModeValue themeModeValue;
  const NoteState(
      {this.notes = const [],
      this.errorMessage = '',
      this.themeModeValue = ThemeModeValue.light,
      this.activeColorIndex = 0,
      this.notesUpdateStatus = UpdateNotesRequestStatus.loading,
      this.notesAddStatus = AddNotesRequestStatus.loading,
      this.notesDeleteStatus = DeleteNotesByIdRequestStatus.loading,
      this.notesStatus = GetNotesRequestStatus.loading});

  NoteState copyWith({
    ThemeModeValue? themeModeValue,
    int? activeColorIndex,
    String? errorMessage,
    List<NotesModel>? notes,
    AddNotesRequestStatus? notesAddStatus,
    DeleteNotesByIdRequestStatus? notesDeleteStatus,
    GetNotesRequestStatus? notesStatus,
    UpdateNotesRequestStatus? notesUpdateStatus,
  }) {
    return NoteState(
      themeModeValue: themeModeValue ?? this.themeModeValue,
      activeColorIndex: activeColorIndex ?? this.activeColorIndex,
      errorMessage: errorMessage ?? this.errorMessage,
      notesUpdateStatus: notesUpdateStatus ?? this.notesUpdateStatus,
      notesAddStatus: notesAddStatus ?? this.notesAddStatus,
      notesDeleteStatus: notesDeleteStatus ?? this.notesDeleteStatus,
      notesStatus: notesStatus ?? this.notesStatus,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [
        errorMessage,
        notes,
        notesStatus,
        themeModeValue,
        notesDeleteStatus,
        notesAddStatus,
        activeColorIndex,
        notesUpdateStatus
      ];
}
