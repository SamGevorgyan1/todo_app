enum TaskFilter {
  all('All'),
  active('Active'),
  completed('Completed');

  final String name;

  const TaskFilter(this.name);
}
