const taskTable = 'tasks';

const String taskColumnId = 'id';
const String taskColumnTitle = 'title';
const String taskColumnDescription = 'description';
const String taskColumnIsActive = 'isActive';
const String taskColumnCreatedAt = 'createdAt';

const int isActiveFalse = 0;
const int isActiveTrue = 1;

const String createTaskTableQuery = '''
  CREATE TABLE $taskTable (
    $taskColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
    $taskColumnTitle TEXT,
    $taskColumnDescription TEXT,
    $taskColumnIsActive INTEGER NOT NULL DEFAULT $isActiveFalse,
    $taskColumnCreatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
  )
''';
