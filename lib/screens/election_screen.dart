import 'package:flutter/material.dart';
import 'package:housing_society_management/models/election.dart';
import 'package:housing_society_management/models/society.dart';
import 'package:housing_society_management/services/election_service.dart';
// import 'models.dart';
// import 'election_service.dart';

class ElectionScreen extends StatefulWidget {
  final ElectionService electionService = ElectionService();

  // ElectionScreen({required this.electionService});

  @override
  _ElectionScreenState createState() => _ElectionScreenState();
}

class _ElectionScreenState extends State<ElectionScreen> {
  List<Election> _elections = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchElections();
  }

  Future<void> _fetchElections() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final elections = await widget.electionService.getAllElections();
      setState(() {
        _elections = elections;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      // Handle error
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to fetch elections.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  Future<void> _createElection() async {
    // Show a form to input election details
    final election = await showDialog<Election>(
      context: context,
      builder: (ctx) => ElectionFormDialog(),
    );

    if (election != null) {
      try {
        await widget.electionService.createElection(
          title: election.title,
          startDate: election.startDate,
          endDate: election.endDate,
          societyId: election.societyId,
        );

        // Refresh the list of elections
        await _fetchElections();

        // Show a success message
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Success'),
            content: Text('Election created successfully.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      } catch (error) {
        // Handle error
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to create election.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      }
    }
  }

  Future<void> _updateElection(Election election) async {
    // Show a form to update election details
    final updatedElection = await showDialog<Election>(
      context: context,
      builder: (ctx) => ElectionFormDialog(election: election),
    );

    if (updatedElection != null) {
      try {
        await widget.electionService.updateElection(updatedElection);

        // Refresh the list of elections
        await _fetchElections();

        // Show a success message
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Success'),
            content: Text('Election updated successfully.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      } catch (error) {
        // Handle error
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to update election.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      }
    }
  }

  Future<void> _deleteElection(Election election) async {
    // Show a confirmation dialog to confirm deletion
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Confirm'),
        content: Text('Are you sure you want to delete this election?'),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(ctx).pop(false);
            },
          ),
          TextButton(
            child: Text('Delete'),
            onPressed: () {
              Navigator.of(ctx).pop(true);
            },
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await widget.electionService.deleteElection(election.id);

        // Refresh the list of elections
        await _fetchElections();

        // Show a success message
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Success'),
            content: Text('Election deleted successfully.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      } catch (error) {
        // Handle error
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to delete election.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Elections'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _elections.length,
              itemBuilder: (ctx, index) {
                final election = _elections[index];
                return ListTile(
                  title: Text(election.title),
                  subtitle:
                      Text('Start Date: ${election.startDate.toString()}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteElection(election);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _createElection,
      ),
    );
  }
}

class ElectionFormDialog extends StatefulWidget {
  final Election? election;

  ElectionFormDialog({this.election});

  @override
  _ElectionFormDialogState createState() => _ElectionFormDialogState();
}

class _ElectionFormDialogState extends State<ElectionFormDialog> {
  late TextEditingController _titleController;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.election?.title);
    _startDateController =
        TextEditingController(text: widget.election?.startDate.toString());
    _endDateController =
        TextEditingController(text: widget.election?.endDate.toString());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final title = _titleController.text;
    final startDate = DateTime.parse(_startDateController.text);
    final endDate = DateTime.parse(_endDateController.text);

    final updatedElection = Election(
      id: widget.election?.id ?? 0,
      title: title,
      startDate: startDate,
      endDate: endDate,
      societyId: widget.election?.societyId ?? 0,
      society: Society(
        id: widget.election?.societyId ?? 0,
        name: '',
        address: '',
        adminId: 0,
        admin: null,
        properties: [],
        propertyVariants: [],
        expenses: [],
      ),
      committeeMembers: [],
      nominees: [],
      votes: [],
    );

    Navigator.of(context).pop(updatedElection);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          Text(widget.election == null ? 'Create Election' : 'Update Election'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextFormField(
            controller: _startDateController,
            decoration: InputDecoration(labelText: 'Start Date'),
          ),
          TextFormField(
            controller: _endDateController,
            decoration: InputDecoration(labelText: 'End Date'),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Save'),
          onPressed: _saveForm,
        ),
      ],
    );
  }
}
