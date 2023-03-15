class AppStrings {
  static const String skipSignIn = 'skipSignIn';
  static const String isDarkThemeModeKey = 'isDark';
  static const String collectionUsers = 'users';
  static const String collectionNotes = 'notes';
  static const String notes = 'Notes';
  static const String tableName = 'notes';
  static const String insertIntoDataBaseQuery =
      'INSERT INTO notes(title, body, color,date, myId) VALUES(?, ?, ?, ?, ?)';

  static const String updateDataBaseQuer =
      'UPDATE $tableName SET  title= ?, body = ? ,color= ? WHERE dataBaseId = ?';
  static const String createDataBaseQuery =
      'CREATE TABLE notes (dataBaseId INTEGER PRIMARY KEY, title TEXT, body TEXT, color TEXT,date TEXT, myId INTEGER)';
  static const String switchAccount = 'Switch Account';

  static const String areYouSureYouWantToSwitchAccount =
      'Are you sure you want to switch account?';

  static const String no = 'No';
  static const String yes = 'Yes';
  static const String syncNotes = 'Sync Notes';
  static const String syncNotesMessage = 'Are you sure you want to sync notes?';
  static const String cancel = 'Cancel';
  static const String syncData = 'Sync';
  static const String signInAndSaveNotes =
      'Sign in to save your notes and sync them across all your devices';
  static const String skipAndContinueOnOffline =
      'Skip and continue on offline mode';

  static const String addNote = 'Add Note';
  static const String savedSuccessfully = 'Saved Successfully';
  static const String saveEdit = 'Save Edit';
  static const String add = 'Add';
  static const String save = 'Save';
  static const String title = 'Title';
  static const String typeSomething = 'Type something...';
  static const String noNotesToshow = 'No Notes to show';
}
