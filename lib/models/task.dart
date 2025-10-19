class Task {
  final String id;
  final String title;
  final String description;
  final String category;
  final DateTime createdAt;
  final DateTime? dueDate;
  final TaskPriority priority;
  final TaskStatus status;
  final List<String> tags;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.createdAt,
    this.dueDate,
    this.priority = TaskPriority.medium,
    this.status = TaskStatus.pending,
    this.tags = const [],
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    DateTime? createdAt,
    DateTime? dueDate,
    TaskPriority? priority,
    TaskStatus? status,
    List<String>? tags,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'createdAt': createdAt.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
      'priority': priority.name,
      'status': status.name,
      'tags': tags,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      createdAt: DateTime.parse(json['createdAt']),
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
      priority: TaskPriority.values.firstWhere(
        (e) => e.name == json['priority'],
        orElse: () => TaskPriority.medium,
      ),
      status: TaskStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => TaskStatus.pending,
      ),
      tags: List<String>.from(json['tags'] ?? []),
    );
  }
}

enum TaskPriority {
  low,
  medium,
  high,
  urgent,
}

enum TaskStatus {
  pending,
  inProgress,
  completed,
  cancelled,
}

extension TaskPriorityExtension on TaskPriority {
  String get displayName {
    switch (this) {
      case TaskPriority.low:
        return 'Low';
      case TaskPriority.medium:
        return 'Medium';
      case TaskPriority.high:
        return 'High';
      case TaskPriority.urgent:
        return 'Urgent';
    }
  }

  int get value {
    switch (this) {
      case TaskPriority.low:
        return 1;
      case TaskPriority.medium:
        return 2;
      case TaskPriority.high:
        return 3;
      case TaskPriority.urgent:
        return 4;
    }
  }
}

extension TaskStatusExtension on TaskStatus {
  String get displayName {
    switch (this) {
      case TaskStatus.pending:
        return 'Pending';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.completed:
        return 'Completed';
      case TaskStatus.cancelled:
        return 'Cancelled';
    }
  }
}
