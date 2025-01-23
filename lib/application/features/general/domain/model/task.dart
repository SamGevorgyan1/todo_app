class Task {
  final int? id;
  final String? title;
  final String? description;
  final bool? isActive;

  const Task({
    this.id,
    this.title,
    this.description,
    this.isActive,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isActive': isActive ?? false ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'] as String?,
      description: map['description'] as String?,
      isActive: map['isActive'] == 1,
    );
  }

  Task copyWith({
    int? id,
    String? title,
    String? description,
    bool? isActive,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
    );
  }
}
