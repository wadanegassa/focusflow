import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/screens/tasks_screen.dart';
import '../models/task.dart';
import '../services/task_service.dart';
import 'add_edit_task_screen.dart';

class TaskDetailsScreen extends StatelessWidget {
  final Task task;

  const TaskDetailsScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditTaskScreen(task: task),
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'edit':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEditTaskScreen(task: task),
                    ),
                  );
                  break;
                case 'delete':
                  _showDeleteDialog(context);
                  break;
                case 'toggle':
                  context.read<TaskService>().toggleTaskStatus(task.id);
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(width: 8),
                    Text('Edit Task'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'toggle',
                child: Row(
                  children: [
                    Icon(task.status == TaskStatus.completed 
                        ? Icons.undo 
                        : Icons.check),
                    const SizedBox(width: 8),
                    Text(task.status == TaskStatus.completed 
                        ? 'Mark as Incomplete' 
                        : 'Mark as Complete'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Delete Task', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isTablet ? 24 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Task Header
            Card(
              child: Padding(
                padding: EdgeInsets.all(isTablet ? 24 : 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            task.title,
                            style: TextStyle(
                              fontSize: isTablet ? 28 : 24,
                              fontWeight: FontWeight.bold,
                              decoration: task.status == TaskStatus.completed
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                        ),
                        _buildStatusChip(task.status),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      task.description,
                      style: TextStyle(
                        fontSize: isTablet ? 16 : 14,
                        color: Colors.grey[600],
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Task Information
            Card(
              child: Padding(
                padding: EdgeInsets.all(isTablet ? 24 : 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Task Information',
                      style: TextStyle(
                        fontSize: isTablet ? 20 : 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    _buildInfoRow(
                      'Category',
                      task.category,
                      Icons.category,
                      Colors.blue,
                    ),
                    const SizedBox(height: 12),
                    
                    _buildInfoRow(
                      'Priority',
                      task.priority.displayName,
                      Icons.flag,
                      _getPriorityColor(task.priority),
                    ),
                    const SizedBox(height: 12),
                    
                    _buildInfoRow(
                      'Status',
                      task.status.displayName,
                      _getStatusIcon(task.status),
                      _getStatusColor(task.status),
                    ),
                    const SizedBox(height: 12),
                    
                    _buildInfoRow(
                      'Created',
                      _formatDate(task.createdAt),
                      Icons.calendar_today,
                      Colors.grey,
                    ),
                    
                    if (task.dueDate != null) ...[
                      const SizedBox(height: 12),
                      _buildInfoRow(
                        'Due Date',
                        _formatDate(task.dueDate!),
                        Icons.schedule,
                        _getDueDateColor(task.dueDate!),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            
            if (task.tags.isNotEmpty) ...[
              const SizedBox(height: 20),
              
              // Tags
              Card(
                child: Padding(
                  padding: EdgeInsets.all(isTablet ? 24 : 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tags',
                        style: TextStyle(
                          fontSize: isTablet ? 20 : 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: task.tags.map((tag) => _buildTagChip(tag)).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            
            const SizedBox(height: 20),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      context.read<TaskService>().toggleTaskStatus(task.id);
                    },
                    icon: Icon(task.status == TaskStatus.completed 
                        ? Icons.undo 
                        : Icons.check),
                    label: Text(task.status == TaskStatus.completed 
                        ? 'Mark Incomplete' 
                        : 'Mark Complete'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: task.status == TaskStatus.completed 
                          ? Colors.orange 
                          : Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddEditTaskScreen(task: task),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit Task'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(TaskStatus status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _getStatusColor(status).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _getStatusColor(status)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getStatusIcon(status),
            size: 16,
            color: _getStatusColor(status),
          ),
          const SizedBox(width: 4),
          Text(
            status.displayName,
            style: TextStyle(
              color: _getStatusColor(status),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 12),
        Text(
          '$label:',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTagChip(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Text(
        tag,
        style: const TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Color _getStatusColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.pending:
        return Colors.grey;
      case TaskStatus.inProgress:
        return Colors.blue;
      case TaskStatus.completed:
        return Colors.green;
      case TaskStatus.cancelled:
        return Colors.red;
    }
  }

  IconData _getStatusIcon(TaskStatus status) {
    switch (status) {
      case TaskStatus.pending:
        return Icons.radio_button_unchecked;
      case TaskStatus.inProgress:
        return Icons.play_circle_outline;
      case TaskStatus.completed:
        return Icons.check_circle;
      case TaskStatus.cancelled:
        return Icons.cancel;
    }
  }

  Color _getPriorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return Colors.green;
      case TaskPriority.medium:
        return Colors.blue;
      case TaskPriority.high:
        return Colors.orange;
      case TaskPriority.urgent:
        return Colors.red;
    }
  }

  Color _getDueDateColor(DateTime dueDate) {
    final now = DateTime.now();
    if (dueDate.isBefore(now) && !dueDate.isSameDay(now)) {
      return Colors.red;
    } else if (dueDate.isSameDay(now)) {
      return Colors.orange;
    } else {
      return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.isSameDay(now)) {
      return 'Today';
    } else if (date.isSameDay(now.subtract(const Duration(days: 1)))) {
      return 'Yesterday';
    } else if (date.isSameDay(now.add(const Duration(days: 1)))) {
      return 'Tomorrow';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: Text('Are you sure you want to delete "${task.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<TaskService>().deleteTask(task.id);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

