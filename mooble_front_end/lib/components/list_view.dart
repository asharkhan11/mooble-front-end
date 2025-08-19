import 'package:flutter/material.dart';

class GenericListPage<T> extends StatefulWidget {
  final Future<List<T>> Function() fetchData;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final String title;
  final IconData? emptyIcon;

  const GenericListPage({
    super.key,
    required this.fetchData,
    required this.itemBuilder,
    this.title = '',
    this.emptyIcon,
  });

  @override
  State<GenericListPage<T>> createState() => _GenericListPageState<T>();
}

class _GenericListPageState<T> extends State<GenericListPage<T>> {
  late Future<List<T>> _futureList;

  @override
  void initState() {
    super.initState();
    _futureList = widget.fetchData();
  }

  Future<void> _refreshList() async {
    setState(() {
      _futureList = widget.fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 2,
      ),
      body: FutureBuilder<List<T>>(
        future: _futureList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(strokeWidth: 3),
            );
          }

          if (snapshot.hasError) {
            return _buildErrorView(snapshot.error.toString());
          }

          final data = snapshot.data ?? [];
          if (data.isEmpty) {
            return _buildEmptyView();
          }

          return RefreshIndicator(
            onRefresh: _refreshList,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(12),
              itemCount: data.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                return AnimatedOpacity(
                  opacity: 1.0,
                  duration: Duration(milliseconds: 300 + (index * 50)),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha((0.05 * 255).toInt()),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: widget.itemBuilder(context, data[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(widget.emptyIcon ?? Icons.inbox,
              size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 12),
          const Text(
            "No items found",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(String errorMessage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 80, color: Colors.red.shade300),
            const SizedBox(height: 12),
            Text(
              "Something went wrong",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.red.shade400,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _refreshList,
              icon: const Icon(Icons.refresh),
              label: const Text("Retry"),
            ),
          ],
        ),
      ),
    );
  }
}