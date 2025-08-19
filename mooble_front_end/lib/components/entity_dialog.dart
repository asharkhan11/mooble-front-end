import 'package:flutter/material.dart';

class EntityDialog<T> extends StatefulWidget {
  final T? entity;
  final Widget Function(BuildContext context, T? entity, void Function(T) onChanged) builder;
  final Future<bool> Function(T entity) onSave;

  const EntityDialog({
    Key? key,
    required this.entity,
    required this.builder,
    required this.onSave,
  }) : super(key: key);

  @override
  State<EntityDialog<T>> createState() => _EntityDialogState<T>();
}

class _EntityDialogState<T> extends State<EntityDialog<T>> {
  late T? _entity;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _entity = widget.entity;
  }

  void _onChanged(T entity) {
    setState(() {
      _entity = entity;
    });
  }

  Future<void> _onSave() async {
    if (_entity == null) return;
    setState(() => _saving = true);
    final success = await widget.onSave(_entity!);
    setState(() => _saving = false);
    if (success && mounted) {
      Navigator.of(context).pop(true);
    } else {
      // Show error or handle failure if needed
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: widget.builder(context, _entity, _onChanged),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _saving ? null : _onSave,
          child: _saving
              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
              : const Text('Save'),
        ),
      ],
    );
  }
}
