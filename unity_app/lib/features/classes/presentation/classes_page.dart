import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unity_app/features/classes/domain/class_entity.dart';
import 'package:unity_app/features/classes/presentation/bloc/classes_bloc.dart';
import 'package:unity_app/features/classes/presentation/bloc/classes_event.dart';
import 'package:unity_app/features/classes/presentation/bloc/classes_state.dart';

class ClassesPage extends StatelessWidget {
  const ClassesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aulas'),
        centerTitle: false,
      ),
      body: BlocBuilder<ClassesBloc, ClassesState>(
        builder: (context, state) {
          if (state is ClassesLoading || state is ClassesInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ClassesError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () => context
                        .read<ClassesBloc>()
                        .add(ClassesLoadRequested()),
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            );
          }

          if (state is ClassesLoaded) {
            if (state.classes.isEmpty) {
              return const Center(child: Text('Nenhuma aula disponível.'));
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.classes.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return _ClassCard(classEntity: state.classes[index]);
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _ClassCard extends StatelessWidget {
  final ClassEntity classEntity;

  const _ClassCard({required this.classEntity});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              classEntity.title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            if (classEntity.description.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                classEntity.description,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: [
                if (classEntity.instructor.isNotEmpty)
                  _InfoChip(
                    icon: Icons.person_outline,
                    label: classEntity.instructor,
                  ),
                if (classEntity.scheduledAt.isNotEmpty)
                  _InfoChip(
                    icon: Icons.schedule_outlined,
                    label: classEntity.scheduledAt,
                  ),
                if (classEntity.duration != null)
                  _InfoChip(
                    icon: Icons.timer_outlined,
                    label: '${classEntity.duration} min',
                  ),
                if (classEntity.availableSpots != null)
                  _InfoChip(
                    icon: Icons.event_seat_outlined,
                    label: '${classEntity.availableSpots} vagas',
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: colorScheme.onSurfaceVariant),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }
}
