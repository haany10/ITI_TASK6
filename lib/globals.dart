
List<String> completedTasks = [];

void addComTask(String task) {
  if (!completedTasks.contains(task)) {
    completedTasks.add(task);
  }
}
