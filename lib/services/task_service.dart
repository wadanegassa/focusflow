import 'package:flutter/foundation.dart';
import '../models/task.dart';

class TaskService extends ChangeNotifier {
  final List<Task> _tasks = [];
  TaskStatus _filterStatus = TaskStatus.pending;
  String _searchQuery = '';

  List<Task> get tasks => _tasks;
  TaskStatus get filterStatus => _filterStatus;
  String get searchQuery => _searchQuery;

  List<Task> get filteredTasks {
    List<Task> filtered = _tasks;

    // Filter by status
    if (_filterStatus != TaskStatus.pending) {
      filtered = filtered.where((task) => task.status == _filterStatus).toList();
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((task) =>
          task.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          task.description.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          task.category.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }

    // Sort by priority and due date
    filtered.sort((a, b) {
      // First sort by priority (urgent first)
      int priorityComparison = b.priority.value.compareTo(a.priority.value);
      if (priorityComparison != 0) return priorityComparison;

      // Then sort by due date (earliest first)
      if (a.dueDate != null && b.dueDate != null) {
        return a.dueDate!.compareTo(b.dueDate!);
      } else if (a.dueDate != null) {
        return -1;
      } else if (b.dueDate != null) {
        return 1;
      }

      // Finally sort by creation date (newest first)
      return b.createdAt.compareTo(a.createdAt);
    });

    return filtered;
  }

  List<Task> get pendingTasks => _tasks.where((task) => task.status == TaskStatus.pending).toList();
  List<Task> get inProgressTasks => _tasks.where((task) => task.status == TaskStatus.inProgress).toList();
  List<Task> get completedTasks => _tasks.where((task) => task.status == TaskStatus.completed).toList();

  int get totalTasks => _tasks.length;
  int get completedTasksCount => completedTasks.length;
  int get pendingTasksCount => pendingTasks.length;
  int get inProgressTasksCount => inProgressTasks.length;

  double get completionPercentage {
    if (_tasks.isEmpty) return 0.0;
    return completedTasksCount / _tasks.length;
  }

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task updatedTask) {
    final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  void deleteTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }

  void toggleTaskStatus(String taskId) {
    final index = _tasks.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      final task = _tasks[index];
      TaskStatus newStatus;
      switch (task.status) {
        case TaskStatus.pending:
          newStatus = TaskStatus.inProgress;
          break;
        case TaskStatus.inProgress:
          newStatus = TaskStatus.completed;
          break;
        case TaskStatus.completed:
          newStatus = TaskStatus.pending;
          break;
        case TaskStatus.cancelled:
          newStatus = TaskStatus.pending;
          break;
      }
      _tasks[index] = task.copyWith(status: newStatus);
      notifyListeners();
    }
  }

  void setFilterStatus(TaskStatus status) {
    _filterStatus = status;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }

  // Initialize with sample data
  void initializeSampleData() {
    if (_tasks.isEmpty) {
      final now = DateTime.now();
      _tasks.addAll([
        Task(
          id: '1',
          title: 'Design new logo',
          description: 'Create a modern and minimalist logo for the company brand identity',
          category: 'Personal',
          createdAt: now.subtract(const Duration(days: 2)),
          dueDate: now.add(const Duration(days: 3)),
          priority: TaskPriority.high,
          status: TaskStatus.pending,
          tags: ['design', 'branding'],
        ),
        Task(
          id: '2',
          title: 'Review project proposal',
          description: 'Review and provide feedback on the Q1 project proposal document',
          category: 'Work',
          createdAt: now.subtract(const Duration(days: 1)),
          dueDate: now.add(const Duration(days: 1)),
          priority: TaskPriority.urgent,
          status: TaskStatus.inProgress,
          tags: ['review', 'documentation'],
        ),
        Task(
          id: '3',
          title: 'Update documentation',
          description: 'Update API documentation with latest changes and examples',
          category: 'Work',
          createdAt: now.subtract(const Duration(days: 3)),
          dueDate: now.subtract(const Duration(days: 1)),
          priority: TaskPriority.medium,
          status: TaskStatus.completed,
          tags: ['documentation', 'api'],
        ),
        Task(
          id: '4',
          title: 'Plan team meeting',
          description: 'Schedule and prepare agenda for weekly team standup meeting',
          category: 'Work',
          createdAt: now.subtract(const Duration(hours: 6)),
          dueDate: now.add(const Duration(days: 2)),
          priority: TaskPriority.low,
          status: TaskStatus.pending,
          tags: ['meeting', 'planning'],
        ),
        Task(
          id: '5',
          title: 'Research new technologies',
          description: 'Research and evaluate new frontend frameworks for upcoming projects',
          category: 'Learning',
          createdAt: now.subtract(const Duration(hours: 12)),
          dueDate: now.add(const Duration(days: 7)),
          priority: TaskPriority.medium,
          status: TaskStatus.pending,
          tags: ['research', 'technology'],
        ),
      ]);
      notifyListeners();
    }
  }
}
