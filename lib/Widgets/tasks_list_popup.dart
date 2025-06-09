enum TasksListPopup{
  MarkAsdone(name:'Done|Undone'),
  Edit(name:'Edit'),
  Delete(name:'Delete');

  final String  name;
  const TasksListPopup({required this.name});
}
