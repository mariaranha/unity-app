import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unity_app/features/auth/presentation/cubit/user_cubit.dart';
import 'package:unity_app/features/auth/presentation/cubit/user_state.dart';
import 'package:unity_app/features/classes/domain/book_class_usecase.dart';
import 'package:unity_app/features/classes/domain/cancel_class_usecase.dart';
import 'package:unity_app/features/classes/domain/class_entity.dart';
import 'package:unity_app/features/classes/presentation/bloc/book_bloc.dart';
import 'package:unity_app/features/classes/presentation/bloc/book_event.dart';
import 'package:unity_app/features/classes/presentation/bloc/book_state.dart';
import 'package:unity_app/features/classes/presentation/bloc/classes_bloc.dart';
import 'package:unity_app/features/classes/presentation/bloc/classes_event.dart';
import 'package:unity_app/features/classes/presentation/bloc/classes_state.dart';

class ClassesPage extends StatelessWidget {
  final BookClassUseCase bookClassUseCase;
  final CancelClassUseCase cancelClassUseCase;

  const ClassesPage({
    super.key,
    required this.bookClassUseCase,
    required this.cancelClassUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookBloc(
        bookClassUseCase: bookClassUseCase,
        cancelClassUseCase: cancelClassUseCase,
      ),
      child: BlocListener<BookBloc, BookState>(
        listener: (context, state) {
          if (state is BookSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.read<ClassesBloc>().add(ClassesLoadRequested());
          }
          if (state is BookFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Scaffold(
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

                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<ClassesBloc>().add(ClassesLoadRequested());
                    await context.read<ClassesBloc>().stream.firstWhere(
                          (s) => s is ClassesLoaded || s is ClassesError,
                        );
                  },
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.classes.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return _ClassCard(classEntity: state.classes[index]);
                    },
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
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
    final userState = context.read<UserCubit>().state;
    final userId = userState is UserLoaded ? userState.user.id : null;

    return BlocBuilder<BookBloc, BookState>(
      builder: (context, bookState) {
        final isLoading =
            bookState is BookLoading && bookState.classId == classEntity.id;
        final hasReservation =
            userId != null && classEntity.reservedUserIds.contains(userId);

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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        classEntity.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      height: 32,
                      child: isLoading
                          ? const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            )
                          : hasReservation
                              ? OutlinedButton(
                                  onPressed: bookState is BookLoading
                                      ? null
                                      : () {
                                          context.read<BookBloc>().add(
                                                CancelClassRequested(
                                                    classEntity.id),
                                              );
                                        },
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                  ),
                                  child: const Text('Cancelar reserva'),
                                )
                              : FilledButton.tonal(
                                  onPressed: bookState is BookLoading
                                      ? null
                                      : () {
                                          context.read<BookBloc>().add(
                                                BookClassRequested(
                                                    classEntity.id),
                                              );
                                        },
                                  style: FilledButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                  ),
                                  child: const Text('Reservar'),
                                ),
                    ),
                  ],
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
                    _InfoChip(
                      icon: Icons.person_outline,
                      label: classEntity.teacherName,
                    ),
                    _InfoChip(
                      icon: Icons.schedule_outlined,
                      label: _formatDate(classEntity.date),
                    ),
                    _InfoChip(
                      icon: Icons.event_seat_outlined,
                      label: '${classEntity.availableSpots} vagas',
                    ),
                    if (classEntity.waitlistCount > 0)
                      _InfoChip(
                        icon: Icons.hourglass_empty_outlined,
                        label: '${classEntity.waitlistCount} na fila',
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatDate(String isoDate) {
    try {
      final dt = DateTime.parse(isoDate).toLocal();
      final day = dt.day.toString().padLeft(2, '0');
      final month = dt.month.toString().padLeft(2, '0');
      final hour = dt.hour.toString().padLeft(2, '0');
      final minute = dt.minute.toString().padLeft(2, '0');
      return '$day/$month • $hour:$minute';
    } catch (_) {
      return isoDate;
    }
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
